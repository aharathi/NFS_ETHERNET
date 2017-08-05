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

virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op reg_params);
wb_seq_item wb_signal = wb_seq_item::type_id::create("wb_signal");
wb_signal.wb_dat_i = reg_params.addr;
wb_signal.wb_adr_i = reg_params.data;
wb_signal.wb_we_i  = (reg_params.kind == UVM_WRITE)?WRITE:READ;
return wb_signal;
endfunction

endclass

`endif
