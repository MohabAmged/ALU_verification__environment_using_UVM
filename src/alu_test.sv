`ifndef ALU_test__SV
`define ALU_test__SV
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "alu_config.sv"
`include "alu_sequence.sv"
`include "ALU_ENV.sv"
`include "corner_cases_seq.sv"


class alu_test extends uvm_test;
   
    // factory Registration macro 
    `uvm_component_utils(alu_test)

    // config instace 
    alu_cfg cfg_h;

    // components instance
    alu_env env ;
    alu_sequence seq ;
    corner_seq Z_seq ;

    // constructor
    function new(string name="alu_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()


    // build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // create config object 
        cfg_h = alu_cfg::type_id::create("cfg_h",this);
        env=alu_env::type_id::create("env",this);
        seq = alu_sequence::type_id::create("seq",this) ;
        Z_seq = corner_seq::type_id::create("Z_seq",this) ;
        
        // propagate configurations to agent 
        if (!uvm_config_db#(alu_cfg)::get(this,"","alu_cfg",cfg_h)) begin
            `uvm_fatal(get_name(),"no cfg")
        end 
        // propagate configurations to env 
        uvm_config_db#(alu_cfg)::set(this,"env","alu_cfg",cfg_h);

        // instantiate env 
        $display("ALU_test Build");

  
    endfunction


    // run phase 
    task run_phase(uvm_phase phase);
    // sequence instance 
    phase.raise_objection(this , "seq start");
    // first seq start 
    Z_seq.start(env.agent.sequencer);
    // 2nd seq start
    seq.start(env.agent.sequencer);
    phase.drop_objection(this , "seq finish");
    endtask


endclass //alu_env extends uvm_env

`endif // test