`ifndef WB_SEQ_ITEM
`define WB_SEQ_ITEM


class wb_seq_item extends uvm_sequence_item;
`uvm_object_utils(wb_seq_item)

	    logic  		  [`WB_DATA_WIDTH-1:0]  wb_dat_i;	    // WISHBONE data input
		logic   	  [`WB_DATA_WIDTH-1:0]  wb_dat_o;   	// WISHBONE data output
		logic         				  		wb_err_o;     	// WISHBONE error output
		rand logic    [`WB_ADDR_WIDTH-1:0]  wb_adr_i;	    // WISHBONE address input  
		logic          [`WB_SEL_WIDTH-1:0]  wb_sel_i;   	// WISHBONE byte select input
		r_w_t					  			wb_we_i;		// WISHBONE write enable input
		logic           			  		wb_cyc_i;     	// WISHBONE cycle input
		logic           			  		wb_stb_i;     	// WISHBONE strobe input
		logic           			  		wb_ack_o;     	// WISHBONE acknowledge output


function new(string name = "wb_seq_item");
super.new(name);
endfunction 
extern virtual function void do_copy(uvm_object rhs);
extern virtual function string convert2string();

endclass
//definition of methods






class eth_wb_req_trans extends wb_seq_item;
`uvm_object_utils(eth_wb_req_trans)



//have to add more constrints s necessary 
constraint addr_wb_align {wb_adr_i[1:0] == 2'd0; }
constraint addr_wb {wb_adr_i inside [32'h0 : 32'h7fc]};



function new (string name = "eth_wb_req_trans");
super.new(name);
endfunction 
extern virtual function void do_copy(uvm_object rhs);
extern virtual function string convert2string();

endclass 

//
// Used for printing the class fields of sequence item
//

virtual function string eth_wb_req_trans::convert2string();

 string cls_snpsht;
 cls_snpsht = $sformatf("\n\n****************************************************************************\n\
                 WISHBONE SEQUENCE ITEM\n\
         Addr(h):%5h  WE:%s  CYC:%d  STB:%d \n\
         SEL:%d  DAT_I:%d  DAT_O:%d \n\
         ERR:%d ACK:%d \n\
********************************************************************************\n"
         ,wb_adr_i,wb_we_i, wb_cyc_i, wb_stb_i
		 ,wb_sel_i,wb_dat_i,wb_dat_o
		 ,wb_err_o,wb_ack_o);
		   
 return cls_snpsht;

endfunction

//
// Overriding do_copy method of UVM to do a deep copy
//

virtual function void eth_wb_req_trans::do_copy(uvm_object rhs);

 wb_seq_item rhs_;
 
 if(!$cast(rhs_,rhs))begin
   uvm_report_error("do_copy:", "cast failed");
   return;
 end
 
 super.do_copy(rhs); // Chaining the copy with parent class
 
 wb_dat_i = rhs_.wb_dat_i;
 wb_dat_o = rhs_.wb_dat_o;
 wb_err_o = rhs_.wb_err_o;
 wb_adr_i = rhs_.wb_adr_i;
 wb_sel_i = rhs_.wb_sel_i;
 wb_we_i  = rhs_.wb_we_i;
 wb_cyc_i = rhs_.wb_cyc_i;
 wb_stb_i = rhs_.wb_stb_i;
 wb_ack_o = rhs_.wb_ack_o;

endfunction: do_copy 

class wb_seq_item_converter;

//
// Function to convert from class object to Structure object which is used to generate pin wiggles
//

static function void from_class (input wb_seq_item wb_h,output wb_sl_seq_s wb_s);
 
 wb_s.wb_adr_i = wb_h.wb_adr_i;
 wb_s.wb_we_i  = wb_h.wb_we_i;
 wb_s.wb_cyc_i = wb_h.wb_cyc_i;
 wb_s.wb_stb_i = wb_h.wb_stb_i;
 wb_s.wb_sel_i = wb_h.wb_sel_i;
 
 wb_s.wb_dat_i = wb_h.wb_dat_i;
 wb_s.wb_dat_o = wb_h.wb_dat_o;
 wb_s.wb_err_o = wb_h.wb_err_o;
 wb_s.wb_ack_o = wb_h.wb_ack_o;

endfunction 

//
// Function to convert from structure object to class object to interact with tb
//

static function void to_class (input wb_sl_seq_s wb_s, output wb_seq_item wb_h);

 wb_h = new();
 wb_h.wb_adr_i = wb_s.wb_adr_i;
 wb_h.wb_adr_i = wb_s.wb_adr_i;
 wb_h.wb_we_i  = wb_s.wb_we_i;
 wb_h.wb_cyc_i = wb_s.wb_cyc_i;
 wb_h.wb_stb_i = wb_s.wb_stb_i;
 wb_h.wb_sel_i = wb_s.wb_sel_i;
 
 wb_h.wb_dat_i = wb_s.wb_dat_i;
 wb_h.wb_dat_o = wb_s.wb_dat_o;
 wb_h.wb_err_o = wb_s.wb_err_o;
 wb_h.wb_ack_o = wb_s.wb_ack_o;
 
endfunction 

endclass 
