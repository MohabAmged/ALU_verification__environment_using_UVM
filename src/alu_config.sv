`ifndef ALU_cfg__SV
`define ALU_cfg__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
class alu_cfg extends uvm_object;
   
    // factory Registration macro 
    `uvm_object_utils(alu_cfg)

    virtual alu_interafce dut_vi ;
    // Is the agent active or passive
    uvm_active_passive_enum mode = UVM_ACTIVE; 
    // constructor
    function new(string name="");
        super.new(name);
    endfunction //new()



endclass //alu_cfg extends uvm_object

`endif // AGENT__SV