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
		vlog -f $(VMW_HOME)/tbx/questa/hdl/xtlm_files.f
		vlog -timescale 1ns/100ps -f tb_files.f -f puresim.f
		velhvl -sim puresim 
		#vsim -c hdl_top hvl_top
else 
		vlog -f $(VMW_HOME)/tbx/questa/hdl/xtlm_files.f -f tb_files.f
		veanalyze ../../rtl/*.v
		veanalyze ../environment/ethmac_if_pin.sv
		veanalyze ../environment/wishbone_package.sv
		#veanalyze +incdir+$(VMW_HOME)/tbx/questa/hdl/ ../environment/wishbone_ms_driver_bfm.sv
		veanalyze ../environment/wishbone_ms_driver_bfm.sv
		veanalyze -extract_hvl_info +incdir+$(UVM)/src $(UVM)/src/uvm_pkg.sv
		#veanalyze -extract_hvl_info  $(UVM)/src/uvm_pkg.sv
		veanalyze -extract_hvl_info +incdir+$(UVM)/src ../register_pkg/uvm_register-2.0/src/uvm_register_pkg.sv
		veanalyze -extract_hvl_info +incdir+$(UVM)/src ../environment/eth_reg_pkg.sv
		#veanalyze -extract_hvl_info +incdir+$(VMW_HOME)/tbx/questa/hdl/+$(UVM)/src ../environment/eth_env_pkg.sv
		veanalyze -extract_hvl_info +incdir+$(UVM)/src ../environment/eth_env_pkg.sv
		veanalyze ../../rtl/*.sv
	        #velcomp -task hvl -f xrtl.f
		#velcomp -f xrtl.f 
		tbxcomp -top hdl_top -veloce
		#velcomp -top hdl_top 
		velhvl -sim veloce
endif
	
run:
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE +UVM_CONFIG_DB_TRACE
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE
ifeq ($(MODE),puresim)
	vsim -c -do "run -all" hdl_top hvl_top TbxSvManager +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_OBJECTION_TRACE
else 
	vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_OBJECTION_TRACE
endif

clean:
	rm -rf work


