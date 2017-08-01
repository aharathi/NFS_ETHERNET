`ifndef wishbone_done

	`define wishbone_done

	`include "wishbone_defines.sv"

	package wb_struct_pkg;
	
	  typedef enum bit {READ = 1'b0, WRITE = 1'b1} r_w_t;

	  typedef struct packed {
		logic   [`WB_DATA_WIDTH-1:0]  wb_dat_i;     // WISHBONE data input
		logic   [`WB_DATA_WIDTH-1:0]  wb_dat_o;     // WISHBONE data output
		logic         				  wb_err_o;     // WISHBONE error output

		// WISHBONE slave
		logic    [`WB_DATA_WIDTH-1:0] wb_adr_i;     // WISHBONE address input
		logic    [`WB_SEL_WIDTH-1:0]  wb_sel_i;     // WISHBONE byte select input
		logic           			  wb_we_i;      // WISHBONE write enable input
		logic           			  wb_cyc_i;     // WISHBONE cycle input
		logic           			  wb_stb_i;     // WISHBONE strobe input
		logic           			  wb_ack_o;     // WISHBONE acknowledge output
	  } wb_sl_seq_s;
	  
	  typedef struct packed {
		logic   [`WB_DATA_WIDTH-1:0]  wb_dat_i;     // WISHBONE data input
		logic   [`WB_DATA_WIDTH-1:0]  wb_dat_o;     // WISHBONE data output
		logic         				  wb_err_o;     // WISHBONE error output

		// WISHBONE slave
		logic  [`WB_ADDR_WIDTH-1:0]  m_wb_adr_o;
		logic  [`WB_SEL_WIDTH-1:0]   m_wb_sel_o;
		logic          m_wb_we_o;
		logic  [`WB_DATA_WIDTH-1:0]  m_wb_dat_i;
		logic  [`WB_DATA_WIDTH-1:0]  m_wb_dat_o;
		logic        				 m_wb_cyc_o;
		logic          				 m_wb_stb_o;
		logic         				 m_wb_ack_i;
		logic            			 m_wb_err_i;

		logic  [29:0]  				 m_wb_adr_tmp;

		logic  [2:0]   				 m_wb_cti_o;   // Cycle Type Identifier
		logic  [1:0]   				 m_wb_bte_o;   // Burst Type Extension
	  } wb_ms_seq_s;

	  import wb_struct_pkg::*;
	  
	  import questa_uvm_pkg::*;
	  
	 // parameter int APB_SEQ_ITEM_NUM_BITS  = $bits(apb_seq_item_s);
	 // parameter int APB_SEQ_ITEM_NUM_BYTES = (APB_SEQ_ITEM_NUM_BITS+7)/8;

	//  typedef bit [APB_SEQ_ITEM_NUM_BITS-1:0] apb_seq_item_vector_t;

	endpackage
	
`endif
