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

`uvm_info({m_name,"::body"},"starting the register write sequence",UVM_DEBUG)

//enable Full Duplex 
eth_rm.moder_reg.FULLD.set(1);
eth_rm.moder_reg.update(status,.path(UVM_FRONTDOOR),.parent(this));

endtask
endclass
`endif



`ifndef ETH_MAC_SEQ
`define ETH_MAC_SEQ
class eth_mac_seq extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(eth_mac_seq)

string m_name = "eth_mac_seq";

eth_mac_pkt mac_pkt;

function new (string name = m_name);
super.new(name);
endfunction

task body;

mac_pkt = eth_mac_pkt::type_id::create("mac_pkt");

for (int i = 1;i <= 2;i++) begin //{
`uvm_info({m_name,"::body"},$sformatf("Sending Packet %0d",i),UVM_DEBUG)
start_item(mac_pkt);
assert (mac_pkt.randomize());
`uvm_info({m_name,"::body"},$sformatf("Randomized the mac packet %s",mac_pkt.conv2str()),UVM_DEBUG)
finish_item(mac_pkt);
end //}

endtask 
endclass 
`endif

