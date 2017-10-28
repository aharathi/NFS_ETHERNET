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
int unsigned tx_buf_num;

function new (string name = m_name);
super.new(name);
endfunction

task body;
super.body;

`uvm_info({m_name,"::body"},"starting the register write sequence",UVM_DEBUG)


eth_rm.moder_reg.RXEN.set(1);
eth_rm.moder_reg.TXEN.set(1);
eth_rm.moder_reg.PRO.set(1);
//enable Full Duplex 
eth_rm.moder_reg.FULLD.set(1);
eth_rm.moder_reg.update(status,.path(UVM_FRONTDOOR),.parent(this));
if ($value$plusargs("TX_BD_NUM=%h",tx_buf_num)) begin //{
//`uvm_info({my_name,"::build function"},$sformatf("Got the number of buffer desctipters %0d",tx_buf_num),UVM_DEBUG)
eth_rm.tx_bd_num_reg.write(status,tx_buf_num,.parent(this));
end //}
else begin //{
eth_rm.tx_bd_num_reg.write(status,8'h40,.parent(this));
end //}

//eth_rm.tx_pntr_reg[0].PNTR.set(32'h0);
//eth_rm.tx_pntr_reg[0].update(status,.path(UVM_FRONTDOOR),.parent(this));
//`uvm_info({m_name,"::body"},"ashwin - update",UVM_DEBUG)
//eth_rm.tx_pntr_reg[0].PNTR.write(status,32'h0,.parent(this));

//`uvm_info({m_name,"::body"},"ashwin - update",UVM_DEBUG)
//eth_rm.tx_bd_num_reg.update(status,.path(UVM_FRONTDOOR),.parent(this));

endtask
endclass
`endif



`ifndef ETH_MAC_SEQ
`define ETH_MAC_SEQ
//class eth_mac_seq extends uvm_sequence #(uvm_sequence_item);
class eth_mac_seq extends eth_reg_seq;
`uvm_object_utils(eth_mac_seq)

string m_name = "eth_mac_seq";

eth_mac_pkt mac_pkt;

function new (string name = m_name);
super.new(name);
endfunction

task body;
mac_pkt = eth_mac_pkt::type_id::create("mac_pkt");

super.body;

//eth_rm.tx_pntr_reg[0].PNTR.set(32'h0);
//eth_rm.tx_pntr_reg[0].update(status,.path(UVM_FRONTDOOR),.parent(this));

eth_rm.tx_pntr_reg[0].write(status,32'h0,.parent(this));
eth_rm.buff_d_tx_reg[0].LEN.set(16'h266);
eth_rm.buff_d_tx_reg[0].WR.set(1);
eth_rm.buff_d_tx_reg[0].RD.set(1);
eth_rm.buff_d_tx_reg[0].update(status,.path(UVM_FRONTDOOR),.parent(this));


//mac_pkt = eth_mac_pkt::type_id::create("mac_pkt");


for (int i = 1;i <= 10000;i++) begin //{
`uvm_info({m_name,"::body"},$sformatf("Sending Packet %0d",i),UVM_DEBUG)
start_item(mac_pkt);
assert (mac_pkt.randomize());
`uvm_info({m_name,"::body"},$sformatf("Randomized the mac packet %s",mac_pkt.conv2str()),UVM_DEBUG)
finish_item(mac_pkt);
end //}

endtask 
endclass 
`endif

