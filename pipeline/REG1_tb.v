`include "REG1.v"
module REG1_tb #(parameter reg_size = 12) ();

initial begin
$dumpfile("REG1.vcd");
$dumpvars(0, REG1_tb);
end
//use iverilog -o REG1 REG1_tb.v to generate vcd file,
//use vvp REG1 to simulate.

reg clk,reset;
reg [reg_size-1:0] serial_input;
wire[reg_size-1:0] serial_output;

initial clk = 0;
always #20 clk = ~clk;

REG1 #(.reg_size(reg_size)) register1(clk,reset,serial_input,serial_output);

initial
begin

reset = 0;
serial_input = 12;
#40;

reset = 1;
#40;

reset = 0;
serial_input = 13;
#40;
$finish;

end



endmodule //REG1_tb