`include "REG1.v"
`include "Adder.v"
`include "MUX.v"
`include "InstructionMemory.v"
`include "instructionDecoder.v"
`include "Flag_Unit.v"
`include "Controller.v"
`include "jump_unit.v"
`include "RegisterFile.v"
`include "ALU.v"
`include "DataMemory.v"
`include "MUX4x1.v"
`include "forwarding_unit.v"
`include "load_stall.v"

module PipelineProcessor #(parameter address_size=8, parameter instruction_size=16) (clk);

input wire clk;
wire pc_reset,if_id_reset;
wire [address_size-1:0] pc_input_if;

// output wire [7:0] seven_segment;
wire [address_size-1:0] pc_output_if,pc_adder_output_if,rd_data_id,rs_data_id,Rd_MUX_out_exe,Rs_MUX_out_exe;
wire [instruction_size-1:0]instruction_output_if,instruction_output_id;
wire [9:0] op_code;
wire [7:0] immidiate_id,immidiate_exe;
wire [2:0] Rs_id,Rd_id,Rd_exe,Rs_exe;
wire zero_flag_exe, sign_flag_exe, carry_flag_exe, overflow_flag_exe;
wire zero_flag_out_exe,sign_flag_out_exe,carry_flag_out_exe,overflow_flag_out_exe;
wire jump_sig_mem, mem_write, mem_read, reg_write, mem_to_reg,carry_out_exe;
wire [3:0] alu_operation_id;
wire [7:0] alu_output_exe,final_second_operand_exe,rs_data_exe,rd_data_exe;
wire mem_write_id,mem_read_id,mem_to_reg_id,reg_write_id,alu_second_input_is_immidiate_id;
wire mem_write_exe,mem_read_exe,mem_to_reg_exe,reg_write_exe,alu_second_input_is_immidiate_exe;
wire [3:0] alu_select_id;
wire [3:0] alu_select_exe;
wire mem_write_mem,mem_read_mem,mem_to_reg_mem,reg_write_mem,zero_flag_mem,sign_flag_mem,carry_flag_mem,overflow_flag_mem,compare_mem;
wire [2:0]Rd_mem;
wire [7:0] immidiate_mem,alu_output_mem,data_mem_output_mem;
wire [2:0] jump_id,jump_exe,jump_mem;
wire mem_to_reg_wb,reg_write_wb;
wire [7:0] data_mem_output_wb,alu_output_wb;
wire [2:0] Rd_wb;
wire [7:0] WriteData_wb;
wire [1:0] do_forward_Rd,do_forward_Rs;
wire do_stall,nen_write,final_reset_sig_id_exe;
wire [7:0] data_lookup0,data_lookup1,data_lookup2,data_lookup3,data_lookup4,data_lookup5,data_lookup6,data_lookup7;

REG1 #(.reg_size(address_size)) pc (.clk(clk),.nen_write(do_stall),.reset(1'b0),.serial_input(pc_input_if),.serial_output(pc_output_if));

//IF section : begin
Adder #(.bus_width(address_size)) pc_adder(.cin(1'b0),.input1(8'b00000001),.input2(pc_output_if),.output1(pc_adder_output_if),.overflow(overflow));
MUX #(.in_width(address_size)) pc_mux (.input0(pc_adder_output_if),.input1(immidiate_mem) ,.select(jump_sig_mem) ,.output_bus(pc_input_if));
InstructionMemory IM (.clk(clk),.address(pc_output_if),.instruction_output(instruction_output_if));
//IF section : end 

REG1 #(.reg_size(16)) if_id (.clk(clk),.reset(jump_sig_mem),.nen_write(do_stall),.serial_input(instruction_output_if),.serial_output(instruction_output_id));

//ID section : begin
instructionDecoder Ins_Decode(.reg1(Rd_id),.reg2(Rs_id),.immidiate(immidiate_id),.instruction(instruction_output_id));
RegisterFile Reg_File(.clk(clk),.ReadRegister1(Rd_id),.ReadRegister2(Rs_id),.WriteRegister(Rd_wb),.WriteData(WriteData_wb),.RegWrite(reg_write_wb),.ReadData1(rd_data_id),.ReadData2(rs_data_id),.data_lookup0(data_lookup0),.data_lookup1(data_lookup1),.data_lookup2(data_lookup2),.data_lookup3(data_lookup3),.data_lookup4(data_lookup4),.data_lookup5(data_lookup5),.data_lookup6(data_lookup6),.data_lookup7(data_lookup7));
Controller controller(.opcode(instruction_output_id[15:6]),.jump_type(jump_id),.mem_write(mem_write_id),.alu_select(alu_select_id),.mem_read(mem_read_id),.mem_to_reg(mem_to_reg_id),.reg_write(reg_write_id),.alu_second_input_is_immidiate(alu_second_input_is_immidiate_id));
//ID section : end 

