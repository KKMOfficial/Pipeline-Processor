module MUX4x1 #(parameter in_width = 8) (input0, input1, input2, input3, select, output0);

input [in_width-1 : 0] input0;
input [in_width-1 : 0] input1;
input [in_width-1 : 0] input2;
input [in_width-1 : 0] input3;
input [1:0]select;
output [in_width-1 : 0] output0;

assign output0 = ({in_width{select==2'b00}}&input0) | ({in_width{select==2'b01}}&input1) | ({in_width{select==2'b10}}&input2) | ({in_width{select==2'b11}}&input3);

endmodule //MUX4x1