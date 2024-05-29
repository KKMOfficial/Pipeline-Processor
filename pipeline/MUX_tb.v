//auto generated test by : MR_X
//Dec:14:2020
`include "MUX.v"
module MUX_tb #(parameter in_width = 8) ();
initial begin
$dumpfile("MUX.vcd");
$dumpvars(0, MUX_tb);
end
reg [in_width-1 : 0] input0, input1;
reg select;
wire [in_width-1 : 0] output_bus;
//make new instance of module here
MUX #(.in_width(in_width)) instance1( input0, input1 , select , output_bus);
initial
begin

input0 = 15;
input1 = 45;
select = 0;
#40;
select = 1;
#40;


$finish;
end
endmodule //MUX_tb