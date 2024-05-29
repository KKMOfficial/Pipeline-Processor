module instructionDecoder (reg1,reg2,immidiate,instruction);

output reg[2:0] reg1,reg2;
output reg[7:0]immidiate;
input [15:0]instruction;


always @(instruction)
begin

if(instruction[15] == 0)
begin
reg1 = instruction[5:3];
reg2 = instruction[2:0];
immidiate = {5'd0,reg2};
end
else if(instruction[15] == 1)
begin
reg1 = instruction[10:8];
reg2 = 3'b0;
immidiate = instruction[7:0];
end

end

endmodule //instructionDecoder