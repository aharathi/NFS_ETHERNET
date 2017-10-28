
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

//`include "../uvm_register-2.0/src/uvm_register_pkg.sv"
	  
//import uvm_pkg::*;
//import uvm_register_pkg::*;

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
int unsigned tx_buf_num;
string my_name = "TX_BUF_NUM";

function new(string name = my_name);
super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();
RESERVED	= uvm_reg_field::type_id::create("RESERVED");
TxBD		= uvm_reg_field::type_id::create("TxBD");

RESERVED.configure(this,24,8,"RW",0,24'b0,1,1,0);
// take the argument here and configure

if ($value$plusargs("TX_BD_NUM=%h",tx_buf_num)) begin //{
//`uvm_info({my_name,"::build function"},$sformatf("Got the number of buffer desctipters %0d",tx_buf_num),UVM_DEBUG)
TxBD.configure(this,8,0,"RW",0,tx_buf_num,1,1,0);
end //}
else begin //{
TxBD.configure(this,8,0,"RW",0,8'h40,1,1,0);
end //}
endfunction
endclass 

//MIIMODER Register Declaration

class miimoder extends uvm_reg;
`uvm_object_utils(miimoder);

rand uvm_reg_field RESERVED;
rand uvm_reg_field MIINOPRE;
rand uvm_reg_field CLKDIV;

function new(string name = "MIIMODER");
	super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();
RESERVED	= uvm_reg_field::type_id::create("RESERVED");
MIINOPRE	= uvm_reg_field::type_id::create("MIINOPRE");
CLKDIV		= uvm_reg_field::type_id::create("CLKDIV");

RESERVED.configure(this,23,9,"RW",0,23'b0,1,1,0);
MIINOPRE.configure(this,1,8,"RW",0,1'b0,1,1,0);
CLKDIV.configure(this,8,0,"RW",0,8'b0,1,1,0);
endfunction
endclass

//MIISTATUS  Register Declaration

class miistatus extends uvm_reg;
`uvm_object_utils(miistatus);

rand uvm_reg_field RESERVED;
rand uvm_reg_field NVALID;
rand uvm_reg_field BUSY;
rand uvm_reg_field LINKFAIL;

function new(string name = "MIISTATUS");
	super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();
RESERVED	= uvm_reg_field::type_id::create("RESERVED");
NVALID		= uvm_reg_field::type_id::create("NVALID");
BUSY		= uvm_reg_field::type_id::create("BUSY");
LINKFAIL	= uvm_reg_field::type_id::create("LINKFAIL");

RESERVED.configure(this,29,3,"RW",0,29'b0,1,1,0);
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
rand tx_buf_des buff_d_tx_reg[];
rand pntr tx_pntr_reg[];
rand rx_buf_des buff_d_rx_reg[];
rand pntr rx_pntr_reg[];
string my_name = "eth_reg_block";
int unsigned tx_buf_num;

uvm_reg_map ETH_map;

function new(string name= my_name);
super.new(name,UVM_NO_COVERAGE); 
if ($value$plusargs("TX_BD_NUM=%h",tx_buf_num)) begin //{
`uvm_info({my_name,":: new"},$sformatf("Got the number of buffer desctipters %0d",tx_buf_num),UVM_DEBUG)
if (tx_buf_num > `NUM_BUF_D) begin //{
`uvm_error (my_name,"illegal number of buffer descriptors having default")
tx_buf_num = 'h40;
end //}
end //}
else begin //{
tx_buf_num = 'h40;
`uvm_info({my_name,":: new"},$sformatf("No commandline arg! number of buffer desctipters %0d",tx_buf_num),UVM_DEBUG)
end //}

buff_d_tx_reg = new [tx_buf_num];
tx_pntr_reg = new [tx_buf_num];
buff_d_rx_reg = new [`NUM_BUF_D - tx_buf_num];
rx_pntr_reg = new [`NUM_BUF_D - tx_buf_num];
//`uvm_info({my_name,":: new"},$sformatf("buff_d_tx=%0d,tx_pntr=%0d,buff_d_rx=%0d,rx_pntr=%0d",buff_d_tx.size(),tx_pntr.size(),buff_d_rx.size(),rx_pntr.size()),UVM_DEBUG)
endfunction 


virtual function void build();

string s;
int unsigned BD_ADDR;

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


//`uvm_info({my_name,":: build"},$sformatf("size of tx buffer descripters %0d",buff_d_tx.size()),UVM_DEBUG)


for (int i=0;i <= buff_d_tx_reg.size() - 1;i++) begin //{
$sformat(s,"buff_d_tx_reg[%0d]",i);
buff_d_tx_reg[i] = tx_buf_des::type_id::create(s);
buff_d_tx_reg[i].configure(this,null,"");
buff_d_tx_reg[i].build();
//`uvm_info({my_name,":: build"},$sformatf("created and built %s",s),UVM_DEBUG)
end //}

for (int i=0;i<= tx_pntr_reg.size() - 1;i++) begin //{
$sformat(s,"tx_pntr[%0d]",i);
tx_pntr_reg[i] = pntr::type_id::create(s);
tx_pntr_reg[i].configure(this,null,"");
tx_pntr_reg[i].build();
end //}


for(int i=0;i<= buff_d_rx_reg.size() - 1;i++) begin //{
$sformat(s,"buff_d_rx_reg[%0d]",i);
buff_d_rx_reg[i] = rx_buf_des::type_id::create(s);
buff_d_rx_reg[i].configure(this,null,"");
buff_d_rx_reg[i].build();
end //}

for (int i=0;i<= rx_pntr_reg.size() - 1;i++) begin //{
$sformat(s,"rx_pntr_reg[%0d]",i);
rx_pntr_reg[i] = pntr::type_id::create(s);
rx_pntr_reg[i].configure(this,null,"");
rx_pntr_reg[i].build();
end //}

	


//ETH_map = create_map("ETH_map",'h0,4,UVM_LITTLE_ENDIAN);
//
//ETH_map.add_reg(moder_reg,32'h00000000,"RW");
//ETH_map.add_reg(tx_bd_num_reg,32'h00000020,"RW");
//ETH_map.add_reg(miimoder_reg,32'h00000028,"RW");
//ETH_map.add_reg(miistatus_reg,32'h0000003C,"RW");

ETH_map = create_map("ETH_map",`ETH_BASE,4,UVM_LITTLE_ENDIAN);

ETH_map.add_reg(moder_reg,`ETH_MODER,"RW");
ETH_map.add_reg(tx_bd_num_reg,`ETH_TX_BD_NUM,"RW");
ETH_map.add_reg(miimoder_reg,`ETH_MIIMODER,"RW");
ETH_map.add_reg(miistatus_reg,`ETH_MIISTATUS,"RW");

BD_ADDR = `TX_BD_BASE;
for(int i=0;i<=buff_d_tx_reg.size() - 1;i++) begin //{
ETH_map.add_reg(buff_d_tx_reg[i],BD_ADDR,"RW");
//`uvm_info({my_name,":: build"},$sformatf("Programming tx BD %0d at address %h",i,BD_ADDR),UVM_DEBUG)
BD_ADDR += 32'h4;
ETH_map.add_reg(tx_pntr_reg[i],BD_ADDR,"RW");
//`uvm_info({my_name,":: build"},$sformatf("Programming tx ptr %0d at address %h",i,BD_ADDR),UVM_DEBUG)
BD_ADDR += 32'h4;
end //}

for (int i=0;i<= buff_d_rx_reg.size() - 1;i++) begin //{
ETH_map.add_reg(buff_d_rx_reg[i],BD_ADDR,"RW");
//`uvm_info({my_name,":: build"},$sformatf("Programming rx BD %0d at address %h",i,BD_ADDR),UVM_DEBUG)
BD_ADDR += 32'h4;
ETH_map.add_reg(rx_pntr_reg[i],BD_ADDR,"RW");
//`uvm_info({my_name,":: build"},$sformatf("Programming rx ptr %0d at address %h",i,BD_ADDR),UVM_DEBUG)
BD_ADDR += 32'h4;
end //}



lock_model();
endfunction

endclass 


