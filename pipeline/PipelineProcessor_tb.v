//auto generated test by : MR_X
//Dec:16:2020
`include "PipelineProcessor.v"
module PipelineProcessor_tb ();
initial begin
$dumpfile("PipelineProcessor.vcd");
$dumpvars(0, PipelineProcessor_tb);
end

reg clk;

initial clk = 0;
always #25 clk = ~clk;
//make new instance of module here
PipelineProcessor instance1(clk);
initial
begin
#1800;
$finish;
end
endmodule //PipelineProcessor_tb