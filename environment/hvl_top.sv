

module hvl_top;
initial begin
	$display("Starting tests");
	hdl_top.TestIf.DoReset();	// First, we have to reset to put the system into a known state
	
	`ifdef DEBUG
		$display("Random checks starting");
	`endif

//	RandomTransmit(numTestsFailed, numTests);

	// display results
//	$display("Results: Number of tests: %d Number failed = %d", numTests, numTestsFailed);
	$display("finished tests");
	$finish;
end
//import uvm_pkg::*;
//import eth_test_pkg::*;
//initial begin 
//run_test();
//end 
endmodule 
