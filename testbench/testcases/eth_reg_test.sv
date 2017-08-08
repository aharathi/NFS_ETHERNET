`ifndef ETH_REG_TEST
`define ETH_REG_TEST

class eth_reg_test extends eth_base_test;
`uvm_component_utils(eth_reg_test)

string m_name = "eth_reg_test";

function new (string name = m_name, uvm_component parent = null);
super.new(name,parent);
endfunction

extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass 

function void eth_reg_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

task eth_reg_test::run_phase(uvm_phase phase);
eth_reg_write_seq reg_wr_seq = eth_reg_write_seq::type_id::create("reg_wr_seq");

phase.raise_objection(this,"Starting reg_wr_seq");
reg_wr_seq.start(m_env.m_wb_agent.m_sequencer);
`uvm_info({m_name,"::build_phase"},"wating for 2000 clock cycles before dropping objection",UVM_DEBUG)
wait_n_clks(2000);
phase.drop_objection(this,"Ending reg_wr_seq");
endtask

`endif


