//auto generated test by : MR_X
//Dec:12:2020
`include "InstructionMemory.v"
module InstructionMemory_tb ();
initial begin
$dumpfile("InstructionMemory.vcd");
$dumpvars(0, InstructionMemory_tb);
end
initial clk = 0;
always #20 clk = ~clk;
//insert inputs
reg clk; reg[7:0]address ;
//insert outputs
wire [15:0]instruction_output ;
//make new instance of module here
InstructionMemory instance1( clk, address, instruction_output);
initial
begin
address = 0;
#40;
address = 1;
#40;
address = 14;
#40;
$finish;
end
endmodule //InstructionMemory_tb