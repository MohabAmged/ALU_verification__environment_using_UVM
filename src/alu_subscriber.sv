`ifndef ALU_subs__SV
`define ALU_subs__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sequence_item.sv"
class alu_subscriber extends uvm_subscriber #(alu_seq_item) ;

// item instance 
alu_seq_item item_subs;

covergroup alu_cover_group ;

op_code:    coverpoint item_subs.opcode     {

    bins and__bin = {0};
    bins or__bin  = {1};
    bins add__bin = {2};
    bins xor__bin = {3};
    bins nor__bin = {4};
    bins nand__bin= {5};
    bins sub__bin = {6};
    bins slt__bin = {7};
    bins and_or_add__bin       = (0 => 1 => 2) ;
    bins nor_nand__bin         = (4 => 5) ;
    bins logic_operations__bin = {0 , 1 , [3:5] };
    bins arith_operations__bin = {2 , 6 };    
    bins default__bin    = default  ;

}
operand_A: coverpoint item_subs.opA  {

    bins least_half_range__bin = {[0:'hEFFF_FFFF]};
    bins most_half_rang__bin   = {['hF000_0000:'hFFFF_FFFF]};
    bins all_ones__bin         = {'hFFFF_FFFF};
    bins zero__bin             = {0};
    bins default__bin = default;

}      
operand_B: coverpoint item_subs.opB       {
    bins least_half_range__bin = {[0:'hEFFF_FFFF]};
    bins most_half_rang__bin   = {['hF000_0000:'hFFFF_FFFF]};
    bins all_ones__bin         = {'hFFFF_FFFF};
    bins zero__bin             = {0};    
    bins default__bin = default;

}
output__ : coverpoint item_subs.out        {

    bins least_half_range__bin = {[0:'hEFFF_FFFF]};
    bins most_half_rang__bin   = {['hF000_0000:'hFFFF_FFFF]};
    bins all_ones__bin         = {'hFFFF_FFFF};
    bins zero__bin             = {0};    
    bins default__bin = default;


}
zero_flag: coverpoint item_subs.zero_flag  {
    bins Zero__bin = {0};
    bins One__bin  = {1};
}


opc_operand_A_cross:cross op_code , operand_A {

    bins All_ones_with_add__bin     = binsof (operand_A) intersect {'hFFFF_FFFF} && binsof(op_code) intersect {2};
    bins All_ones_with_sub__bin     = binsof (operand_A) intersect {'hFFFF_FFFF} && binsof(op_code) intersect {6};
    bins All_zero_with_add__bin     = binsof (operand_A) intersect {0} && binsof(op_code) intersect {2};
    bins All_zero_with_sub__bin     = binsof (operand_A) intersect {0} && binsof(op_code) intersect {6};
    ignore_bins All_ones_with_logic__bin = binsof(operand_A) intersect {'hFFFF_FFFF} && binsof(op_code) intersect{0 , 1 , [3:5] };

}

opc_operand_B_cross:cross op_code , operand_B {

    bins All_ones_with_add__bin     = binsof (operand_B) intersect {'hFFFF_FFFF} && binsof(op_code) intersect {2};
    bins All_ones_with_sub__bin     = binsof (operand_B) intersect {'hFFFF_FFFF} && binsof(op_code) intersect {6};
    bins All_zero_with_add__bin     = binsof (operand_B) intersect {0} && binsof(op_code) intersect {2};
    bins All_zero_with_sub__bin     = binsof (operand_B) intersect {0} && binsof(op_code) intersect {6};    
    ignore_bins All_ones_with_logic__bin = binsof(operand_B) intersect {'hFFFF_FFFF} && binsof(op_code) intersect{0 , 1 , [3:5] };

}

opc_output_cross:cross op_code , output__ {

    bins All_ones_with_add__bin  = binsof (output__) intersect {'hFFFF_FFFF} && binsof(op_code) intersect {2};
    bins All_ones_with_sub__bin  = binsof (output__) intersect {'hFFFF_FFFF} && binsof(op_code) intersect {6};
    bins All_zero_with_add__bin  = binsof (output__) intersect {0} && binsof(op_code) intersect {2};
    bins All_zero_with_sub__bin  = binsof (output__) intersect {0} && binsof(op_code) intersect {6};    
    bins All_ones_with_logic__bin  = binsof(output__) intersect {'hFFFF_FFFF} && binsof(op_code) intersect{0 , 1 , [3:5] };
    bins All_zeros_with_logic__bin  = binsof(output__) intersect {0} && binsof(op_code) intersect{0 , 1 , [3:5] };
    bins anypoint__bin = binsof(output__)  && binsof(op_code);
}



endgroup 
    
    // factory Registration macro 
    `uvm_component_utils(alu_subscriber)

    // constructor
    function new(string name="alu_subscriber",uvm_component parent = null);
        super.new(name,parent);
        alu_cover_group=new();
    endfunction //new()

    // build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_subs  = alu_seq_item::type_id::create("item",this);
        $display("ALU_subscriber Build");
    endfunction
    // connect phase 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("ALU_subscriber connect");
    endfunction

    // analysis export write function 
    function void write (alu_seq_item t);
    item_subs.opcode=t.opcode ;
    item_subs.opA=t.opA ;
    item_subs.opB=t.opB ;
    item_subs.out=t.out ;
    item_subs.zero_flag=t.zero_flag ;
    alu_cover_group.sample();
    endfunction


   
endclass //alu_env extends uvm_env

`endif // AGENT__SV