`ifndef WB_SEQ_ITEM
`define WB_SEQ_ITEM


class wb_seq_item extends uvm_sequence_item;
`uvm_object_utils(wb_seq_item)

	        logic   [`WB_DATA_WIDTH-1:0]  wb_dat_i;     // WISHBONE data input
		logic   [`WB_DATA_WIDTH-1:0]  wb_dat_o;     // WISHBONE data output
		logic         				  wb_err_o;     // WISHBONE error output

		// WISHBONE slave

		rand logic    [31:0]  			  wb_adr_i;     // WISHBONE address input  
		logic    [`WB_SEL_WIDTH-1:0]  wb_sel_i;     // WISHBONE byte select input
		//logic           			  wb_we_i;      // WISHBONE write enable input
		r_w_t					  wb_we_i;
		logic           			  wb_cyc_i;     // WISHBONE cycle input
		logic           			  wb_stb_i;     // WISHBONE strobe input
		logic           			  wb_ack_o;     // WISHBONE acknowledge output


extern function new(string name = "wb_seq_item");
extern virtual function void do_copy(uvm_object rhs);
extern virtual function string convert2string();

endclass
//definition of methods






class eth_wb_req_trans extends wb_seq_item;
`uvm_object_utils(eth_wb_req_trans)



//have to add more constrints s necessary 
constraint addr_wb_align {wb_adr_i[1:0] == 2'd0; }
constraint addr_wb {wb_adr_i inside [32'h0 : 32'h7fc]};



extern function new (string name = "eth_wb_req_trans");
extern virtual function void do_copy(uvm_object rhs);
extern virtual function string convert2string();

endclass 



class wb_seq_item_converter;

static function void from_class (input wb_seq_item wb_h,output wb_sl_seq_s wb_t);
wb_t.wb_adr_i  =  wb_h.wb_adr_i;

endfunction 

static function void to_class (input wb_sl_seq_s wb_t, output wb_seq_item wb_h);

wb_h = new();
wb_h.wb_adr_i = wb_t.wb_adr_i;
endfunction 

endclass 
