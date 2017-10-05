
`ifndef ETH_MAC_TEST 
`define ETH_MAC_TEST

class eth_mac_test extends eth_reg_test;
`uvm_component_utils(eth_mac_test)

string m_name = "eth_mac_test";


function new(string name = m_name,uvm_component parent = null);
super.new(name,parent);
endfunction 

function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction 

task run_phase(uvm_phase phase);
eth_mac_seq  mac_seq = eth_mac_seq::type_id::create("mac_seq");
super.run_phase(phase);


phase.raise_objection(this,"starting the eth_mac_seq");
mac_seq.start(m_env.m_wb_agent.mac_sqr);
`uvm_info({m_name,"::build_phase"},"waiting for 3000 clock cycles dropping object",UVM_DEBUG)
wait_n_clks(3000);
phase.drop_objection(this,"Ending mac_seq");
endtask
endclass

`endif 
