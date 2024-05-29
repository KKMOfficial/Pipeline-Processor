module Adder #(parameter bus_width=8)(
    cin,input1,input2,output1,overflow
);

input [bus_width-1:0]input1,input2;
input cin;
output [bus_width-1:0]output1;
output overflow;

assign {overflow,output1} = input1 + input2 + cin;

endmodule //Adder