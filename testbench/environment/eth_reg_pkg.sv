
`ifndef ETH_REG_PKG
`define ETH_REG_PKG

package eth_reg_pkg;
//`include "../register_pkg/uvm_register-2.0/src/uvm_register_pkg.sv"
`include "uvm_macros.svh"
`include "tb_eth_defines.sv"
import uvm_pkg::*;
import uvm_register_pkg::*;

`include "eth_buf_desc.sv"
`include "eth_regs.sv"

endpackage

`endif

