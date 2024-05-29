module Shift  #(parameter shift_amount=2, parameter input_size=8, parameter shift_left=0)(
    input0, output0);

input wire[input_size-1 : 0] input0;
output reg[input_size-1 : 0] output0;

always @(input0)
    output0 = shift_amount ? (input0 << shift_amount) : (input0 >> shift_amount);
endmodule //Shift