
/*
//
// uvm_field configure method prototype
//
function void configure(uvm_reg        parent,    // The containing register
                        int unsigned   size,      // How many bits wide
                        int unsigned   lsb_pos,   // Bit offset within the register
                        string         access,    // "RW", "RO", "WO" etc
                        bit            volatile,  // Volatile if bit is updated by hardware
                        uvm_reg_data_t reset,     // The reset value
                        bit            has_reset, // Whether the bit is reset
                        bit            is_rand,   // Whether the bit can be randomized
                        bit            individually_accessible); // i.e. Totally contained within a byte lane
*/

import wb_struct_pkg::*;

//MODER Register definition

class moder extends uvm_reg;
`uvm_object_utils(moder);			//register the class 

rand uvm_reg_field RXEN; //receive enable
rand uvm_reg_field TXEN; //transmit enable
rand uvm_reg_field NOPRE; //no preamble 
rand uvm_reg_field BRO; //Broadcast address
rand uvm_reg_field IAM; //individual address mode 
rand uvm_reg_field PRO; //promiscuious 
rand uvm_reg_field IFG; 
rand uvm_reg_field LOOPBACK; 
rand uvm_reg_field NOBCKOF; 
rand uvm_reg_field EXDFREN; 
rand uvm_reg_field FULLD; 
rand uvm_reg_field RESERVED_2; 
rand uvm_reg_field DLYCRCEN; 
rand uvm_reg_field CRCEN; 
rand uvm_reg_field HUGEN; 
rand uvm_reg_field PAD; 
rand uvm_reg_field RECSMALL; 
rand uvm_reg_field RESERVED_1; //reserved 31:17

function new(string name = "MODER");
super.new(name,32,UVM_NO_COVERAGE);
endfunction 

virtual function void build();
 RXEN	= uvm_reg_field::type_id::create("RXEN");
 TXEN	= uvm_reg_field::type_id::create("TXEN");
 NOPRE	= uvm_reg_field::type_id::create("NOPRE");
 BRO	= uvm_reg_field::type_id::create("BRO");
 IAM	= uvm_reg_field::type_id::create("IAM");
 PRO	= uvm_reg_field::type_id::create("PRO");
 IFG	= uvm_reg_field::type_id::create("IFG");
 LOOPBACK = uvm_reg_field::type_id::create("LOOPBACK");
 NOBCKOF = uvm_reg_field::type_id::create("NOBCKOF");
 EXDFREN = uvm_reg_field::type_id::create("EXDFREN");
 FULLD = uvm_reg_field::type_id::create("FULLD");
 RESERVED_2 = uvm_reg_field::type_id::create("RESERVED_2");
 DLYCRCEN = uvm_reg_field::type_id::create("DLYCRCEN");
 CRCEN = uvm_reg_field::type_id::create("CRCEN");
 HUGEN = uvm_reg_field::type_id::create("HUGEN");
 PAD = uvm_reg_field::type_id::create("PAD");
 RECSMALL = uvm_reg_field::type_id::create("RECSMALL");
 RESERVED_1 = uvm_reg_field::type_id::create("RESERVED_1");

 RXEN.configure(this,1,0,"RW",0,1'b0,1,1,0);
 TXEN.configure(this,1,1,"RW",0,1'b0,1,1,0);
 NOPRE.configure(this,1,2,"RW",0,1'b0,1,1,0);
 BRO.configure(this,1,3,"RW",0,1'b0,1,1,0);
 IAM.configure(this,1,4,"RW",0,1'b0,1,1,0);
 PRO.configure(this,1,5,"RW",0,1'b0,1,1,0);
 IFG.configure(this,1,6,"RW",0,1'b0,1,1,0);
 LOOPBACK.configure(this,1,7,"RW",0,1'b0,1,1,0);
 NOBCKOF.configure(this,1,8,"RW",0,1'b0,1,1,0);
 EXDFREN.configure(this,1,9,"RW",0,1'b0,1,1,0);
 FULLD.configure(this,1,10,"RW",0,1'b0,1,1,0);
 RESERVED_2.configure(this,1,11,"RW",0,1'b0,1,1,0);
 DLYCRCEN.configure(this,1,12,"RW",0,1'b0,1,1,0);
 CRCEN.configure(this,1,13,"RW",0,1'b0,1,1,0);
 HUGEN.configure(this,1,14,"RW",0,1'b0,1,1,0);
 PAD.configure(this,1,15,"RW",0,1'b0,1,1,0);
 RECSMALL.configure(this,1,16,"RW",0,1'b0,1,1,0);
 RESERVED_1.configure(this,15,17,"RW",0,15'h0000,1,1,0);
 
endfunction
endclass 

//TX_BD_NUM Register Declaration

class tx_bd_num extends uvm_reg;
`uvm_object_utils(tx_bd_num);

