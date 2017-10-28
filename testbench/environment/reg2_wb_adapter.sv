`ifndef REG2WB_ADAPTER
`define REG2WB_ADAPTER

//Register Adapter
//`include "wishbone_package.sv"

class reg2wb_adapter extends uvm_reg_adapter;
`uvm_object_utils(reg2wb_adapter);

function new(string name = "reg2wb_adapter");
	super.new(name);
	supports_byte_enable = 0;
  provides_responses = 0;
endfunction

virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
wb_seq_item wb_signal = wb_seq_item::type_id::create("wb_signal");
//wb_signal.wb_dat_i = rw.addr;
//wb_signal.wb_adr_i = rw.data;
wb_signal.wb_dat_i = rw.data;
wb_signal.wb_adr_i = rw.addr;
wb_signal.wb_we_i  = (rw.kind == UVM_WRITE)?WRITE:READ;
return wb_signal;
endfunction

virtual function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
wb_seq_item wb_trans;

if (!$cast(wb_trans,bus_item)) begin 
`uvm_error("reg2wb_adapter","Bus item not found")
return;
end 

rw.kind = wb_trans.wb_we_i ? UVM_WRITE : UVM_READ;
rw.addr = wb_trans.wb_adr_i;
rw.data = wb_trans.wb_dat_i;
endfunction


endclass

`endif
