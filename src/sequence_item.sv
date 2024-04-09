`ifndef ALU_seq_item__SV
`define ALU_seq_item__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
class alu_seq_item extends uvm_sequence_item;
   
    // factory Registration macro 
   
    rand bit   [3]  opcode     ;
    rand logic [32] opA        ;
    rand logic [32] opB        ;
         logic [32] out        ;
         logic      zero_flag  ;

         //constraint upper_half { opA >= 0x0000_FFFF;opB >= 0x0000_FFFF;} 
         //constraint lower_half { opA < 0x0000_FFFF;opB < 0x0000_FFFF;}    
    // constructor
    function new(string name="");
        super.new(name);
    endfunction //new()

    
        // add fields to the print func 
        `uvm_object_utils_begin(alu_seq_item)
        `uvm_field_int(opA,UVM_DEFAULT)
        `uvm_field_int(opB,UVM_DEFAULT)
        `uvm_field_int(opcode,UVM_DEFAULT)
        `uvm_field_int(out,UVM_DEFAULT)
        `uvm_field_int(zero_flag,UVM_DEFAULT)
        `uvm_object_utils_end 

endclass //alu_seq_item extends uvm_sequence_item

`endif // AGENT__SV