/*
=====================================================================================
ECE 595 calc1
spring 2017
Randon Stasney
calc_if.sv - calc_if
4/10/2017
Description:
Interface and controls tasks
Version 3.1
Adapted from Devin Wolfe, Nikhil Marda, Goutham Konidala 571 project
=====================================================================================
*/

interface calc_if;


	//pragma attribute calc_if partition_interface_xif 
	logic 					SysClk;				// clock
	logic 					Rst;				// reset
	/*
	logic [0:31]  			req1_data_in;		// data in port
	logic [0:31] 		 	req2_data_in; 
	logic [0:31] 	 		req3_data_in; 
	logic [0:31] 	 		req4_data_in;
	logic [0:3]	 			req1_cmd_in; 		// opcode
	logic [0:3]	 			req2_cmd_in; 
	logic [0:3]	 			req3_cmd_in; 
	logic [0:3]	 			req4_cmd_in;
	logic [0:31]  			out_data1; 			// result
	logic [0:31] 		 	out_data2; 
	logic [0:31] 		 	out_data3; 
	logic [0:31] 		 	out_data4;
	logic [0:1]  			out_resp1; 			// signal for complete
	logic [0:1]		 		out_resp2; 
	logic [0:1]		 		out_resp3; 
	logic [0:1]		 		out_resp4;

	*/

	
	//***************************************************
	//	Testbench tasks
	//
	//  Return the test results to the HVL module
	//***************************************************
	
	// Simple task to perform a system wide reset
	task DoReset(); //pragma tbx xtf
		@(posedge SysClk);
		Rst = '1;
		repeat(7)
		@(posedge SysClk);
		Rst = '0;

	endtask
/*
	// This task places the opcodee and first operand on port 1
	// on next clock places second operand and rturns opcode to zero
	// waits for response to be generated and captures delivered result
	// returns result to caller

		task Port1(input logic [31:0] opA, input logic [31:0] opB, input logic [1:0] code, output logic [31:0] Result); //pragma tbx xtf
	
		@(posedge SysClk);		
		req1_cmd_in = code; 
		req1_data_in = opA;
		@(posedge SysClk);
		req1_cmd_in = 2'b0; 
		req1_data_in = opB;		
		while (!out_resp1)
		@(posedge SysClk);		
		Result = out_data1;

		endtask

	// This task places the opcodee and first operand on port 2
	// on next clock places second operand and rturns opcode to zero
	// waits for response to be generated and captures delivered result
	// returns result to caller	
	
		task Port2(input logic [31:0] opA, input logic [31:0] opB, input logic [1:0] code, output logic [31:0] Result); //pragma tbx xtf
		
		@(posedge SysClk);
		req2_cmd_in = code; 
		req2_data_in = opA;
		@(posedge SysClk);
		req2_cmd_in = 2'b0; 
		req2_data_in = opB;		
		while (!out_resp2)
		@(posedge SysClk);		
		Result = out_data2;
		
		endtask
		
	// This task places the opcodee and first operand on port 3
	// on next clock places second operand and rturns opcode to zero
	// waits for response to be generated and captures delivered result
	// returns result to caller
		
		task Port3(input logic [31:0] opA, input logic [31:0] opB, input logic [1:0] code, output logic [31:0] Result); //pragma tbx xtf
		
		@(posedge SysClk);	
		req3_cmd_in = code; 
		req3_data_in = opA;
		@(posedge SysClk);
		req3_cmd_in = 2'b0; 
		req3_data_in = opB;		
		while (!out_resp3)
		@(posedge SysClk);		
		Result = out_data3;
		endtask


	// This task places the opcodee and first operand on port 4
	// on next clock places second operand and rturns opcode to zero
	// waits for response to be generated and captures delivered result
	// returns result to caller
	
		task Port4(input logic [31:0] opA, input logic [31:0] opB, input logic [1:0] code, output logic [31:0] Result); //pragma tbx xtf
		
		@(posedge SysClk);
		req4_cmd_in = code; 
		req4_data_in = opA;
		@(posedge SysClk);
		req4_cmd_in = 2'b0; 
		req4_data_in = opB;		
		while (!out_resp4)
		@(posedge SysClk);		
		Result = out_data4;
		endtask

*/			
endinterface
