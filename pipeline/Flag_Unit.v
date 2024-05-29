module Flag_Unit (alu_operation , alu_output,Rd_MUX_out,Rs_MUX_out,carryout, flag_set_output);

input [7:0] alu_output,Rd_MUX_out,Rs_MUX_out;
input carryout;
output reg [3:0] flag_set_output;
input [3:0] alu_operation;
reg zero_flag, sign_flag, carry_flag, overflow_flag;

always @(alu_operation , alu_output,Rd_MUX_out,Rs_MUX_out,carryout) begin

    zero_flag = alu_output == 0;
    sign_flag = alu_output[7];
    carry_flag = carryout;
    overflow_flag = (alu_operation == 1 | alu_operation == 2) & (Rd_MUX_out[7] == Rs_MUX_out[7]) && (Rd_MUX_out[7] != alu_output[7]);

    //order : zero, sign, carry, overflow
    case (alu_operation)
        // 00:
        01:begin carry_flag=0; overflow_flag=0; end
        // 02:
        03:begin carry_flag=0; overflow_flag=0; end
        04:begin carry_flag=0; overflow_flag=0; end
        // 05:
        // 06:
        07:begin overflow_flag=Rd_MUX_out[7]!=alu_output[7]; carry_flag=Rd_MUX_out[7-Rs_MUX_out]; end
        08:begin overflow_flag=Rd_MUX_out[7]!=alu_output[7]; carry_flag=Rd_MUX_out[7-Rs_MUX_out]; end
        09:begin overflow_flag=Rd_MUX_out[7]!=alu_output[7]; carry_flag=Rd_MUX_out[Rs_MUX_out]; end
        10:begin overflow_flag=Rd_MUX_out[7]!=alu_output[7]; carry_flag=Rd_MUX_out[Rs_MUX_out]; end
        11:begin overflow_flag=Rd_MUX_out[7]!=alu_output[7]; carry_flag=Rd_MUX_out[Rs_MUX_out]; end
        12:begin overflow_flag=Rd_MUX_out[7]!=alu_output[7]; carry_flag=Rd_MUX_out[7-Rs_MUX_out]; end
        // 13:
        // 14:
        // 15:
   endcase
   
   flag_set_output = {zero_flag,sign_flag,carry_flag,overflow_flag};
end



endmodule //Flag_Unit