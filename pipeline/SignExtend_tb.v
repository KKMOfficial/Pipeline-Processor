//auto generated test by : MR_X
//Dec:14:2020
`include "SignExtend.v"
module SignExtend_tb #(parameter input_size = 8, parameter output_size = 16) ();
initial begin
$dumpfile("SignExtend.vcd");
$dumpvars(0, SignExtend_tb);
end

reg signed[input_size-1 : 0] input_bus;
wire signed[output_size-1 : 0] output_bus;

//make new instance of module here
SignExtend #(.input_size(input_size), .output_size(output_size)) instance1(input_bus, output_bus);
initial
begin

input_bus = 4;
#20;

input_bus = -32;
#20;

input_bus = 2;
#20;


$finish;
end
endmodule //SignExtend_tb