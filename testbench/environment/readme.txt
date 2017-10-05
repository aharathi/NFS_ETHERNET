enviroment files



//ethernet transaction class declaration 
class eth_transaction extends uvm_sequence_item;
 
//ethernet packet field ranomization 
  rand bit [55:0] preamble;
  rand bit [7:0] sfd;
  rand bit [47:0] dst_addr;
  rand bit [47:0] src_addr;
  rand bit [15:0] data_len; // this length can accomodate MAXIMUM length of 1500
  rand bit [7:0] payload [];
  rand bit [31:0] crc;    
 
  rand int unsigned transmit_delay;//transmit delay between transfers
  
  constraint c_delay {transmit_delay==10;}//constraint on transmit delay-constraint as per need
 
//constraint on specific field
 
constraint preamble_con{
                        preamble=={7{8'haa}};
                        }
  
constraint sfd_con{
                   sfd== 8'hab;
                   }
    
constraint data_len_con{
                        data_len inside {[46:1500]};
                        solve data_len before payload;
                       }
 
constraint payload_con{
                        payload.size==data_len;
                       }
 
 
 
//macro registraton
`uvm_object_utils_begin(eth_transaction)
  
  `uvm_field_int(preamble,UVM_ALL_ON|UVM_NOPACK)
  `uvm_field_int(sfd,UVM_ALL_ON|UVM_NOPACK)
  `uvm_field_int(dst_addr,UVM_ALL_ON|UVM_NOPACK)
  `uvm_field_int(src_addr,UVM_ALL_ON|UVM_NOPACK)
  `uvm_field_int(data_len,UVM_ALL_ON|UVM_NOPACK)
  `uvm_field_array_int(payload,UVM_ALL_ON|UVM_NOPACK)
  `uvm_field_int(crc,UVM_ALL_ON|UVM_NOPACK)
  `uvm_field_int(transmit_delay,UVM_DEFAULT|UVM_NOCOMPARE|UVM_NOPACK)
 
`uvm_object_utils_end
 
//constructor
function new(string name = "eth_transaction");
  super.new(name);
endfunction
  
//display method  
function void display(string strng);
 
  $display("\n@time=%0g\tpacket displaying from %s",$time,strng);
  $display("||==============||======||============||============||============||===============||========||");
  $display("|| preamble     || sfd  || dst_addr   || src_addr   ||   data_Len ||   payload_Len ||  crc   ||");
  $display("||--------------||------||------------||------------||------------||---------------||--------||");
  $display("||%h||  %h  ||%h||%h||    %4d    ||     %6d    ||%h||",preamble,
                                                                   sfd,
                                                                   dst_addr,
                                                                   src_addr,
                                                                   data_len,
                                                                   payload.size,
                                                                   crc);
  $display("||==============||======||============||============||============||===============||========||");
  $display("\n");
 
endfunction
 
//pack all bits of ethernet packet field
function void do_pack(uvm_packer packer);
  
  super.do_pack(packer); // pack super's properties
  
  packer.pack_field_int(preamble,$bits(preamble));
  packer.pack_field_int(sfd,$bits(sfd));
  packer.pack_field_int(dst_addr,$bits(dst_addr));
  packer.pack_field_int(src_addr,$bits(src_addr));
  packer.pack_field_int(data_len,$bits(data_len));
  foreach(payload)
  packer.pack_field_int(payload,8);
  packer.pack_field_int(crc,$bits(crc));
  
endfunction : do_pack
    
//unpack all bits of ethernet packet field
function void do_unpack(uvm_packer packer);
  
  super.do_unpack(packer); // unpack super's properties
    
  preamble = packer.unpack_field_int($bits(preamble));
  sfd = packer.unpack_field_int($bits(sfd));
  dst_addr = packer.unpack_field_int($bits(dst_addr));
  src_addr = packer.unpack_field_int($bits(src_addr));
  data_len = packer.unpack_field_int($bits(data_len));
  payload.delete();
  payload = new[data_len];
  foreach(payload)
  payload = packer.unpack_field_int(8);
  crc = packer.unpack_field_int($bits(crc));
  
endfunction : do_unpack
 
//do_compare method -to compare specific field
function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    eth_transaction rhs_;
    bit status=1;
    $cast(rhs_,rhs);
    status &= (preamble == rhs_.preamble);
    status &= (sfd == rhs_.sfd);
    status &= (dst_addr == rhs_.dst_addr);
    status &= (src_addr == rhs_.src_addr);
    status &= (data_len == rhs_.data_len);
    status &= (payload == rhs_.payload);
    status &= (crc == rhs_.crc);
    return status;
endfunction
 
endclass: eth_transaction

