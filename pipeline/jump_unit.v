module jump_unit (jump_type, zero_flag, sign_flag, carry_flag, overflow_flag, jump);

input[2:0] jump_type;
input zero_flag,sign_flag,carry_flag,overflow_flag;
output reg jump;

always @(jump_type, zero_flag, sign_flag, carry_flag, overflow_flag) begin
    jump = 
        (jump_type == 3'b001 & zero_flag) |
        (jump_type == 3'b010 & carry_flag) |
        (jump_type == 3'b011 & !carry_flag & !zero_flag) |
        (jump_type == 3'b100 & sign_flag != overflow_flag) |
        (jump_type == 3'b101 & sign_flag == overflow_flag & !zero_flag) |
        jump_type == 3'b111;
    
end

endmodule //jump_unit