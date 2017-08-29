MODE ?= puresim

UVM: $(QUESTA_HOME)/verilog_src/uvm-1.1d

all: work build run 

work:
	vlib work
	vmap work work
	export UVM=$(QUESTA_HOME)/verilog_src/uvm-1.1d
	
build:
	
ifeq ($(MODE),puresim)
		vlog -f $(VMW_HOME)/tbx/questa/hdl/xtlm_files.f
		vlog -timescale 1ns/100ps -f tb_files.f -f puresim.f
		velhvl -sim puresim 
else 
		vlog -f $(VMW_HOME)/tbx/questa/hdl/xtlm_files.f 
		vlog -f tb_files.f
		velanalyze ../../rtl/*.v
		velanalyze ../environment/ethmac_if_pin.sv
		velanalyze ../environment/wishbone_package.sv
		velanalyze +incdir+$(VMW_HOME)/tbx/questa/hdl/ ../environment/wishbone_ms_driver_bfm.sv
		velanalyze ../environment/wishbone_ms_driver_bfm.sv
		velanalyze ../../rtl/*.sv
		velanalyze -hdl verilog -extract_hvl_info +incdir+$(UVM)/src $(UVM)/src/uvm_pkg.sv
		velanalyze -hdl verilog -extract_hvl_info +incdir+$(UVM)/src ../register_pkg/uvm_register-2.0/src/uvm_register_pkg.sv
		velanalyze -hdl verilog -extract_hvl_info +incdir+$(UVM)/src ../environment/eth_reg_pkg.sv
		velanalyze -hdl verilog -extract_hvl_info +incdir+$(VMW_HOME)/tbx/questa/hdl/+$(UVM)/src ../environment/eth_env_pkg.sv
		velanalyze -hdl verilog -extract_hvl_info +incdir+$(VMW_HOME)/tbx/questa/hdl/+$(UVM)/src ../testcases/sequences/eth_seq_pkg.sv
		velanalyze -hdl verilog -extract_hvl_info +incdir+$(VMW_HOME)/tbx/questa/hdl/+$(UVM)/src ../testcases/eth_test_pkg.sv
		velanalyze -hdl verilog -extract_hvl_info +incdir+$(UVM)/src ../environment/hvl_top.sv
		velcomp -top hdl_top 
		velhvl -sim veloce
endif
	
run:
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE +UVM_CONFIG_DB_TRACE
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE
ifeq ($(MODE),puresim)
	vsim -novopt  -c -do "run -all" hdl_top hvl_top TbxSvManager +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_OBJECTION_TRACE +TX_BD_NUM=32
else 
	vsim -novopt -c -do  "run -all" hdl_top hvl_top TbxSvManager +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_OBJECTION_TRACE
endif

clean:
	rm -rf work
	rm -rf tbx.dir tbx.log tbx.med tbx.wave veloce.log veloce.med veloce.wave


