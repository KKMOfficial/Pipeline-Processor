module MUX #(parameter in_width=4) (
    input0, input1 , select , output_bus);

input wire [in_width-1 : 0] input0,input1;
output [in_width-1 : 0] output_bus;
input wire select;

assign output_bus = (input0 & {in_width{~select}}) | (input1 & {in_width{select}});

endmodule //MUX