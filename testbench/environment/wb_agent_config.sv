`ifndef WB_AGENT_CONFIG
`define WB_AGENT_CONFIG

class wb_agent_config extends uvm_object;
`uvm_object_utils(wb_agent_config)

localparam string cfg_id_s = "wb_agent_config";

virtual wb_master_driver_if WB_BFM;

uvm_active_passive_enum active = UVM_ACTIVE;

bit has_functional_coverage = 0;

bit has_scoreboard = 0;

function new (string name = cfg_id_s);
super.new(name);
endfunction 


endclass

`endif 
