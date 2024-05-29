//auto generated test by : MR_X
//Dec:14:2020
`include "Shift.v"
module Shift_tb #(parameter shift_amount=2, parameter input_size=8, parameter shift_left=0)();
initial begin
$dumpfile("Shift.vcd");
$dumpvars(0, Shift_tb);
end

reg [input_size-1 : 0] input0;
wire [input_size-1 : 0] output0;

//make new instance of module here
Shift #(.shift_amount(shift_amount),.input_size(input_size),.shift_left(shift_left)) instance1(input0, output0);
initial begin

input0 = 12;
#40;

input0 = 23;
#40;


$finish;
end
endmodule //Shift_tb