`ifndef ALU_sequence__SV
`define ALU_sequence__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sequence_item.sv"


class alu_sequence extends uvm_sequence #(alu_seq_item);
   
    // factory Registration macro 
    `uvm_object_utils(alu_sequence)

    uvm_analysis_port#(alu_seq_item) analysis_port ;
   

    // constructor
    function new(string name="alu_sequence");
        super.new(name);
    endfunction //new()

    // body 
    task body ();
        int a=200;
        alu_seq_item item=alu_seq_item::type_id::create("item");        
        repeat(a) begin
         start_item(item);
         assert ( item.randomize() with {opA < 'h0000_FFFF;opB < 'h0000_FFFF;} ) 
         else   `uvm_fatal(get_name(),"seq item randmoize fail");
         finish_item(item);   
        end
        repeat(a) begin
         start_item(item);
         assert ( item.randomize() with {opA >= 'h0000_FFFF;opB >= 'h0000_FFFF;} ) 
         else   `uvm_fatal(get_name(),"seq item randmoize fail");
         finish_item(item);   
        end


    endtask //body



endclass //alu_env extends uvm_env

`endif // AGENT__SV