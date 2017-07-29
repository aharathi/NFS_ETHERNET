
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

rand uvm_reg_field TxBD; //Tx BD Number
rand uvm_reg_field RESERVED;

function new("TX_BD_NUM");
super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();
TxBD	= uvm_reg_field::type_id::create("TxBD");
RESERVED	= uvm_reg_field::type_id::create("RESERVED");
 
RW.configure(this,8,0,"RW",0,1'b0,1,1,0);
RESERVED.configure(this,24,8,"RW",0,1'b0,1,1,0);
endfunction
endclass 

//Register map

class eth_reg_block extends uvm_reg_block;
`uvm_object_utils(eth_reg_block)

rand moder moder_reg;
rand tx_bd_num tx_bd_num_reg;

uvm_reg_map ETH_map;

function new(string name="eth_reg_block");
super.new(name,UVM_NO_COVERAGE); 
endfunction 


virtual function void build();

moder_reg = moder::type_id::create("MODER");
moder_reg.configure(this,null,"");
moder_reg.build();


tx_bd_num_reg = tx_bd_num::type_id::create("TX_BD_NUM");
tx_bd_num_reg.configure(this,null,"");
tx_bd_num_reg.build();

ETH_map = create_map("ETH_map",'h0,4,UVM_LITTLE_ENDIAN);

ETH_map.add_reg(moder_reg,32'h00000000,"RW");

ETH_map.add_reg(tx_bd_num_reg,32'h00000020,"RW");

lock_model();
endclass 
