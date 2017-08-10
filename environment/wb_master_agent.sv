`ifndef WB_AGENT
`define WB_AGENT

class wb_agent extends uvm_component;
`uvm_component_utils(wb_agent)

wb_agent_config m_cfg;

wb_sequencer m_sequencer;

wb_driver m_driver;

string my_name = "wb_agent";

function new (string name = my_name,uvm_component parent = null);
super.new(name,parent);
endfunction

extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass 

function void wb_agent::build_phase(uvm_phase phase);

if (!uvm_config_db #(wb_agent_config)::get(this,"","wb_agent_config",m_cfg)) begin 
`uvm_error({my_name,"::build_phase"},"wb_agent_config not found")
end 

if (m_cfg.active == UVM_ACTIVE) begin 
`uvm_info({my_name,"::build_phase"},"creating driver and sequencer",UVM_DEBUG)
m_driver = wb_driver::type_id::create("m_driver",this);
m_sequencer = wb_sequencer::type_id::create("m_sequencer",this);
end 
endfunction 


function void wb_agent::connect_phase(uvm_phase phase);
if (m_cfg.active == UVM_ACTIVE) begin 
`uvm_info({my_name,"::connect_phase"},"connecting driver and sequencer, wishbone BFM",UVM_DEBUG)
m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
m_driver.BFM = m_cfg.WB_BFM;
end 
endfunction 

`endif
