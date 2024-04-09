`ifndef ALU_sequencer__SV
`define ALU_sequencer__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sequence_item.sv"
class alu_sequencer extends uvm_sequencer #(alu_seq_item) ;
    // factory Registration macro 
    `uvm_component_utils(alu_sequencer)   
    // constructor
    function new(string name="alu_sequencer",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()
    
   
endclass //alu_env extends uvm_env

`endif // AGENT__SV