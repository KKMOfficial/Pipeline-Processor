module Controller (opcode, jump_type, mem_write, alu_select, mem_read, mem_to_reg, reg_write, alu_second_input_is_immidiate);

input wire [9:0]opcode;
output reg mem_write,mem_read, mem_to_reg,reg_write,alu_second_input_is_immidiate;
output reg[2:0]jump_type;
output reg[3:0]alu_select;
reg [9:0] output_bus;

//alu_second_input_is_immidiate : 0 for register , 1 for immidiate

always @(opcode) begin
    if(!opcode[9])begin
        case (opcode)
        00:output_bus = 12'b000000000000;
        01:output_bus = 12'b000000000010;
        02:output_bus = 12'b000000010010;
        03:output_bus = 12'b000000100010;
        04:output_bus = 12'b000000110010;
        05:output_bus = 12'b000001000010;
        06:output_bus = 12'b000001010010;
        // 07:
        08:output_bus = 12'b000001100010;
        09:output_bus = 12'b000001110011;
        10:output_bus = 12'b000010000011;
        11:output_bus = 12'b000010010011;
        12:output_bus = 12'b000010100011;
        13:output_bus = 12'b000010110011;
        14:output_bus = 12'b000011000011;
        15:output_bus = 12'b000011100010;
        16:output_bus = 12'b000011110010;
        // 17:
        // 18:
        // 19:
        // 20:
        endcase
    end
    else begin
        case (opcode[9:5])
        16:output_bus = 12'b001000000000;
        17:output_bus = 12'b010000000000;
        18:output_bus = 12'b011000000000;
        19:output_bus = 12'b100000000000;
        20:output_bus = 12'b101000000000;
        21:output_bus = 12'b111000000000;
        22:output_bus = 12'b000001010011;
        23:output_bus = 12'b000001011111;
        endcase 
    end

    {jump_type,mem_write,alu_select,mem_read, mem_to_reg,reg_write,alu_second_input_is_immidiate} = output_bus;

end


endmodule //Controller