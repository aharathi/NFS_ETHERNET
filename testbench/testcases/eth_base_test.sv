

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
super.new(name.parent);
endfunction 

extern function void configure_wb_agent(wb_agent_config cfg);

extern function void build_phase(uvm_phase phase);

endclass

function eth_base_test::build_phase(uvm_phase phase);

env_cfg = eth_env_config::type_id::create("env_cfg");

eth_reg_m = eth_reg_block::type_id::create("eth_reg_m");

eth_reg_m.build();

env_cfg.eth_rm = eth_reg_m;

wb_agent_cfg = wb_agent_config::type_id::create("wb_agent_cfg");

configure_wb_agent(wb_agent_cfg);

`assert(uvm_config_db #(virtual wb_master_driver_if)::get(this,"","hdl_top.WB_DRIVER",wb_agent_cfg.WB_BFM)) `uvm_error (m_name,"build_phase did not find the driver interface")

env_cfg.m_wb_agent_cfg = wb_agent_cfg;

uvm_config_db #(eth_env_config)::set(this,"m_env*","eth_env_config",env_cfg);


m_env = eth_env::type_id::create("m_env",this);


endfunction 

function void eth_base_test::configure_wb_agent(wb_agent_config cfg);
cfg.active = UVM_ACTIVE;
cfg.has_functional_coverage = 0;
cfg.has_scoreboard = 0;
endfunction  
`endif 
