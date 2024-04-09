# ALU_verification__environment_using_UVM
Designed and Verified a simple 32-bits alu using UVM envrionemnt and constrained random testing ,
tested with 400 different random inputs.
# UVM Environment 
Implemented all uvm components : Subscriber , Monitor , Driver , Scoreboard , Sequencer , Env , Test , Sequence , Sequence Item .

 * Architecture
  
 ![image](https://github.com/MohabAmged/ALU_verification__environment_using_UVM/assets/68222258/3d87b438-1408-434e-9a5e-67d785992029)
* Coverage report
  ![Screenshot 2024-04-09 035123](https://github.com/MohabAmged/ALU_verification__environment_using_UVM/assets/68222258/ed8a78f3-f8b3-4365-a329-a8c7e7d59ae5)
* Test sample
  ![Screenshot 2024-04-09 035200](https://github.com/MohabAmged/ALU_verification__environment_using_UVM/assets/68222258/fb84eb13-8d4d-4414-b6fc-8a19e2ed5d7f)
  ![Screenshot 2024-04-09 035208](https://github.com/MohabAmged/ALU_verification__environment_using_UVM/assets/68222258/5a18820e-0e9d-41b1-b498-7b492a812cca)
  
# ALU_DUT
Simple 32-bits alu with 3-bits opcodes and a zero flag.
* OPCODES
  
  | operations | opcode |
  | ---------- | ------ |
  | AND        |  0     |
  | OR         |  1     |
  | ADD        |  2     |
  | XOR        |  3     |
  | NOR        |  4     |
  | NAND       |  5     |
  | SUB        |  6     |
  | SLT        |  7     |

![image](https://github.com/MohabAmged/ALU_verification__environment_using_UVM/assets/68222258/d89b8ef3-0dfd-4ed5-aaf6-be13c53e310e)




