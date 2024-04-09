`ifndef ALU_DRIVER__SV
`define ALU_DRIVER__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "alu_config.sv"
`include "sequence_item.sv"
`include "alu_interface.sv"


class alu_driver extends uvm_driver #(alu_seq_item);
   
    // factory Registration macro 
    `uvm_component_utils(alu_driver)

    // config instace 
    alu_cfg cfg_h;

    virtual alu_interafce dut_vi;


   
    // constructor
    function new(string name="alu_driver",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    // build phase 
    function void build_phase(uvm_phase phase);
       super.build_phase(phase);
        // config class 
        cfg_h = alu_cfg::type_id::create("cfg_h",this);

        // getting the cfg from the env 
    if (!uvm_config_db#(alu_cfg)::get(this,"","alu_cfg",cfg_h)) begin
            `uvm_fatal(get_name(),"no cfg")
        end 
    $display("ALU_driver Build");

    endfunction
    // connect phase 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
         $display("driver connect");
         dut_vi=cfg_h.dut_vi;

    endfunction

    // run phase 
    task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
    // object instance
    alu_seq_item item=alu_seq_item::type_id::create("item",this);
    seq_item_port.get_next_item(item);
    @(posedge dut_vi.clk) begin
    dut_vi.opcode =  item.opcode    ;  
    dut_vi.opA    =  item.opA       ;       
    dut_vi.opB    =  item.opB       ;  
    end
    @(negedge dut_vi.clk ) 
    seq_item_port.item_done();    
    end
    endtask //automatic

endclass //alu_env extends uvm_env

`endif // AGENT__SV