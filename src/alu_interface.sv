`ifndef ALU_interface__SV
`define ALU_interface__SV


interface alu_interafce(input bit clk );

    logic [3] opcode  ;
    logic [32] opA     ;
    logic [32] opB     ;
    logic [32] out     ;
    logic [1] flag    ; 

endinterface //dut_i

`endif // AGENT__SV