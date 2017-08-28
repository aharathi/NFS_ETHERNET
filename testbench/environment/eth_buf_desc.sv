

class tx_buf_des extends uvm_reg;
`uvm_object_utils(tx_buf_des)

rand uvm_reg_field CS;
rand uvm_reg_field DF;
rand uvm_reg_field LC;
rand uvm_reg_field RL;
rand uvm_reg_field RTRY;
rand uvm_reg_field UR;
rand uvm_reg_field RESERVED;
rand uvm_reg_field CRC;
rand uvm_reg_field PAD;
rand uvm_reg_field WR;
rand uvm_reg_field IRQ;
rand uvm_reg_field RD;
rand uvm_reg_field LEN;

function new(string name = "TX_BUF_DES");
super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();

CS=uvm_reg_field::type_id::create("CS");
DF=uvm_reg_field::type_id::create("DF");
LC=uvm_reg_field::type_id::create("LC");
RL=uvm_reg_field::type_id::create("RL");
RTRY=uvm_reg_field::type_id::create("RTRY");
UR=uvm_reg_field::type_id::create("UR");
RESERVED=uvm_reg_field::type_id::create("RESERVED");
CRC=uvm_reg_field::type_id::create("CRC");
PAD=uvm_reg_field::type_id::create("PAD");
WR=uvm_reg_field::type_id::create("WR");
IRQ=uvm_reg_field::type_id::create("IRQ");
RD=uvm_reg_field::type_id::create("RD");
LEN=uvm_reg_field::type_id::create("LEN");


CS.configure(this,1,0,"RW",0,'b0,1,1,0);
DF.configure(this,1,1,"RW",0,'b0,1,1,0);
LC.configure(this,1,2,"RW",0,'b0,1,1,0);
RL.configure(this,1,3,"RW",0,'b0,1,1,0);
RTRY.configure(this,4,4,"RW",0,'b0,1,1,0);
UR.configure(this,1,8,"RW",0,'b0,1,1,0);
RESERVED.configure(this,2,9,"RW",0,'b0,1,1,0);
CRC.configure(this,1,11,"RW",0,'b0,1,1,0);
PAD.configure(this,1,12,"RW",0,'b0,1,1,0);
WR.configure(this,1,13,"RW",0,'b0,1,1,0);
IRQ.configure(this,1,14,"RW",0,'b0,1,1,0);
RD.configure(this,1,15,"RW",0,'b0,1,1,0);
LEN.configure(this,16,16,"RW",0,'b0,1,1,0);
endfunction 
endclass


class pntr extends uvm_reg;
`uvm_object_utils(pntr)

rand uvm_reg_field PNTR;

function new(string name = "PNTR");
super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();
PNTR = uvm_reg_field::type_id::create("PNTR");
PNTR.configure(this,32,0,"RW",0,32'b0,1,1,0);
endfunction 
endclass



class rx_buf_des extends uvm_reg;
`uvm_object_utils(rx_buf_des)

rand uvm_reg_field LC; 
rand uvm_reg_field CRC; 
rand uvm_reg_field SF; 
rand uvm_reg_field TL; 
rand uvm_reg_field DN; 
rand uvm_reg_field IS; 
rand uvm_reg_field OR; 
rand uvm_reg_field M; 
rand uvm_reg_field CF; 
rand uvm_reg_field RESERVED; 
rand uvm_reg_field WR; 
rand uvm_reg_field IRQ; 
rand uvm_reg_field E; 
rand uvm_reg_field LEN; 

function new(string name = "RX_BUF_DES");
super.new(name,32,UVM_NO_COVERAGE);
endfunction

virtual function void build();

LC = uvm_reg_field::type_id::create("LC");
CRC = uvm_reg_field::type_id::create("CRC");
SF = uvm_reg_field::type_id::create("SF");
TL = uvm_reg_field::type_id::create("TL");
DN = uvm_reg_field::type_id::create("DN");
IS = uvm_reg_field::type_id::create("IS");
OR = uvm_reg_field::type_id::create("OR");
M = uvm_reg_field::type_id::create("M");
CF = uvm_reg_field::type_id::create("CF");
RESERVED = uvm_reg_field::type_id::create("RESERVED");
WR = uvm_reg_field::type_id::create("WR");
IRQ = uvm_reg_field::type_id::create("IRQ");
E = uvm_reg_field::type_id::create("E");
LEN = uvm_reg_field::type_id::create("LEN");


LC.configure(this,1,0,"RW",0,'b0,1,1,0);
CRC.configure(this,1,1,"RW",0,'b0,1,1,0);
SF.configure(this,1,2,"RW",0,'b0,1,1,0);
TL.configure(this,1,3,"RW",0,'b0,1,1,0);
DN.configure(this,1,4,"RW",0,'b0,1,1,0);
IS.configure(this,1,5,"RW",0,'b0,1,1,0);
OR.configure(this,1,6,"RW",0,'b0,1,1,0);
M.configure(this,1,7,"RW",0,'b0,1,1,0);
CF.configure(this,1,8,"RW",0,'b0,1,1,0);
RESERVED.configure(this,4,9,"RW",0,'b0,1,1,0);
WR.configure(this,1,13,"RW",0,'b0,1,1,0);
IRQ.configure(this,1,14,"RW",0,'b0,1,1,0);
E.configure(this,1,15,"RW",0,'b0,1,1,0);
LEN.configure(this,16,16,"RW",0,'b0,1,1,0);

endfunction 
endclass




