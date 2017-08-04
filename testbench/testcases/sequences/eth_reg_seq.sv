import uvm_pkg::*;
`include "uvm_macros.svh"


`ifndef eth_reg_seq
`define eth_reg_seq
class eth_reg_seq extends uvm_sequence#(uvm_sequence_item);
`uvm_object_utils(eth_reg_seq)

string m_name = "eth_reg_seq";
eth_reg_block eth_rm;


function new (string name = m_name);
super.new(name);
endfunction

task body;
`assert(uvm_config_db#(eth_reg_block)::get(this,"","eth_reg_block",eth_rm)) `uvm_error(m_name,"body method REG MODEL not found")
endtask
endclass
`endif
