`include "../testbench/environment/wishbone_defines.sv"

module Memory_TxRxData 
(
	ethmac_if_pins slave_port, mem_backdoor_if_pins bck_door
);

/*------------------------------------------------------------------------------------------------------
Asynchronous dual-port RAM signals for storing and fetching the data
------------------------------------------------------------------------------------------------------*/
logic `WB_DATA_TYPE RAM [4095:0];
logic `WB_DATA_TYPE mem_wr_data_out;
logic `WB_DATA_TYPE mem_rd_data_in;
logic `WB_DATA_TYPE task_mem_wr_data;
logic `WB_ADDR_TYPE temp_m_wb_adr_o;
/*------------------------------------------------------------------------------------------------------
Maximum values for WAIT and RETRY counters and which response !!!
------------------------------------------------------------------------------------------------------*/
logic     [2:0]  a_e_r_resp; // tells with which cycle_termination_signal must wb_slave respond !
logic     [3:0]  wait_cyc;
logic     [7:0]  max_retry;
logic    `WB_ADDR_TYPE task_wr_adr_i;		//From UVM Tb, Write address to which data is written
logic    `WB_ADDR_TYPE task_rd_adr_i;		//From UVM Tb, Read address from which data can be read
logic    `WB_DATA_TYPE task_dat_i;			//From UVM Tb, to write data into memory. This must be Block of data: 60 Bytes minimum
logic    `WB_DATA_TYPE task_dat_o;			//From UVM Tb, to read data from memory.
logic    `WB_SEL_TYPE  task_sel_i;			//select byte control signal
logic                  task_wr_data;		//From UVM Tb, to start loading data, this is the write control
logic                  task_data_written;	//completion of write data.

// assign registers to default state while in reset
always_ff@(posedge slave_port.wb_clk_i or posedge slave_port.wb_rst_i) begin
	if (slave_port.wb_rst_i) begin
		a_e_r_resp <= 3'b000; // do not respond
		wait_cyc   <= 4'b0; // no wait cycles
		max_retry  <= 8'h0; // no retries
	end
	else begin 
		a_e_r_resp <= 3'b100; // do not respond
		wait_cyc   <= 4'h2; // no wait cycles
		max_retry  <= 8'h2; // no retries
	end 
end //reset


/*------------------------------------------------------------------------------------------------------
Internal signals and logic
------------------------------------------------------------------------------------------------------*/
logic            calc_ack;
logic            calc_err;
logic            calc_rty;

// Retry counter
logic     [7:0]  retry_cnt;
logic     [7:0]  retry_num;
logic            retry_expired;

always_ff@(posedge slave_port.wb_rst_i or posedge slave_port.wb_clk_i) begin
  if (slave_port.wb_rst_i) 
    retry_cnt <= #1 8'h00;
  else  begin
    if (calc_ack || calc_err)
      retry_cnt <= #1 8'h00;
    else if (calc_rty)
      retry_cnt <= #1 retry_num;
  end
end

//always_ff@(posedge retry_cnt or posedge max_retry) begin
always_ff@(posedge slave_port.wb_rst_i or posedge slave_port.wb_clk_i) begin
if ( slave_port.wb_rst_i) begin
retry_num = 'b0;
retry_expired = 1'b0;
end 
else begin 
  if (retry_cnt < max_retry)  begin
    retry_num = retry_cnt + 1'b1;
    retry_expired = 1'b0;
  end
  else  begin
    retry_num = retry_cnt;
    retry_expired = 1'b1;
  end
end
end

// Wait counter
logic     [3:0]  wait_cnt;
logic     [3:0]  wait_num;
logic	         wait_expired;

always_ff@(posedge slave_port.wb_rst_i or posedge slave_port.wb_clk_i) begin
  if (slave_port.wb_rst_i)
    wait_cnt <= #1 4'h0;
  else  begin
    if (wait_expired || ~slave_port.m_wb_stb_o)
      wait_cnt <= #1 4'h0;
    else
      wait_cnt <= #1 wait_num;
  end
end

always_comb begin
  if ((wait_cyc > 0) && (slave_port.m_wb_stb_o))  begin
    
	if (wait_cnt < wait_cyc) begin	// 4'h2  
      wait_num = wait_cnt + 1'b1;
      wait_expired = 1'b0;
      calc_ack = 1'b0;
      calc_err = 1'b0;
      calc_rty = 1'b0;
    end
    
	else begin
      wait_num = wait_cnt;
      wait_expired = 1'b1;
      if (a_e_r_resp == 3'b100) begin
        calc_ack = 1'b1;
        calc_err = 1'b0;
        calc_rty = 1'b0;
      end
      
	  else if (a_e_r_resp == 3'b010) begin
        calc_ack = 1'b0;
        calc_err = 1'b1;
        calc_rty = 1'b0;
      end
      
	  else if (a_e_r_resp == 3'b001) begin
        calc_err = 1'b0;
        if (retry_expired) begin
          calc_ack = 1'b1;
          calc_rty = 1'b0;
        end
        else begin
          calc_ack = 1'b0;
          calc_rty = 1'b1;
        end
      end
      
	  else begin
        calc_ack = 1'b0;
        calc_err = 1'b0;
        calc_rty = 1'b0;
      end
    end
  end
  
  else  if ((wait_cyc == 0) && (slave_port.m_wb_stb_o))  begin
    wait_num = 2'h0;
    wait_expired = 1'b1;
    
	if (a_e_r_resp == 3'b100) begin
      calc_ack = 1'b1;
      calc_err = 1'b0;
      calc_rty = 1'b0;
    end
    
	else if (a_e_r_resp == 3'b010) begin
      calc_ack = 1'b0;
      calc_err = 1'b1;
      calc_rty = 1'b0;
    end
    
	else if (a_e_r_resp == 3'b001) begin
      calc_err = 1'b0;
      if (retry_expired) begin
        calc_ack = 1'b1;
        calc_rty = 1'b0;
      end
      else begin
        calc_ack = 1'b0;
        calc_rty = 1'b1;
      end
    end
    
	else begin
      calc_ack = 1'b0;
      calc_err = 1'b0;
      calc_rty = 1'b0;
    end
  end
  
  else begin
    wait_num = 2'h0;
    wait_expired = 1'b0;
    calc_ack = 1'b0;
    calc_err = 1'b0;
    calc_rty = 1'b0;
  end
end

wire rd_sel = (slave_port.m_wb_cyc_o && slave_port.m_wb_stb_o && ~slave_port.m_wb_we_o);
wire wr_sel = (slave_port.m_wb_cyc_o && slave_port.m_wb_stb_o && slave_port.m_wb_we_o);

// Generate cycle termination signals
assign slave_port.m_wb_ack_i = calc_ack && slave_port.m_wb_stb_o;
assign slave_port.m_wb_err_i = calc_err && slave_port.m_wb_stb_o;
assign slave_port.m_wb_rty_i = calc_rty && slave_port.m_wb_stb_o;

/* // Assign address to asynchronous memory
always_ff @(posedge slave_port.wb_clk_i or posedge slave_port.wb_rst_i) begin
  if (slave_port.wb_rst_i) begin	// this is added because at start of test bench we need address change in order to get data!
    mem_rd_data_in <= `WB_DATA_WIDTH'hxxxx_xxxx;
  end
  else begin
    mem_rd_data_in <= RAM[slave_port.m_wb_adr_o[21:2]];
  end
