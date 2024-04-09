`ifndef ALU_sequence_zero__SV
`define ALU_sequence_zero__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sequence_item.sv"
`include "alu_sequence.sv"


class zero_seq extends alu_sequence;
   
    // factory Registration macro 
    `uvm_object_utils(zero_seq)
   
    bit [4] op_codes = 0;
    // constructor
    function new(string name="zero_seq");
        super.new(name);
    endfunction //new()

    // body 
    task body ();

        // object instance
         alu_seq_item item=alu_seq_item::type_id::create("item");
         for ( op_codes= 0;op_codes<8 ; op_codes=op_codes+1) begin
         start_item(item);
         assert ( item.randomize() with {opA<=0;opB<=0; opcode==op_codes;} ) 
         else   `uvm_fatal(get_name(),"seq item randmoize fail");
         finish_item(item);   
        end

    endtask //body



endclass //alu_env extends uvm_env

`endif // AGENT__SV