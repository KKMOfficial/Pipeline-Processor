module DataMemory #(parameter mem_size=256, parameter log_mem_size=8) (clk, address, outputf);

output [log_mem_size-1 : 0] outputf;
reg [log_mem_size-1 : 0] data [0 : mem_size-1];
input wire [log_mem_size-1 : 0] address;
input clk;

integer i;
initial begin
    for (i=0; i<mem_size; i = i +1) begin
        data[i] = 0;
    end
    data[1] = 2;
    data[6] = 66;
    data[8] = 1;
end

assign outputf = data[address];


endmodule //DataMemory