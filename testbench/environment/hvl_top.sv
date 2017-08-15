

module hvl_top;

import uvm_pkg::*;
import eth_test_pkg::*;
initial begin 

uvm_config_db #(virtual wb_master_driver_if)::set(null,"uvm_test_top","hdl_top.WB_DRIVER",hdl_top.wb_ms_drif);
run_test();
end 
endmodule 
