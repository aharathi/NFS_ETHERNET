

module hvl_top;

import uvm_pkg::*;
import eth_test_pkg::*;
initial begin 

uvm_config_db #(virtual wb_master_driver_if)::set(null,"uvm_test_top","hdl_top.WB_DRIVER",hdl_top.wb_ms_drif);
uvm_config_db #(virtual mem_bckdoor_dr)::set(null,"uvm_test_top","hdl_top.MEM_BCK_DOOR",hdl_top.mem_bckdoor_drv);
uvm_config_db #(virtual intr_if)::set(null,"uvm_test_top","hdl_top.INTR",hdl_top.INTR);
run_test();
end 
endmodule 
