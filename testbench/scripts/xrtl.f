
#sysvlog $(UVM)/src/uvm_pkg.sv -w work
#sysvlog ../environment/eth_env_pkg.sv -w work
#sysvlog ../register_pkg/uvm_register-2.0/src/uvm_register_pkg.sv -w work  
#sysvlog ../environment/eth_reg_pkg.sv -w work
#sysvlog ../environment/wishbone_package.sv -w work
#sysvlog ../environment/wishbone_ms_driver_bfm.sv -w work
#sysvlog ../environment/ethmac_if_pin.sv -w work
#
#verilog ../../rtl/eth_shiftreg.v -w work
#verilog ../../rtl/eth_spram_256x32.v -w work
#verilog ../../rtl/eth_transmitcontrol.v -w work
#verilog ../../rtl/eth_txcounters.v -w work
#verilog ../../rtl/eth_txethmac.v -w work
#verilog ../../rtl/eth_txstatem.v -w work
#verilog ../../rtl/eth_wishbone.v -w work
#verilog ../../rtl/eth_phy.v -w work
#sysvlog ../../rtl/ethmac.sv -w work


 ../environment/wishbone_ms_driver_bfm.sv 
 ../environment/ethmac_if_pin.sv 
 -f rtl.f

 

