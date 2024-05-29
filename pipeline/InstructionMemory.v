module InstructionMemory (clk, address, instruction_output);
input clk;
input[7:0]address;
output [15:0]instruction_output;
reg [15:0] data [0:255];


integer i;
initial begin
    
   for (i = 0; i<256; i=i+1) begin
        data[i] = 0;
    end
    //initialize data here : 
    data[00] = 16'b0000001110_001_010;// rotate $1, 2 units right :: forwarding type 1 :: $1 <= 192(00000011 -> 11000000)
    data[01] = 16'b10110_010_00000101;// $2 <= 5
    data[02] = 16'b0000000001_111_001;// $7 <= $7 + $1 :: $7 <= 192
    data[03] = 16'b0000000001_111_010;// $7 <= $7 + $2 :: $7 <= 197 :: forwarding type 2
    data[04] = 16'b10101_000_00001010;// jump to line 11
    data[05] = 16'b10110_101_00010101;// this instruction will be flushed out! if not it will cause $5 <= 21
    data[06] = 16'b10110_110_00011011;// this instruction will be flushed out! if not it will cause $6 <= 27
    data[07] = 16'b10101_000_00000001;// this instruction is unreachable ! if not it will jump to line 1 (loop)
    data[08] = 16'b10101_000_00000001;// this instruction is unreachable ! if not it will jump to line 1 (loop)
    data[09] = 16'b10110_111_00000111;// $7 <= 7
    
end

assign instruction_output = data[address];


endmodule //InstructionMemory