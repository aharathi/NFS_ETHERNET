`ifndef ETH_ENV_PKG
`define ETH_ENV_PKG

package eth_env_pkg;
`include "wishbone_defines.sv"
`include "uvm_macros.svh"
`include "tb_eth_defines.sv"
import uvm_pkg::*;
//import questa_uvm_pkg::*;
import wb_struct_pkg::*;
import eth_reg_pkg::*;

`include "wb_seq_item.sv"
`include "wb_master_driver.sv"
`include "wb_agent_config.sv"
`include "wb_master_agent.sv"
`include "eth_env_config.sv"
`include "eth_env.sv"
`include "reg2wb_adapter.sv"

endpackage

`endif 
