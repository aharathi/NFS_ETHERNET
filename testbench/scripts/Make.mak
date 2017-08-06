MODE ?= puresim

UVM: $(QUESTA_HOME)/verilog_src/uvm-1.1d

all: work build run

work:
	vellib work.$(MODE)
	velmap work work.$(MODE)
	
build:
	vlog -f tb_files.f
	
	ifeq ($(MODE),puresim)
		vlog -f puresim.f
		vsim -c hdl_top hvl_top
	else 
		velanalyze -mfcu -sf xrtl.f -extract_hvl_info
		velcomp -top top
		velhv
	endif
	
run:
	vsim -c -do "run -all" hdl_top hvl_top +UVM_TESTNAME=eth_reg_test
