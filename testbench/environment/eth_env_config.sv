`ifndef ETH_ENV_CONFIG
`define ETH_ENV_CONFIG

class eth_env_config extends uvm_object;
`uvm_object_utils(eth_env_config)


bit has_eth_coverage = 1;
bit has_eth_scb = 1;
bit has_wb_agent = 1;

bit has_v_sqr = 1;

string m_name = "eth_env_config";

wb_agent_config m_wb_agent_cfg;

eth_reg_block eth_rm;

extern task wait_for_interrupt;
extern function bit is_interrupt_cleared;
extern task pound_delay(int n);

function new (string name = m_name);
super.new(name);
endfunction

endclass 





`endif 
