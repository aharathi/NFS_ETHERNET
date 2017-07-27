`include "wishbone_package.sv"

interface wb_master_driver_if (ethmac_pif bus);

//
// Reset task
//

task wb_reset();

 initial begin
	
	


 end
 
endtask
//
// Hand-shaking task
//

//
// To read the the slave contents from the master driver through read task
//

task read (output wb_sl_seq_s ms_rsp);
 
 @(posedge bus.wb_clk_i);  // To be in synchronous with the wishbone clock
 
 // Observe the slave outputs
 
 ms_rsp.wb_dat_i = bus.wb_dat_o;
 ms_rsp.wb_dat_o = bus.wb_dat_i;
 ms_rsp.wb_err_o = bus.wb_err_o;
 
 ms_rsp.wb_adr_i = bus.wb_adr_i[11:2];
 ms_rsp.wb_sel_i = bus.wb_sel_i;
 ms_rsp.wb_we_i  = bus.wb_we_i;
 ms_rsp.wb_cyc_i = bus.wb_cyc_i;
 ms_rsp.wb_stb_i = bus.wb_stb_i;
 ms_rsp.wb_ack_o = bus.wb_ack_o;


endtask

//
// To write the contents to registers or buffer descriptors through write task
//

task write (input wb_sl_seq_s ms_req);

 @(posedge bus.wb_clk_i); // To be in synchronous with the wishbone clock
 
 // Drive the inputs of the slave 
 
 bus.wb_dat_i = ms_req.wb_dat_o;
 bus.wb_adr_i = ms_req.wb_adr_i[11:2];
 bus.wb_sel_i = ms_req.wb_sel_i;
 bus.wb_we_i  = ms_req.wb_we_i;
 bus.wb_cyc_i = ms_req.wb_cyc_i;
 bus.wb_stb_i = ms_req.wb_stb_i;
 
 //Observe the slave outputs
 
 ms_req.wb_dat_i = bus.wb_dat_o;
 ms_req.wb_err_o = bus.wb_err_o;
 ms_req.wb_ack_o = bus.wb_ack_o;

endtask

endinterface