end */

/* // Data input/output interface
always_ff@(posedge rd_sel or posedge mem_rd_data_in or posedge slave_port.wb_rst_i) begin
  if (slave_port.wb_rst_i)
    slave_port.m_wb_dat_i <= #1 `WB_DATA_WIDTH'hxxxx_xxxx;	// assign outputs to unknown state while in reset
  else if (rd_sel)
    slave_port.m_wb_dat_i <= #1 mem_rd_data_in;
  else
    slave_port.m_wb_dat_i <= #1 `WB_DATA_WIDTH'hxxxx_xxxx;
end */


/* always_comb begin
  if (slave_port.wb_rst_i)
    task_dat_o 		= `WB_DATA_WIDTH'hxxxx_xxxx;
  else
	task_rd_adr_i 	= task_rd_adr_i << 2;
	if(task_rd_adr_i inside {[64:4095]})
    task_dat_o 		= RAM[task_rd_adr_i[21:2]];
end */

always_comb begin

if (bck_door.write) begin //{
RAM[bck_door.addr] = bck_door.temp_data;
end //}


/*   if (task_wr_data & (task_wr_adr_i inside {[0:63]})) begin  
    task_mem_wr_data = RAM[task_wr_adr_i[21:2]];
	
    if (task_sel_i[3])
      task_mem_wr_data[31:24] = task_dat_i[31:24];
    if (task_sel_i[2])
      task_mem_wr_data[23:16] = task_dat_i[23:16];
    if (task_sel_i[1])
      task_mem_wr_data[15: 8] = task_dat_i[15: 8];
    if (task_sel_i[0])
      task_mem_wr_data[ 7: 0] = task_dat_i[ 7: 0];

    RAM[task_wr_adr_i[21:2]] = task_mem_wr_data; // write data
    task_data_written = 1;	
  end
  
  else  */
  else begin //{
  if (wr_sel && ~slave_port.m_wb_ack_i) begin 	//{			// if no SEL_I is active, old value will be written
		if (slave_port.m_wb_sel_o[3])
		  RAM[slave_port.m_wb_adr_o][31:24] = slave_port.m_wb_dat_o[31:24];
		else if (slave_port.m_wb_sel_o[2])
		  RAM[slave_port.m_wb_adr_o][23:16] = slave_port.m_wb_dat_o[23:16];
		else if (slave_port.m_wb_sel_o[1])
		  RAM[slave_port.m_wb_adr_o][15:8]  = slave_port.m_wb_dat_o[15: 8];
		else if (slave_port.m_wb_sel_o[0])
		  RAM[slave_port.m_wb_adr_o][7:0]   = slave_port.m_wb_dat_o[ 7: 0];
  end //}
end //}

end

//assign task_wr_adr_i = task_wr_data?(task_wr_adr_i << 2):'bz;

endmodule
