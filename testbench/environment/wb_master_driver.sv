`infdef WB_DRIVER
`define WB_DRIVER

`include "wishbone_package.sv"

class wb_driver extends uvm_driver #(wb_seq_item);
`uvm_component_utils(wb_driver)

virtual wb_master_driver_if BFM;

string my_name = "wb_driver";

function new (string name = my_name,uvm_component parent = null);
super.new(name,parent);
endfunction 

extern task run_phase(uvm_phase phase);

endclass

task wb_driver::run_phase(uvm_phase phase);

wb_seq_item wb_seq;
wb_sl_seq_s wb_req_s,wb_resp_s;


BFM.wait_for_reset();

forever begin
seq_item_port.get_next_item(wb_seq);
wb_seq_item_converter::from_class(wb_seq,wb_req_s);
if (wb_seq.r_w_t == READ) BFM.read(wb_req_s,wb_resp_s); else BFM.write(wb_req_s,wb_resp_s);
seq_item_port.item_done();
end 
endtask 



//typedef uvm_sequencer#(wb_seq_item,wb_seq_item) wb_sequencer;


class wb_sequencer extends uvm_sequencer#(wb_seq_item,wb_seq_item);
`uvm_component_utils(wb_sequencer)

function new (string name="wb_sequencer",uvm_component parent = null);
super.new(name,parent);
endfunction
endclass 


`endif