or (final_reset_sig_id_exe, do_stall, jump_sig_mem);
REG1 #(.reg_size(42)) id_exe (.clk(clk),.reset(final_reset_sig_id_exe),.nen_write(1'b0),.serial_input({jump_id,mem_write_id,alu_select_id,mem_read_id,mem_to_reg_id,reg_write_id,alu_second_input_is_immidiate_id,rs_data_id,rd_data_id,Rs_id,Rd_id,immidiate_id}),.serial_output({jump_exe,mem_write_exe,alu_select_exe,mem_read_exe,mem_to_reg_exe,reg_write_exe,alu_second_input_is_immidiate_exe,rs_data_exe,rd_data_exe,Rs_exe,Rd_exe,immidiate_exe}));

//EX section : begin
MUX4x1 #(.in_width(address_size)) Rd_MUX (.input0(rd_data_exe),.input1(alu_output_mem),.input2(WriteData_wb),.input3(8'd0),.select(do_forward_Rd),.output0(Rd_MUX_out_exe)); 
MUX4x1 #(.in_width(address_size)) Rs_MUX (.input0(rs_data_exe),.input1(alu_output_mem),.input2(WriteData_wb),.input3(8'd0),.select(do_forward_Rs),.output0(Rs_MUX_out_exe)); 
MUX #(.in_width(address_size)) second_reg_input (.input0(Rs_MUX_out_exe),.input1(immidiate_exe) ,.select(alu_second_input_is_immidiate_exe) ,.output_bus(final_second_operand_exe)); 
ALU #(.input_width(8),.select_size(4)) alu_unit(.input0(Rd_MUX_out_exe),.input1(final_second_operand_exe),.select(alu_select_exe),.outputf(alu_output_exe),.compare(compare_exe),.carryout(carry_out_exe));
Flag_Unit flag_unit(.alu_operation(alu_select_exe),.alu_output(alu_output_exe),.Rd_MUX_out(Rd_MUX_out_exe),.Rs_MUX_out(Rs_MUX_out_exe),.carryout(carry_out_exe),.flag_set_output({zero_flag_exe, sign_flag_exe, carry_flag_exe, overflow_flag_exe}));
//Ex section : end

REG1 #(.reg_size(31)) exe_mem (.clk(clk),.reset(1'b0),.nen_write(1'b0),.serial_input({jump_exe,zero_flag_exe, sign_flag_exe, carry_flag_exe, overflow_flag_exe,mem_write_exe,mem_read_exe,mem_to_reg_exe,reg_write_exe,Rd_exe,immidiate_exe,alu_output_exe,compare_exe}),.serial_output({jump_mem,zero_flag_mem, sign_flag_mem, carry_flag_mem, overflow_flag_mem,mem_write_mem,mem_read_mem,mem_to_reg_mem,reg_write_mem,Rd_mem,immidiate_mem,alu_output_mem,compare_mem}));

//MEM section : begin
DataMemory data_mem(.clk(clk),.address(immidiate_mem),.outputf(data_mem_output_mem));
jump_unit j_unit(.jump_type(jump_mem),.zero_flag(zero_flag_mem),.sign_flag(sign_flag_mem),.carry_flag(carry_flag_mem),.overflow_flag(overflow_flag_mem),.jump(jump_sig_mem));
//MEM section : end

REG1 #(.reg_size(21)) mem_wb (.clk(clk),.reset(1'b0),.nen_write(1'b0),.serial_input({mem_to_reg_mem,reg_write_mem,data_mem_output_mem,alu_output_mem,Rd_mem}),.serial_output({mem_to_reg_wb,reg_write_wb,data_mem_output_wb,alu_output_wb,Rd_wb}));

//Write back section : begin
MUX #(.in_width(address_size)) wb_MUX (.input0(alu_output_wb),.input1(data_mem_output_wb) ,.select(mem_to_reg_wb) ,.output_bus(WriteData_wb)); 
//Write back section : end

//forwarding unit---------------------------------------------------------------------------------------------------------------------------------------
forwarding_unit fw_u(.Rd_mem(Rd_mem),.Rd_wb(Rd_wb),.reg_write_mem(reg_write_mem),.reg_write_wb(reg_write_wb),.Rs_exe(Rs_exe),.Rd_exe(Rd_exe),.do_forward_Rs(do_forward_Rs),.do_forward_Rd(do_forward_Rd));
//load stall unit---------------------------------------------------------------------------------------------------------------------------------------
load_stall ls_u(.mem_read_exe(mem_read_exe),.Rs_id(Rs_id),.Rd_id(Rd_id),.Rd_ex(Rd_exe),.do_stall(do_stall));


endmodule 