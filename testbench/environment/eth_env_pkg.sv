`ifndef ETH_ENV_PKG
`define ETH_ENV_PKG

package eth_env_pkg;
`include "wishbone_defines.sv"
//`include "wishbone_package.sv"
`include "uvm_macros.svh"
`include "tb_eth_defines.sv"
import uvm_pkg::*;
//import questa_uvm_pkg::*;
import wb_struct_pkg::*;
import eth_reg_pkg::*;
//import xtlm_pkg::*;

`include "wb_seq_item.sv"
`include "wb_master_driver.sv"
`include "wb_agent_config.sv"
`include "wb_master_agent.sv"
`include "eth_env_config.sv"
`include "reg2_wb_adapter.sv"
`include "eth_env.sv"

endpackage

`endif 
