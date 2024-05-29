//auto generated test by : MR_X
//Dec:12:2020
`include "Adder.v"
module Adder_tb #(parameter bus_width = 16) ();
initial begin
$dumpfile("Adder.vcd");
$dumpvars(0, Adder_tb);
end

//insert inputs
reg [bus_width-1:0]input1,input2; reg cin;
//insert outputs
wire overflow; wire[bus_width-1:0]output1 ;
//make new instance of module here
Adder #(.bus_width(bus_width)) instance1(cin,input1,input2,output1,overflow);
initial
begin
input1 = 26;
input2 = 94;
cin = 0;
#40;

input1 = 120;
input2 = 33;
cin = 1;
#40;
$finish;
end
endmodule //Adder_tb