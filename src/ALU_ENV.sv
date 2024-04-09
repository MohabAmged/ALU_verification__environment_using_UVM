`ifndef ALU_ENV__SV
`define ALU_ENV__SV
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "alu_agent.sv"
`include "alu_config.sv"
`include "alu_scoreboard.sv"
`include "alu_subscriber.sv"
class alu_env extends uvm_env;
   
    // factory Registration macro 
    `uvm_component_utils(alu_env)
    // analysis expot

    // config instace 
    alu_cfg cfg_h;

    // components instances 
    alu_agent agent;
    alu_scoreboard score_board;
    alu_subscriber subscriber ;

    // constructor
    function new(string name="alu_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()


    // build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg_h = alu_cfg::type_id::create("cfg_h",this);
        // propagate configurations to agent 
        if (!uvm_config_db#(alu_cfg)::get(this,"","alu_cfg",cfg_h)) begin
            `uvm_fatal(get_name(),"no cfg")
        end 

        // propagate configurations to agent 
        uvm_config_db#(alu_cfg)::set(this,"agent","cfg_h",cfg_h);

        // create agent 
        agent=alu_agent::type_id::create("agent",this);
        // create score_board
        score_board=alu_scoreboard::type_id::create("score_board",this);
        // create subscriber 
        subscriber=alu_subscriber::type_id::create("subscriber",this);
        $display("ALU_ENV Build");
  
    endfunction


    // connect phase 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
                $display("ENV connect");
        // connect agent to the scoreboard
        agent.monitor.analysis_port.connect(score_board.scoreboard_fifo.analysis_export);
        // connect monitor to subscriber 
        agent.monitor.analysis_port.connect(subscriber.analysis_export);

    endfunction


endclass //alu_env extends uvm_env

`endif // AGENT__SV