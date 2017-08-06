`ifndef ETH_ENV
`define ETH_ENV

class eth_env extends uvm_env;
`uvm_component_utils(eth_env)


string m_name = "eth_env";

eth_env_config m_env_cfg;
wb_agent m_wb_agent;

reg2wb_adapter reg2wb;

function new (string name = m_name,uvm_component parent = null);
super.new(name,parent);
endfunction 


extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);


endclass 


function void eth_env::build_phase(uvm_phase phase);

assert (uvm_config_db #(eth_env_config)::get(this,"","eth_env_config",m_env_cfg)) `uvm_error (m_name,"build_phase eth_env_config not found ")

if (m_env_cfg.has_wb_agent) begin 
uvm_config_db #(wb_agent_config)::set(this,"m_wb_agent*","wb_agent_config",m_env_cfg.m_wb_agent_cfg);
m_wb_agent = wb_agent::type_id::create("m_wb_agent",this);
end 

endfunction 

function void eth_env::connect_phase(uvm_phase phase);

if (m_env_cfg.m_wb_agent_cfg.active == UVM_ACTIVE) begin 
reg2wb = reg2wb_adapter::type_id::create("reg2wb");

if (m_env_cfg.eth_rm.get_parent() == null) begin
m_env_cfg.eth_rm.ETH_map.set_sequencer(m_wb_agent.m_sequencer,reg2wb);
end 
end 

endfunction 



`endif 
