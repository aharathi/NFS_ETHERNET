MODE ?= puresim

UVM: $(QUESTA_HOME)/verilog_src/uvm-1.1d

all: work build run 

work:
	vlib work
	vmap work work
	export UVM=$(QUESTA_HOME)/verilog_src/uvm-1.1d
	
build:
	#vlog -f tb_files.f
	
ifeq ($(MODE),puresim)
	        #vlog -f tb_files.f
		vlog -timescale 1ns/100ps -f tb_files.f -f puresim.f
		velhvl -sim puresim 
		#vsim -c hdl_top hvl_top
else 
	        vlog -f tb_files.f
		#velanalyze -mfcu -sf xrtl.f -extract_hvl_info
		#velanalyze $(UVM)/src/uvm_pkg.sv -extract_hvl_info +define+QUESTA 
		#velanalyze ../environment/eth_env_pkg.sv -extract_hvl_info +define+QUESTA
		#velanalyze ../environment/eth_reg_pkg.sv -extract_hvl_info +define+QUESTA 
		#velanalyze ../environment/wishbone_package.sv -extract_hvl_info +define+QUESTA
		#velanalyze ../environment/wishbone_ms_driver_bfm.sv -extract_hvl_info +define+QUESTA
		#velanalyze ../environment/ethmac_if_pin.sv -extract_hvl_info +define+QUESTA
		#velanalyze ../../rtl/eth_clockgen.v 
		#velanalyze ../../rtl/eth_crc.v 
		#velanalyze ../../rtl/eth_fifo.v 
		#velanalyze ../../rtl/eth_maccontrol.v 
		#velanalyze ../../rtl/eth_macstatus.v 
		#velanalyze ../../rtl/eth_miim.v 
		#velanalyze ../../rtl/eth_outputcontrol.v 
		#velanalyze ../../rtl/eth_random.v 
		#velanalyze ../../rtl/eth_receivecontrol.v 
		#velanalyze ../../rtl/eth_registers.v 
		#velanalyze ../../rtl/eth_register.v 
		#velanalyze ../../rtl/eth_rxaddrcheck.v 
		#velanalyze ../../rtl/eth_rxcounters.v 
		#velanalyze ../../rtl/eth_rxethmac.v 
		#velanalyze ../../rtl/eth_rxstatem.v 
		#velanalyze ../../rtl/eth_shiftreg.v
		#velanalyze ../../rtl/eth_spram_256x32.v 
		#velanalyze ../../rtl/eth_transmitcontrol.v 
		#velanalyze ../../rtl/eth_txcounters.v 
		#velanalyze ../../rtl/eth_txethmac.v 
		#velanalyze ../../rtl/eth_txstatem.v 
		#velanalyze ../../rtl/eth_wishbone.v 
		#velanalyze ../../rtl/eth_phy.v 
		#velanalyze ../../rtl/ethmac.sv

		#velanalyze 
		#veanalyze xrtl.f 
		#velcomp -task hvl -f xrtl.f
		velcomp -f xrtl.f 
		velhvl -sim veloce
endif
	
run:
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE +UVM_CONFIG_DB_TRACE
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE
	vsim -c -do "run -all" hdl_top hvl_top TbxSvManager +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_OBJECTION_TRACE

clean:
	rm -rf work


