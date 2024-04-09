`ifndef ALU_AGENT__SV
`define ALU_AGENT__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "alu_agent.sv"
`include "alu_config.sv"
`include "alu_driver.sv"
`include "alu_monitor.sv"
`include "alu_sequencer.sv"
`include "sequence_item.sv"

class alu_agent extends uvm_agent;
   
    // factory Registration macro 
    `uvm_component_utils(alu_agent)

    // config instace 
    alu_cfg cfg_h;

    // components instances 
    alu_driver driver;
    alu_sequencer sequencer;
    alu_monitor monitor;

    // constructor
    function new(string name="",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    // build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // config class 
        cfg_h = alu_cfg::type_id::create("cfg_h",this);

         // getting the cfg from the env 
    if (!uvm_config_db#(alu_cfg)::get(this,"","alu_cfg",cfg_h)) begin
            `uvm_fatal("AGENT","no cfg")
        end 
            
    if (cfg_h.mode == UVM_ACTIVE) begin
         // create driver 
        driver=alu_driver::type_id::create("driver",this);
        // create sequencer
        sequencer=alu_sequencer::type_id::create("sequencer",this);
        // propagate configurations to driver 
        uvm_config_db#(alu_cfg)::set(this,"driver","alu_cfg",cfg_h);
        end

        // create monitor 
        monitor=alu_monitor::type_id::create("monitor",this);
        uvm_config_db#(alu_cfg)::set(this,"monitor","alu_cfg",cfg_h);


        $display("ALU_agent Build");

    endfunction
    // connect phase 
    function void connect_phase(uvm_phase phase);

        // connect driver to the sequencer 
        driver.seq_item_port.connect(sequencer.seq_item_export) ;
        $display("agent connect");
        
        
    endfunction


endclass //alu_env extends uvm_env

`endif // AGENT__SV