//auto generated test by : MR_X
//Dec:14:2020
`include "DataMemory.v"
module DataMemory_tb #(parameter mem_size=256, parameter log_mem_size=8) ();
initial begin
$dumpfile("DataMemory.vcd");
$dumpvars(0, DataMemory_tb);
end

wire [log_mem_size-1 : 0] outputf;
reg [log_mem_size-1 : 0] address;
reg clk;

initial clk = 0;
always #20 clk = ~clk;
//make new instance of module here
DataMemory #(.mem_size(mem_size) , .log_mem_size(log_mem_size)) instance1(clk, address, outputf);
initial
begin

address = 5;
#40;

address = 6;
#40;

address = 1;
#40;

address = 8;
#40;

$finish;
end
endmodule //DataMemory_tb