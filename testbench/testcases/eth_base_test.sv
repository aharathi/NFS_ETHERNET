

`ifndef ETH_BASE_TEST 
`define ETH_BASE_TEST

class eth_base_test extends uvm_test;
`uvm_component_utils(eth_base_test)

string m_name = "eth_base_test";

eth_env m_env;

eth_env_config env_cfg;

wb_agent_config wb_agent_cfg;

eth_reg_block eth_reg_m;


function new(string name = m_name,uvm_component parent = null);
super.new(name,parent);
endfunction 

extern function void configure_wb_agent(wb_agent_config cfg);

extern function void build_phase(uvm_phase phase);

extern task wait_n_clks(int n=0);

endclass

function void eth_base_test::build_phase(uvm_phase phase);

env_cfg = eth_env_config::type_id::create("env_cfg");

eth_reg_m = eth_reg_block::type_id::create("eth_reg_m");

eth_reg_m.build();

uvm_config_db #(eth_reg_block)::set(this,"*","eth_reg_block",eth_reg_m);

env_cfg.eth_rm = eth_reg_m;

wb_agent_cfg = wb_agent_config::type_id::create("wb_agent_cfg");

configure_wb_agent(wb_agent_cfg);

assert(uvm_config_db #(virtual wb_master_driver_if)::get(null,"uvm_test_top","hdl_top.WB_DRIVER",wb_agent_cfg.WB_BFM)) `uvm_info (m_name,"Got the Driver Interface",UVM_INFO)  else `uvm_error (m_name,"build_phase did not find the driver interface")
assert(uvm_config_db #(virtual intr_if)::get(null,"uvm_test_top","hdl_top.INTR",env_cfg.DELAY_IF)) `uvm_info (m_name,"env config : Got the Interrupt Interface",UVM_INFO)  else `uvm_error (m_name,"build_phase did not find the Interrupt interface")
assert(uvm_config_db #(virtual intr_if)::get(null,"uvm_test_top","hdl_top.INTR",wb_agent_cfg.DELAY_IF)) `uvm_info (m_name,"wb agent config :Got the Interrupt Interface",UVM_INFO)  else `uvm_error (m_name,"build_phase did not find the Interrupt interface")

assert(uvm_config_db #(virtual mem_bckdoor_dr)::get(null,"uvm_test_top","hdl_top.MEM_BCK_DOOR",wb_agent_cfg.MEM_DR)) `uvm_info (m_name,"Got the Memory backdoor Interface",UVM_INFO)  else `uvm_error (m_name,"build_phase did not find the Memory Backdoor interface")

env_cfg.m_wb_agent_cfg = wb_agent_cfg;

uvm_config_db #(eth_env_config)::set(this,"m_env*","eth_env_config",env_cfg);


m_env = eth_env::type_id::create("m_env",this);


endfunction 

function void eth_base_test::configure_wb_agent(wb_agent_config cfg);
cfg.active = UVM_ACTIVE;
cfg.has_functional_coverage = 0;
cfg.has_scoreboard = 0;
endfunction  

task eth_base_test::wait_n_clks(int n = 0);
`uvm_info({m_name,"::wait"},$sformatf("waiting for %0d clock cycles",n),UVM_DEBUG)
env_cfg.pound_delay(n);
endtask 

`endif 
