
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

//List of registers definitions 

class moder extends uvm_reg;
`uvm_object_utils(moder)

rand uvm_reg_field rxen; //receive enable
rand uvm_reg_field txen; //transmit enable
rand uvm_reg_field nopre; //no preamble 
rand uvm_reg_field bro; //broadcast address
rand uvm_reg_field iam; //individual address mode 
rand uvm_reg_field pro; //promiscuious 
rand uvm_reg_field ifg; 
// fill in the other fields
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field; 
rand uvm_reg_field reserved_1; //reserved 31:17

function new(string name = "MODER");
super.new(name,32,UVM_NO_COVERAGE);
endfunction 

virtual function void biuld();

 rxen	= uvm_reg_field::type_id::create("rxen");
 txen	= uvm_reg_field::type_id::create("txen");
 nopre	= uvm_reg_field::type_id::create("nopre");
 bro	= uvm_reg_field::type_id::create("bro");
 iam	= uvm_reg_field::type_id::create("iam");
 pro	= uvm_reg_field::type_id::create("pro");
 ifg	= uvm_reg_field::type_id::create("ifg");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
  = uvm_reg_field::type_id::create("");
 reserved_1 = uvm_reg_field::type_id::create("reserved_1");

 rxen.configure(this,1,0,"RW",0,1'b0,1,1,0);
 txen.configure(this,1,1,"RW",0,1'b0,1,1,0);
 nopre.configure(this,1,2,"RW",0,1'b0,1,1,0);
 bro.configure(this,1,3,"RW",0,1'b0,1,1,0);
 iam.configure(this,1,4,"RW",0,1'b0,1,1,0);
 pro.configure(this,1,5,"RW",0,1'b0,1,1,0);
 ifg.configure(this,1,6,"RW",0,1'b0,1,1,0);
 .configure(this,1,7,"RW",0,1'b0,1,1,0);
 .configure(this,1,8,"RW",0,1'b0,1,1,0);
 .configure(this,1,9,"RW",0,1'b0,1,1,0);
 .configure(this,1,10,"RW",0,1'b0,1,1,0);
 .configure(this,1,11,"RW",0,1'b0,1,1,0);
 .configure(this,1,12,"RW",0,1'b0,1,1,0);
 .configure(this,1,13,"RW",0,1'b0,1,1,0);
 .configure(this,1,14,"RW",0,1'b0,1,1,0);
 .configure(this,1,15,"RW",0,1'b0,1,1,0);
 .configure(this,1,16,"RW",0,1'b0,1,1,0);
 reserved_1.configure(this,15,17,"RW",0,15'h0000,1,1,0);
endfunction
endclass 

//declare other registers 

class tx_bd_num extends uvm_reg;
endclass 




//Register map

class eth_reg_block extends uvm_reg_block;
`uvm_object_utils(eth_reg_block)

rand moder moder_reg;
rand tx_bd_num tx_bd_num_reg;
//include other registers 



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

//build other registers 


ETH_map = create_map("ETH_map",'h0,4,UVM_LITTLE_ENDIAN);


ETH_map.add_reg(moder_reg,32'h00000000,"RW");

ETH_map.add_reg(tx_bd_num_reg,32'h00000020,"RW");


lock_model();


endclass 

