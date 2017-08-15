//////////////////////////////////////////////////////////////////////
////                                                              ////
////  tb_ethernet.v                                               ////
////                                                              ////
////  This file is part of the Ethernet IP core project           ////
////  http://www.opencores.org/project,ethmac                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Tadej Markovic, tadej@opencores.org                   ////
////      - Igor Mohor,     igorM@opencores.org                  ////
////                                                              ////
////  All additional information is available in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2001, 2002 Authors                             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.33  2005/02/21 13:02:13  igorm
// Tests for delayed CRC and defer indication added.
//
// Revision 1.32  2004/03/26 15:59:21  tadejm
// Latest Ethernet IP core testbench.
//
// Revision 1.31  2003/12/05 12:46:26  tadejm
// Updated testbench. Some more testcases, some repaired.
//
// Revision 1.30  2003/10/17 07:45:17  markom
// mbist signals updated according to newest convention
//
// Revision 1.29  2003/08/20 12:06:24  mohor
// Artisan RAMs added.
//
// Revision 1.28  2003/01/31 15:58:27  mohor
// Tests test_mac_full_duplex_receive 4-7  fixed to proper BD.
//
// Revision 1.27  2003/01/30 13:38:15  mohor
// Underrun test fixed. Many other tests fixed.
//
// Revision 1.26  2003/01/22 19:40:10  tadejm
// Backup version. Not fully working.
//
// Revision 1.25  2002/11/27 16:21:55  mohor
// Full duplex control frames tested.
//
// Revision 1.24  2002/11/22 17:29:42  mohor
// Flow control test almost finished.
//
// Revision 1.23  2002/11/22 02:12:16  mohor
// test_mac_full_duplex_flow_control tests pretty much finished.
// TEST 0: INSERT CONTROL FRM. WHILE TRANSMITTING NORMAL
// FRM. AT 4 TX BD ( 10Mbps ) finished.
// TEST 2: RECEIVE CONTROL FRAMES WITH PASSALL OPTION
// TURNED OFF AT ONE RX BD ( 10Mbps ) finished.
//
// Revision 1.22  2002/11/21 13:56:50  mohor
// test_mac_full_duplex_flow test 0 finished. Sending the control (PAUSE) frame
// finished.
//
// Revision 1.21  2002/11/19 20:27:45  mohor
// Temp version.
//
// Revision 1.20  2002/11/19 17:41:19  tadejm
// Just some updates.
//
// Revision 1.19  2002/11/14 13:12:47  tadejm
// Late collision is not reported any more.
//
// Revision 1.18  2002/10/18 17:03:34  tadejm
// Changed BIST scan signals.
//
// Revision 1.17  2002/10/18 13:58:22  tadejm
// Some code changed due to bug fixes.
//
// Revision 1.16  2002/10/09 13:16:51  tadejm
// Just back-up; not completed testbench and some testcases are not
// wotking properly yet.
//
// Revision 1.15  2002/09/20 14:29:12  tadej
// Full duplex tests modified and testbench bug repaired.
//
// Revision 1.14  2002/09/18 17:56:38  tadej
// Some additional reports added
//
// Revision 1.13  2002/09/16 17:53:49  tadej
// Full duplex test improved.
//
// Revision 1.12  2002/09/16 15:10:42  mohor
// MIIM test look better.
//
// Revision 1.11  2002/09/13 19:18:04  mohor
// Bench outputs data to display every 128 bytes.
//
// Revision 1.10  2002/09/13 18:44:29  mohor
// Beautiful tests merget together
//
// Revision 1.9  2002/09/13 18:41:45  mohor
// Rearanged testcases
//
// Revision 1.8  2002/09/13 14:50:15  mohor
// Bug in MIIM fixed.
//
// Revision 1.7  2002/09/13 12:29:14  mohor
// Headers changed.
//
// Revision 1.6  2002/09/13 11:57:20  mohor
// New testbench. Thanks to Tadej M - "The Spammer".
//
// Revision 1.2  2002/07/19 14:02:47  mohor
// Clock mrx_clk set to 2.5 MHz.
//
// Revision 1.1  2002/07/19 13:57:53  mohor
// Testing environment also includes traffic cop, memory interface and host
// interface.
//
//
//
//
//


