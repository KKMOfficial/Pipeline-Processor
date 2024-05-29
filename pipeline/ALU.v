module ALU #(parameter input_width=8, parameter select_size = 4) (
    input0, input1, select, outputf, compare, carryout
);

input wire [input_width-1 : 0] input0, input1;
output reg [input_width-1 : 0] outputf;
output reg carryout;
input wire [select_size-1 : 0] select;
output reg compare;
reg [7:0]dummy;

initial carryout = 0;

always @(select,input0,input1) begin
    carryout = 0;
    case (select)
        0:{carryout,outputf} = input0 + input1;
        1:outputf = input0 & input1;
        2:outputf = input0 - input1;
        3:outputf = input0 | input1;
        4:outputf = input0 ^ input1;
        5:outputf = input1;
        6:outputf = ~input0;
        7:outputf = input0 >>> input1;
        8:outputf = input0 >> input1;
        9:outputf = input0 <<< input1;
        10:outputf = input0 << input1;
        11:{outputf,dummy} = {input0,input0} << input1;
        12:{dummy,outputf} = {input0,input0} >> input1;
        13:outputf = input0;
        14:outputf = input0 + 1;
        15:outputf = input0 - 1;
    endcase
    compare = (input0 == input1);
end


endmodule //ALU