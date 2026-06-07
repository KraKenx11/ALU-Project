# ALU-Project

You have to design in Verilog, System Verilog, or VHDL an ALU. Your design should implement the following functions:

Addition
Subtraction
Multiplication
Division
AND
OR
XOR
LEFT SHIFT
RIGHT SHIFT
The ALU must have the following input and output signals:

Two 8-bit input operands (A and B) that provide the values to be processed.
Control signals to select the operation the ALU should perform.
8-bit output result representing the outcome of the selected operation.
Status flags to indicate the state of the result:
Zero (Z): Set if the result is zero.
Negative (N): Set if the result is negative (most significant bit = 1).
Overflow (V): Set if a signed arithmetic overflow occurs.

Testbench (tb_module):
<img width="1476" height="285" alt="image" src="https://github.com/user-attachments/assets/424ee645-88af-4bd0-bd9a-ae9ecf63b925" />

Testbench (tb_alu_top):
<img width="1472" height="167" alt="image" src="https://github.com/user-attachments/assets/d9d6d5f6-e7a2-4114-9bac-9c397c947d6c" />
