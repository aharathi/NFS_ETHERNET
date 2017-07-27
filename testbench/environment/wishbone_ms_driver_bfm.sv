`include "wishbone_package.sv"

interface wb_master_driver_if (ethmac_pif bus);

initial 
begin

 bus.wb_adr_i = `WB_ADDR_WIDTH{1'bx};
 bus.wb_we_i  = 1'b0;
 bus.wb_cyc_i = 1'b0;
 bus.wb_stb_i = 1'b0;
 bus.wb_sel_i = `WB_SEL_WIDTH{1'bx};
 
 bus.wb_dat_o = `WB_DATA_WIDTH{1'bx};
 bus.wb_dat_i = `WB_DATA_WIDTH{1'bx};

end


//
// waiting for clock cycles
//

task wait_for_clkcyc();

 repeat(`RESET_CYCLES)@(posedge bus.wb_clk_i);
 
endtask

//
// wait for reset signal to go low
//

task wait_for_reset();

 @(negedge bus.wb_clk_i);
 
endtask

//
// To read the the slave contents from the master driver through read task
//

task read (input wb_sl_seq_s ms_req, output wb_sl_seq_s ms_rsp);
 
 @(posedge bus.wb_clk_i);  // To be in synchronous with the wishbone clock
 
 // Drive the inputs of slave to observe outputs
 
 bus.wb_adr_i = ms_req.wb_adr_i[11:2];
 bus.wb_we_i  = ms_req.wb_we_i;
 bus.wb_cyc_i = ms_req.wb_cyc_i;
 bus.wb_stb_i = ms_req.wb_stb_i;
 bus.wb_sel_i = ms_req.wb_sel_i;
 
 // Observe the slave outputs
 
 ms_rsp.wb_dat_i = bus.wb_dat_o;
 ms_rsp.wb_dat_o = bus.wb_dat_i;
 ms_rsp.wb_err_o = bus.wb_err_o;
 ms_rsp.wb_ack_o = bus.wb_ack_o;


endtask

//
// To write the contents to registers or buffer descriptors through write task
//

task write (input wb_sl_seq_s ms_req,output wb_sl_seq_s ms_rsp);

 @(posedge bus.wb_clk_i); // To be in synchronous with the wishbone clock
 
 // Drive the inputs of the slave 
 
 bus.wb_dat_i = ms_req.wb_dat_o;
 bus.wb_adr_i = ms_req.wb_adr_i[11:2];
 bus.wb_sel_i = ms_req.wb_sel_i;
 bus.wb_we_i  = ms_req.wb_we_i;
 bus.wb_cyc_i = ms_req.wb_cyc_i;
 bus.wb_stb_i = ms_req.wb_stb_i;
 
 //Observe the slave outputs
 
 ms_rsp.wb_dat_i = bus.wb_dat_o;
 ms_rsp.wb_err_o = bus.wb_err_o;
 ms_rsp.wb_ack_o = bus.wb_ack_o;

endtask

endinterface