`include "eth_phy_defines.v"
`include "wb_model_defines.v"
`include "tb_eth_defines.v"
`include "ethmac_defines.v"
`include "timescale.v"

module tb_ethernetz(wb_clk, wb_rst);


input           wb_clk;
input           wb_rst;
wire          wb_int;

wire          mtx_clk;  // This goes to PHY
wire          mrx_clk;  // This goes to PHY

wire   [3:0]  MTxD;
wire          MTxEn;
wire          MTxErr;

wire   [3:0]  MRxD;     // This goes to PHY
wire          MRxDV;    // This goes to PHY
wire          MRxErr;   // This goes to PHY
wire          MColl;    // This goes to PHY
wire          MCrs;     // This goes to PHY

wire          Mdi_I;
wire          Mdo_O;
wire          Mdo_OE;
tri           Mdio_IO;
wire          Mdc_O;


parameter Tp = 1;


// Ethernet Slave Interface signals
wire [31:0] eth_sl_wb_adr;
wire [31:0] eth_sl_wb_adr_i, eth_sl_wb_dat_o, eth_sl_wb_dat_i;
wire  [3:0] eth_sl_wb_sel_i;
wire        eth_sl_wb_we_i, eth_sl_wb_cyc_i, eth_sl_wb_stb_i, eth_sl_wb_ack_o, eth_sl_wb_err_o;

// Ethernet Master Interface signals
wire [31:0] eth_ma_wb_adr_o, eth_ma_wb_dat_i, eth_ma_wb_dat_o;
wire  [3:0] eth_ma_wb_sel_o;
wire        eth_ma_wb_we_o, eth_ma_wb_cyc_o, eth_ma_wb_stb_o, eth_ma_wb_ack_i, eth_ma_wb_err_i;

wire  [2:0] eth_ma_wb_cti_o;
wire  [1:0] eth_ma_wb_bte_o;


// Connecting Ethernet top module
//ethmac eth_top
ethmac try_this_way
(
  // WISHBONE common
  .wb_clk_i(wb_clk),              .wb_rst_i(wb_rst), 

  // WISHBONE slave
  .wb_adr_i(eth_sl_wb_adr_i[11:2]), .wb_sel_i(eth_sl_wb_sel_i),   .wb_we_i(eth_sl_wb_we_i), 
  .wb_cyc_i(eth_sl_wb_cyc_i),       .wb_stb_i(eth_sl_wb_stb_i),   .wb_ack_o(eth_sl_wb_ack_o), 
  .wb_err_o(eth_sl_wb_err_o),       .wb_dat_i(eth_sl_wb_dat_i),   .wb_dat_o(eth_sl_wb_dat_o), 
 	
  // WISHBONE master
  .m_wb_adr_o(eth_ma_wb_adr_o),     .m_wb_sel_o(eth_ma_wb_sel_o), .m_wb_we_o(eth_ma_wb_we_o), 
  .m_wb_dat_i(eth_ma_wb_dat_i),     .m_wb_dat_o(eth_ma_wb_dat_o), .m_wb_cyc_o(eth_ma_wb_cyc_o), 
  .m_wb_stb_o(eth_ma_wb_stb_o),     .m_wb_ack_i(eth_ma_wb_ack_i), .m_wb_err_i(eth_ma_wb_err_i), 

//`ifdef ETH_WISHBONE_B3
  .m_wb_cti_o(eth_ma_wb_cti_o),     .m_wb_bte_o(eth_ma_wb_bte_o),
//`endif

  //TX
  .mtx_clk_pad_i(mtx_clk), .mtxd_pad_o(MTxD), .mtxen_pad_o(MTxEn), .mtxerr_pad_o(MTxErr),

  //RX
  .mrx_clk_pad_i(mrx_clk), .mrxd_pad_i(MRxD), .mrxdv_pad_i(MRxDV), .mrxerr_pad_i(MRxErr), 
  .mcoll_pad_i(MColl),    .mcrs_pad_i(MCrs), 
  
  // MIIM
  .mdc_pad_o(Mdc_O), .md_pad_i(Mdi_I), .md_pad_o(Mdo_O), .md_padoe_o(Mdo_OE),
  
  .int_o(wb_int)

  // Bist
`ifdef ETH_BIST
  ,
  .mbist_si_i       (1'b0),
  .mbist_so_o       (),
  .mbist_ctrl_i       (3'b001) // {enable, clock, reset}
`endif
);



// Connecting Ethernet PHY Module
assign Mdio_IO = Mdo_OE ? Mdo_O : 1'bz ;
assign Mdi_I   = Mdio_IO;
//integer phy_log_file_desc;
/*
eth_phy eth_phy
(
  // WISHBONE reset
  .m_rst_n_i(!wb_rst),

  // MAC TX
  .mtx_clk_o(mtx_clk),    .mtxd_i(MTxD),    .mtxen_i(MTxEn),    .mtxerr_i(MTxErr),

  // MAC RX
  .mrx_clk_o(mrx_clk),    .mrxd_o(MRxD),    .mrxdv_o(MRxDV),    .mrxerr_o(MRxErr),
  .mcoll_o(MColl),        .mcrs_o(MCrs),

  // MIIM
  .mdc_i(Mdc_O),          .md_io(Mdio_IO),

  // SYSTEM
  .phy_log(phy_log_file_desc)
);

*/

