
`ifndef ETH_REG_PKG
`define ETH_REG_PKG

package eth_reg_pkg;
`include "../uvm_register-2.0/src/uvm_register_pkg.sv"
`include "uvm_macros.svh"	  
import uvm_pkg::*;
import uvm_register_pkg::*;

`include "eth_regs.sv"

endpackage

`endif

