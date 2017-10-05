`ifndef IF_INTR
`define IF_INTR


interface intr_if (input wb_clk,input wb_rst,input wb_intr);
// pragma attribute intr_if partition_interface_xif


task wait_for_rst(); // pragma tbx xtf
@(negedge wb_rst);
endtask 


task wait_n_clk_cyc(int n); // pragma tbx xtf
@(posedge wb_clk);
assert(n > 1);
repeat(n - 1) @(posedge wb_clk);
endtask 

task wait_for_intr(); // pragma tbx xtf
@(posedge wb_intr);
endtask 


endinterface 

`endif
