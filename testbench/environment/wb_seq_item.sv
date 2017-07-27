`ifndef WB_SEQ_ITEM
`define WB_SEQ_ITEM


class wb_seq_item extends uvm_sequence_item;
`uvm_object_utils(wb_seq_item)

	        logic   [`WB_DATA_WIDTH-1:0]  wb_dat_i;     // WISHBONE data input
		logic   [`WB_DATA_WIDTH-1:0]  wb_dat_o;     // WISHBONE data output
		logic         				  wb_err_o;     // WISHBONE error output

		// WISHBONE slave

		//change into 32 bit variable 
		rand logic    [31:0]  			  wb_adr_i;     // WISHBONE address input 
		logic    [`WB_SEL_WIDTH-1:0]  wb_sel_i;     // WISHBONE byte select input
		logic           			  wb_we_i;      // WISHBONE write enable input
		logic           			  wb_cyc_i;     // WISHBONE cycle input
		logic           			  wb_stb_i;     // WISHBONE strobe input
		logic           			  wb_ack_o;     // WISHBONE acknowledge output


extern function new(string name = "wb_seq_item");
extern virtual function void do_copy(uvm_object rhs);
extern virtual function string convert2string();

endclass
//definition of methods






class eth_wb_trans extends wb_seq_item;
`uvm_object_utils(eth_wb_trans)



//have to add more constrints s necessary 
constraint addr_wb_align {wb_adr_i[1:0] == 2'd0; }
constraint addr_wb {wb_adr_i inside [32'h0 : 32'h7fc]};



extern function new (string name = "eth_wb_trans");
extern virtual function void do_copy(uvm_object rhs);
extern virtual function string convert2string();

endclass 