// Connecting WB Master as Host Interface
//integer host_log_file_desc;
/*
WB_MASTER_BEHAVIORAL wb_master
(
    .CLK_I(wb_clk),
    .RST_I(wb_rst),
    .TAG_I({`WB_TAG_WIDTH{1'b0}}),
    .TAG_O(),
    .ACK_I(eth_sl_wb_ack_o),
    .ADR_O(eth_sl_wb_adr), // only eth_sl_wb_adr_i[11:2] used
    .CYC_O(eth_sl_wb_cyc_i),
    .DAT_I(eth_sl_wb_dat_o),
    .DAT_O(eth_sl_wb_dat_i),
    .ERR_I(eth_sl_wb_err_o),
    .RTY_I(1'b0),  // inactive (1'b0)
    .SEL_O(eth_sl_wb_sel_i),
    .STB_O(eth_sl_wb_stb_i),
    .WE_O (eth_sl_wb_we_i),
    .CAB_O()       // NOT USED for now!
);

assign eth_sl_wb_adr_i = {20'h0, eth_sl_wb_adr[11:2], 2'h0};



// Connecting WB Slave as Memory Interface Module
integer memory_log_file_desc;

WB_SLAVE_BEHAVIORAL wb_slave
(
    .CLK_I(wb_clk),
    .RST_I(wb_rst),
    .ACK_O(eth_ma_wb_ack_i),
    .ADR_I(eth_ma_wb_adr_o),
    .CYC_I(eth_ma_wb_cyc_o),
    .DAT_O(eth_ma_wb_dat_i),
    .DAT_I(eth_ma_wb_dat_o),
    .ERR_O(eth_ma_wb_err_i),
    .RTY_O(),      // NOT USED for now!
    .SEL_I(eth_ma_wb_sel_o),
    .STB_I(eth_ma_wb_stb_o),
    .WE_I (eth_ma_wb_we_o),
    .CAB_I(1'b0)
);



// Connecting WISHBONE Bus Monitors to ethernet master and slave interfaces
integer wb_s_mon_log_file_desc ;
integer wb_m_mon_log_file_desc ;

WB_BUS_MON wb_eth_slave_bus_mon
(
  // WISHBONE common
  .CLK_I(wb_clk),
  .RST_I(wb_rst),

  // WISHBONE slave
  .ACK_I(eth_sl_wb_ack_o),
  .ADDR_O({20'h0, eth_sl_wb_adr_i[11:2], 2'b0}),
  .CYC_O(eth_sl_wb_cyc_i),
  .DAT_I(eth_sl_wb_dat_o),
  .DAT_O(eth_sl_wb_dat_i),
  .ERR_I(eth_sl_wb_err_o),
  .RTY_I(1'b0),
  .SEL_O(eth_sl_wb_sel_i),
  .STB_O(eth_sl_wb_stb_i),
  .WE_O (eth_sl_wb_we_i),
  .TAG_I({`WB_TAG_WIDTH{1'b0}}),
`ifdef ETH_WISHBONE_B3
  .TAG_O({eth_ma_wb_cti_o, eth_ma_wb_bte_o}),
`else
  .TAG_O(5'h0),
`endif
  .CAB_O(1'b0),
`ifdef ETH_WISHBONE_B3
  .check_CTI          (1'b1),
`else
  .check_CTI          (1'b0),
`endif
  .log_file_desc (wb_s_mon_log_file_desc)
);

WB_BUS_MON wb_eth_master_bus_mon
(
  // WISHBONE common
  .CLK_I(wb_clk),
  .RST_I(wb_rst),

  // WISHBONE master
  .ACK_I(eth_ma_wb_ack_i),
  .ADDR_O(eth_ma_wb_adr_o),
  .CYC_O(eth_ma_wb_cyc_o),
  .DAT_I(eth_ma_wb_dat_i),
  .DAT_O(eth_ma_wb_dat_o),
  .ERR_I(eth_ma_wb_err_i),
  .RTY_I(1'b0),
  .SEL_O(eth_ma_wb_sel_o),
  .STB_O(eth_ma_wb_stb_o),
  .WE_O (eth_ma_wb_we_o),
  .TAG_I({`WB_TAG_WIDTH{1'b0}}),
  .TAG_O(5'h0),
  .CAB_O(1'b0),
  .check_CTI(1'b0), // NO need
  .log_file_desc(wb_m_mon_log_file_desc)
);
*/

endmodule
