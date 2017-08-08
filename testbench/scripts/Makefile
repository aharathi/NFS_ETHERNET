MODE ?= puresim

UVM: $(QUESTA_HOME)/verilog_src/uvm-1.1d

all: work build run 

work:
	vlib work
	vmap work work
	
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
		velanalyze xrtl.f 
		#veanalyze xrtl.f 
		#velcomp -task hvl -f xrtl.f
		velcomp -top top
		velhvl -sim veloce
endif
	
run:
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE +UVM_CONFIG_DB_TRACE
	#vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE
	vsim -c -do "run -all" hdl_top hvl_top TbxSvManager +UVM_TESTNAME=eth_reg_test +UVM_VERBOSITY=UVM_DEBUG +UVM_OBJECTION_TRACE

clean:
	rm -rf work


