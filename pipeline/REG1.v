module REG1 #(parameter reg_size=8) (clk,nen_write,reset,serial_input,serial_output);

input clk,reset,nen_write;
input [reg_size-1:0]serial_input;
output reg[reg_size-1:0]serial_output;

initial serial_output = 0;

always @(posedge clk, reset) begin
    if(reset)
        serial_output <= 0;
    else if(~reset&~nen_write)
        serial_output <= serial_input;
    else if(~reset&nen_write)
        serial_output <= serial_output;
end

endmodule //REG1