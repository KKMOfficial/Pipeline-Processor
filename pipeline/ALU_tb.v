//auto generated test by : MR_X
//Dec:14:2020
`include "ALU.v"
module ALU_tb #(parameter input_width=8, parameter select_size = 4) ();
initial begin
$dumpfile("ALU.vcd");
$dumpvars(0, ALU_tb);
end

reg [input_width-1 : 0] input0, input1;
wire [input_width-1 : 0] outputf;
reg [select_size-1 : 0] select;
wire compare;

//make new instance of module here
ALU #(.input_width(input_width), .select_size(select_size))  instance1(input0, input1, select, outputf,compare);
initial
begin

input0 = 63;
input1 = 1;

select = 0;
#40;
select = 1;
#40;
select = 2;
#40;
select = 3;
#40;
select = 4;
#40;
select = 5;
#40;
select = 6;
#40;
select = 7;
#40;
select = 8;
#40;
select = 9;
#40;
select = 10;
#40;
select = 11;
#40;
select = 12;
#40;
select = 13;
#40;
select = 14;
#40;
select = 15;
#40;


$finish;
end
endmodule //ALU_tb