
`include "wishbone_defines.sv"

interface mem_backdoor_if_pins(input wb_clk);  // pragma attribute mem_backdoor_if_pins partition_interface_xif

wire  `WB_DATA_TYPE temp_data;
logic `WB_DATA_TYPE data = 'z;
logic `WB_ADDR_TYPE addr;
logic  read;
logic write;

assign temp_data = data; 


modport mem_bckdr_mp_slv (inout temp_data,input addr,input read, input write);
modport mem_bckdr_mp_ms (input temp_data,output data,output addr,output read,output write,input wb_clk);


endinterface


interface mem_bckdoor_dr  (mem_backdoor_if_pins mem_bck);  // pragma attribute mem_bckdoor_dr partition_interface_xif

initial begin
mem_bck.write = 1'b0;
mem_bck.read = 1'b0;
end


task write (input logic `WB_DATA_TYPE data[9:0],input logic `WB_ADDR_TYPE addr); //pragma tbx xtf

for (int i=0;i<=9;i++) begin //{
@(posedge mem_bck.wb_clk);
mem_bck.write <= 1'b1;
mem_bck.data <= data[i];
mem_bck.addr <= addr + i;
end //}
mem_bck.write <= 1'b0;
endtask 

endinterface














