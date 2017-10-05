


class mem_drv extends uvm_driver#(eth_mac_pkt);
`uvm_component_utils(mem_drv)

virtual mem_bckdoor_dr MEM_DR;
virtual intr_if INTR;

string m_name = "mem_driver";


function new (string name = m_name,uvm_component parent);
super.new(name,parent);
endfunction 

task run_phase(uvm_phase phase);

eth_mac_pkt e_mac_pkt;
bit pkt_stream[$];
int pkt_num=0;
int num_writes = 0;
static integer unsigned addr=0;
logic `WB_DATA_TYPE mem_data[9:0];


INTR.wait_for_rst();


`uvm_info({m_name,"::run_phase"},"started getting sequence items",UVM_DEBUG)

forever begin //{
seq_item_port.get_next_item(e_mac_pkt);
pkt_num++;
phase.raise_objection(this,"getting ETHERNET MAC PACKET");
`uvm_info({m_name,":run_phase"},$sformatf("Received packet number %0d %s",pkt_num,e_mac_pkt.conv2str()),UVM_DEBUG)
eth_mac_conv::from_class(e_mac_pkt,pkt_stream);
`uvm_info({m_name,":run_phase"},$sformatf("pkt stream size is %0d",pkt_stream.size()),UVM_DEBUG)
num_writes = (pkt_stream.size()/320);
`uvm_info({m_name,":run_phase"},$sformatf("num writes is %0d",num_writes),UVM_DEBUG)
for (int j = 0;j < num_writes;j++)begin //{
for (int i = 0;i < 10;i++) begin //{
mem_data[i] = {>>{pkt_stream[(i*`WB_DATA_WIDTH):(((i+1)*32) - 1)]}};
`uvm_info({m_name,":run_phase"},$sformatf("Memory data is %0h",mem_data[i]),UVM_DEBUG)
end //}
MEM_DR.write(mem_data,addr);
addr += 32'd10;
pkt_stream = pkt_stream[320:$];
end //}
//MEM_DR.write(mem_data,addr);
//addr += 32'd10;
if ((pkt_stream.size()) > 0) begin //{
integer unsigned num_rem_writes = (pkt_stream.size()/`WB_DATA_WIDTH);
`uvm_info({m_name,":run_phase"},$sformatf("num rem writes is %0d",num_rem_writes),UVM_DEBUG)
for (int i=0;i< num_rem_writes;i++) begin //{
mem_data[i] = {>>{pkt_stream[(i*`WB_DATA_WIDTH):(((i+1)*32) - 1)]}};
`uvm_info({m_name,":run_phase"},$sformatf("Memory data is %0h",mem_data[i]),UVM_DEBUG)
pkt_stream = pkt_stream[(num_rem_writes*`WB_DATA_WIDTH):$];
end //}
addr += num_rem_writes;
if ((pkt_stream.size()) > 0) begin //{
mem_data[num_rem_writes] = {>>{pkt_stream}};
addr += 32'd1;
end//}
end //}
seq_item_port.item_done();
phase.drop_objection(this,"done with ETHERNET MAC PACKET");
end //}
endtask 
endclass 


class eth_mac_sequencer extends uvm_sequencer #(eth_mac_pkt,eth_mac_pkt);
`uvm_component_utils(eth_mac_sequencer)

function new(string name="eth_mac_sequencer",uvm_component parent = null);
super.new(name,parent);
endfunction 
endclass 