rand uvm_reg_field RESERVED;
rand uvm_reg_field TxBD; //Tx BD Number

function new(string name = "TX_BD_NUM");
super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();
RESERVED	= uvm_reg_field::type_id::create("RESERVED");
TxBD		= uvm_reg_field::type_id::create("TxBD");

RESERVED.configure(this,24,8,"RW",0,1'b0,1,1,0);
TxBD.configure(this,8,0,"RW",0,1'b0,1,1,0);
endfunction
endclass 

//MIIMODER Register Declaration

class miimoder extends uvm_reg;
`uvm_object_utils(miimoder);

rand uvm_field RESERVED;
rand uvm_field MIINOPRE;
rand uvm_field CLKDIV;

function new(string name = "MIIMODER");
	super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build()
RESERVED	= uvm_reg_field::type_id::create("RESERVED");
MIINOPRE	= uvm_reg_field::type_id::create("MIINOPRE");
CLKDIV		= uvm_reg_field::type_id::create("CLKDIV");

RESERVED.configure(this,23,9,"RW",0,1'b0,1,1,0);
MIINOPRE.configure(this,1,8,"RW",0,1'b0,1,1,0);
CLKDIV.configure(this,8,0,"RW",0,1'b0,1,1,0);
endfunction
endclass

//MIISTATUS  Register Declaration

class miistatus extends uvm_reg;
`uvm_object_utils(miistatus);

rand uvm_field RESERVED;
rand uvm_field NVALID;
rand uvm_field BUSY;
rand uvm_field LINKFAIL;

function new(string name = "MIISTATUS");
	super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build()
RESERVED	= uvm_reg_field::type_id::create("RESERVED");
NVALID		= uvm_reg_field::type_id::create("NVALID");
BUSY		= uvm_reg_field::type_id::create("BUSY");
LINKFAIL	= uvm_reg_field::type_id::create("LINKFAIL");

RESERVED.configure(this,29,3,"RW",0,1'b0,1,1,0);
NVALID.configure(this,1,2,"RW",0,1'b0,1,1,0);
BUSY.configure(this,1,1,"RW",0,1'b0,1,1,0);
LINKFAIL.configure(this,1,0,"RW",0,1'b0,1,1,0);
endfunction
endclass

//Register map
class eth_reg_block extends uvm_reg_block;
`uvm_object_utils(eth_reg_block)

rand moder moder_reg;
rand tx_bd_num tx_bd_num_reg;
rand miimoder miimoder_reg;
rand miistatus miistatus_reg;

uvm_reg_map ETH_map;

function new(string name="eth_reg_block");
super.new(name,UVM_NO_COVERAGE); 
endfunction 


virtual function void build();

moder_reg = moder::type_id::create("MODER");
moder_reg.configure(this,null,"");				//"" : to fill the HW Register HDL Path
moder_reg.build();

tx_bd_num_reg = tx_bd_num::type_id::create("TX_BD_NUM");
tx_bd_num_reg.configure(this, null, "");
tx_bd_num_reg.build();

miimoder_reg = miimoder::type_id::create("MIIMODER");
miimoder_reg.configure(this, null, "");
miimoder_reg.build();

miistatus_reg = miistatus::type_id::create("MIISTATUS"); 
miistatus_reg.configure(this, null, "");
miistatus_reg.build();

ETH_map = create_map("ETH_map",'h0,4,UVM_LITTLE_ENDIAN);

ETH_map.add_reg(moder_reg,32'h00000000,"RW");
ETH_map.add_reg(tx_bd_num_reg,32'h00000004,"RW");
ETH_map.add_reg(miimoder_reg,32'h00000008,"RW");
ETH_map.add_reg(miistatus_reg,32'h0000000C,"RW");

lock_model();
endfunction

endclass 

//Register Adapter

class reg2wb_adapter extends uvm_reg_adapter;
`uvm_object_utils(reg2wb_adapter);

function new(string name = "reg2wb_adapter");
	super.new(name);
	supports_byte_enable = 0;
  provides_responses = 0;
endfunction

virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op reg_params);
wb_seq_item wb_signal = wb_seq_item::type_id::create("wb_signal");
wb_signal.wb_dat_i = reg_params.addr;
wb_signal.wb_adr_i = reg_params.data;
wb_signal.wb_we_i  = (reg_params.kind == UVM_WRITE)?r_w_t.WRITE:((reg_params.kind == UVM_READ)? r_w_t.READ:0);
return wb_signal;
endfunction

endclass