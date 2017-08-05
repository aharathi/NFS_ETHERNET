`ifndef ETH_TEST_PKG
`define ETH_TEST_PKG
package eth_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import eth_env_pkg::*;
import eth_reg_pkg::*;
import eth_seq_pkg::*;

`include "eth_base_test.sv"
`include "eth_reg_test.sv"

endpackage

`endif
