`ifndef ALU_score_board__SV
`define ALU_score_board__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "alu_config.sv"
`include "sequence_item.sv"
class alu_scoreboard extends uvm_scoreboard ;


    // factory Registration macro 
    `uvm_component_utils(alu_scoreboard)

    uvm_tlm_analysis_fifo #(alu_seq_item) scoreboard_fifo;

    // config instace 
    alu_cfg cfg_h;
   

   
    // constructor
    function new(string name="alu_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    // build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // config class 
        cfg_h = alu_cfg::type_id::create("cfg_h",this);
        scoreboard_fifo=new("scoreboard_fifo",this);
        // getting the cfg from the env 
    if (!uvm_config_db#(alu_cfg)::get(this,"","alu_cfg",cfg_h)) begin
            `uvm_fatal(get_name(),"no cfg")
        end 

        // score_board analysis export 
        //analysis_export = new("analysis_export",this);

        $display("ALU_scoreboard Build");
    endfunction
    // connect phase 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("ALU_scoreboard connect");
    endfunction

    function void write_a (alu_seq_item item);
        item.print();
    endfunction

    function void check_item(alu_seq_item item);
        alu_seq_item expected = new();
        case (item.opcode)
          3'b000  : begin
            write_a(item);
            expected.out=item.opA&item.opB ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("AND Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"AND checking failed")
            end
          end
          3'b001  : begin
            write_a(item);
            expected.out=item.opA|item.opB ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("OR Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"OR checking failed")
            end
          end
          3'b111  : begin
            write_a(item);
            expected.out=(item.opA<item.opB?'b1:'b0) ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("SLT Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"SLT checking failed")
            end
          end          
          3'b010  : begin
            write_a(item);
            expected.out=item.opA+item.opB ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("ADD Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"ADD checking failed")
            end
          end   
          3'b110  : begin
            write_a(item);
            expected.out=item.opA-item.opB ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("SUB Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"SUB checking failed")
            end
          end  
          3'b011  : begin
            write_a(item);
            expected.out=item.opA^item.opB ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("XOR Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"XOR checking failed")
            end
          end
          3'b100  : begin
            write_a(item);    
            expected.out=~(item.opA|item.opB) ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("NOR Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"NOR checking failed")
            end
          end                             
          3'b101  : begin
            write_a(item);    
            expected.out=~(item.opA&item.opB) ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("NAND Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"NAND checking failed")
            end
          end    
            default: begin    
            write_a(item);    
            expected.out=item.opA+item.opB ;
            expected.zero_flag=~(|item.out) ;
            if ( (expected.out === item.out) && (expected.zero_flag===item.zero_flag) ) begin
                $display("default Test Passed");
            end
            else begin
                `uvm_fatal(get_name(),"default checking failed")
            end
          end               
        endcase
        
    endfunction
    // run phase 
    task run_phase(uvm_phase phase);
    // seq_item create
        // object instance
        alu_seq_item item;
        item  = alu_seq_item::type_id::create("item",this);
      forever begin
        scoreboard_fifo.get(item);
        check_item(item);
        //$display(" score_board \n opA \t%0d\n opB \t%0d\n op_code \t%d\n out\t%d\n zero_flag\t%d\n", item.opA, item.opB, item.opcode, item.out,item.zero_flag);
      end


    endtask //automatic

   
endclass //alu_env extends uvm_env

`endif // AGENT__SV