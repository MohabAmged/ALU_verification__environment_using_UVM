`include "alu_config.sv"
`include "alu_interface.sv"
`include "alu_test.sv"
`include "alu.v"
import uvm_pkg::*;
module top;

   logic clk=0;
   alu_interafce IF_inst(clk) ;
   alu_cfg cfg_h = new();
   alu  #(32 , 3) alu_inst (
   .ALUControl(IF_inst.opcode),
   .SrcA(IF_inst.opA),
   .SrcB(IF_inst.opB),
   .zero(IF_inst.flag),
   .ALUResult(IF_inst.out)
   );


initial begin
    // clock to drive the inputs and sample the output 
    // the design is fully combinational 
    forever begin
        #5 clk=~clk ;
    end
end


initial begin
    cfg_h.dut_vi=IF_inst;
    uvm_config_db#(alu_cfg)::set(uvm_root::get() ,"","alu_cfg",cfg_h);
    run_test("alu_test");
end



endmodule
