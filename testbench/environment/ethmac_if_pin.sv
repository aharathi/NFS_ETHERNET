/////////////////
//NFS : file that defines interface pins od the DUT   
/////////////////


interface ethmac_if_pins(input wb_clk_i,input mtx_clk_pad_i,input mrx_clk_pad_i,input wb_rst_i);

 // WISHBONE common
//logic		wb_clk_i; // WISHBONE clock
//logic		wb_rst_i; // WISHBONE reset
logic	[31:0]	wb_dat_i; // WISHBONE data input
logic	[31:0]	wb_dat_o; 

  // WISHBONE slave
logic 	[11:2]	wb_adr_i;
logic	[3:0]	wb_sel_i;
logic 		wb_we_i;
logic 		wb_cyc_i;
logic 		wb_stb_i;
logic 		wb_ack_o;
logic 		wb_err_o; 

  // WISHBONE master
 logic	[31:0]	m_wb_adr_o;
 logic 	[3:0]	m_wb_sel_o;
 logic 		m_wb_we_o; 
 logic 	[31:0]	m_wb_dat_o;
 logic 	[31:0]	m_wb_dat_i;
 logic 		m_wb_cyc_o, 
 logic 		m_wb_stb_o;
 logic 		m_wb_ack_i;
 logic 		m_wb_err_i, 
 logic	[2:0]	m_wb_cti_o;
 logic 	[1:0]	m_wb_bte_o;

  //TX
 //logic 		mtx_clk_pad_i; // Transmit clock (from PHY)
 logic 	[3:0]	mtxd_pad_o;    // Transmit nibble (to PHY)
 logic 		mtxen_pad_o;   // Transmit enable (to PHY)
 logic 		mtxerr_pad_o;  // Transmit error (to PHY)

  //RX
 //logic 		mrx_clk_pad_i;  // Receive clock (from PHY)
 logic 	[3:0]	mrxd_pad_i;     // Receive nibble (from PHY)
 logic 		mrxdv_pad_i;    // Receive data valid (from PHY)
 logic 		mrxerr_pad_i;   // Receive data error (from PHY)

// Common Tx and Rx

 logic mcoll_pad_i;             // Collision (from PHY)
 logic mcrs_pad_i;              // Carrier sense (from PHY)
  
  // MIIM
 logic mdc_pad_o;               // MII data input (from I/O cell)
 logic md_pad_i;                // MII Management data clock (to PHY)
 logic md_pad_o;                // MII data output (to I/O cell)
 logic md_padoe_o;              // MII data output enable (to I/O cell)

 logic int_o;                    // Interrupt output

  // Bist
`ifdef ETH_BIST
  ,
  // debug chain signals
 logic mbist_si_i;       // bist scan serial in
 logic mbist_so_o;       // bist scan serial out
 logic mbist_ctrl_i;       // bist chain shift control
`endif



modport eth_mp(
		input	wb_clk_i,
		input	wb_rst_i,
		input	wb_dat_i,
		output	wb_dat_o,
		output	wb_err_o,
		input  wb_adr_i,     // WISHBONE address input
		input  wb_sel_i,     // WISHBONE byte select input
		input  wb_we_i,      // WISHBONE write enable input
		input  wb_cyc_i,     // WISHBONE cycle input
		input  wb_stb_i,     // WISHBONE strobe input
		output wb_ack_o     // WISHBONE acknowledge output
		output m_wb_adr_o,
		output m_wb_sel_o,
		output m_wb_we_o,
		input  m_wb_dat_i,
		output m_wb_dat_o,
		output m_wb_cyc_o,
		output m_wb_stb_o,
		input  m_wb_ack_i,
		input  m_wb_err_i,
		output m_wb_cti_o,   // Cycle Type Identifier
		output m_wb_bte_o,   // Burst Type Extension
		input  mtx_clk_pad_i; // Transmit clock (from PHY)
		output mtxd_pad_o;    // Transmit nibble (to PHY)
		output mtxen_pad_o;   // Transmit enable (to PHY)
		output mtxerr_pad_o;  // Transmit error (to PHY)
		input mrx_clk_pad_i; // Receive clock (from PHY)
		input mrxd_pad_i;    // Receive nibble (from PHY)
		input mrxdv_pad_i;   // Receive data valid (from PHY)
		input mrxerr_pad_i;  // Receive data error (from PHY)
		input  mcoll_pad_i;   // Collision (from PHY)
		input  mcrs_pad_i;    // Carrier sense (from PHY)
		input  md_pad_i;      // MII data input (from I/O cell)
		output mdc_pad_o;     // MII Management data clock (to PHY)
		output md_pad_o;      // MII data output (to I/O cell)
		output md_padoe_o;    // MII data output enable (to I/O cell)
		output int_o;         // Interrupt output
		`ifdef ETH_BIST
		input   mbist_si_i;       // bist scan serial in
		output  mbist_so_o;       // bist scan serial out
		input [`ETH_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;       // bist chain shift control
		`endif
		);

	/*modport wb_host_dr_mp(
		input	wb_clk_i,
		input	wb_rst_i,
		output	wb_dat_i,
		input	wb_dat_o,
		input	wb_err_o,
		output  wb_adr_i,     // WISHBONE address input
		output  wb_sel_i,     // WISHBONE byte select input
		output  wb_we_i,      // WISHBONE write enable input
		output  wb_cyc_i,     // WISHBONE cycle input
		output  wb_stb_i,     // WISHBONE strobe input
		input wb_ack_o     // WISHBONE acknowledge output
		input m_wb_adr_o,
		input m_wb_sel_o,
		input m_wb_we_o,
		output  m_wb_dat_i,
		input m_wb_dat_o,
		input m_wb_cyc_o,
		input m_wb_stb_o,
		output  m_wb_ack_i,
		output  m_wb_err_i,
		input m_wb_cti_o,   // Cycle Type Identifier
		input m_wb_bte_o,   // Burst Type Extension
				);
				
		*/
	modport wb_slave_mp(
		input	wb_clk_i,
		input	wb_rst_i,
		output	wb_dat_i,
		input	wb_dat_o,
		input	wb_err_o,

		// WISHBONE slave
		output  wb_adr_i,     // WISHBONE address input
		output  wb_sel_i,     // WISHBONE byte select input
		output  wb_we_i,      // WISHBONE write enable input
		output  wb_cyc_i,     // WISHBONE cycle input
		output  wb_stb_i,     // WISHBONE strobe input
		input   wb_ack_o      // WISHBONE acknowledge output	
	);

endinterface
