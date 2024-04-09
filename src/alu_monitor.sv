`ifndef ALU_MONITOR__SV
`define ALU_MONITOR__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "alu_config.sv"
`include "sequence_item.sv"
`include "alu_interface.sv"

class alu_monitor extends uvm_monitor;

    // factory Registration macro 
    `uvm_component_utils(alu_monitor)

    uvm_analysis_port#(alu_seq_item) analysis_port ;

    // config instance 
    alu_cfg cfg_h;
    
    virtual alu_interafce dut_vi;

    // object instance
    alu_seq_item item;
   
    // constructor
    function new(string name="alu_monitor",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    // build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // config class 
        cfg_h = alu_cfg::type_id::create("cfg_h",this);
        // seq_item create
        item = alu_seq_item::type_id::create("item",this);

        // getting the cfg from the env 
    if (!uvm_config_db#(alu_cfg)::get(this,"","alu_cfg",cfg_h)) begin
            `uvm_fatal(get_name(),"no cfg")
        end 

        // monitor analysis port 
        analysis_port =new("analysis_port",this);
        $display("ALU_monitor Build");
    endfunction
    // connect phase 
    function void connect_phase(uvm_phase phase);
        $display("monitor connect");
        super.connect_phase(phase);
        dut_vi=cfg_h.dut_vi;
    endfunction

    // run phase 
    task run_phase(uvm_phase phase);

    forever begin
    @(posedge dut_vi.clk) begin
    item.opcode    = dut_vi.opcode  ;
    item.opA       = dut_vi.opA     ;
    item.opB       = dut_vi.opB     ;
    end
    @(negedge dut_vi.clk ) begin
    item.out       = dut_vi.out     ;
    item.zero_flag = dut_vi.flag    ;
    end
    analysis_port.write(item);
    end

    endtask //automatic

endclass //alu_env extends uvm_env

`endif // AGENT__SV