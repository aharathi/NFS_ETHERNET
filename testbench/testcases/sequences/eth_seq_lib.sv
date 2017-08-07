`ifndef ETH_REG_SEQ
`define ETH_REG_SEQ
class eth_reg_seq extends uvm_sequence#(uvm_sequence_item);
`uvm_object_utils(eth_reg_seq)

string m_name = "eth_reg_seq";
eth_reg_block eth_rm;
uvm_status_e status; //OK,NOT_OK,HAS_X


function new (string name = m_name);
super.new(name);
endfunction

task body;
//assert(uvm_config_db#(eth_reg_block)::get(this,"","eth_reg_block",eth_rm)) `uvm_error(m_name,"body method REG MODEL not found")
assert(uvm_config_db#(eth_reg_block)::get(null,get_full_name(),"eth_reg_block",eth_rm)) `uvm_info(m_name,"Got the Reg Block",UVM_INFO) else `uvm_error(m_name,"body method REG MODEL not found")
endtask
endclass
`endif


`ifndef  ETH_REG_WRITE_SEQ
`define  ETH_REG_WRITE_SEQ
class eth_reg_write_seq extends eth_reg_seq;
`uvm_object_utils(eth_reg_write_seq)

string m_name = "eth_reg_write_seq";

function new (string name = m_name);
super.new(name);
endfunction

task body;
super.body;

//enable Full Duplex 

eth_rm.moder_reg.FULLD.set(1);
eth_rm.moder_reg.update(status,.path(UVM_FRONTDOOR),.parent(this));

endtask
endclass
`endif
