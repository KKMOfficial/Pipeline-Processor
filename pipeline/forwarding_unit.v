module forwarding_unit (Rd_mem, Rd_wb, reg_write_mem, reg_write_wb, Rs_exe, Rd_exe, do_forward_Rs, do_forward_Rd);

input wire [2:0] Rd_mem, Rd_wb, Rs_exe, Rd_exe;
input wire reg_write_mem, reg_write_wb;
output reg [1:0] do_forward_Rs,do_forward_Rd;

always @(Rd_mem, Rd_wb, reg_write_mem, reg_write_wb, Rs_exe, Rd_exe) begin
    //00: not forward, 01: type 1, 10: type 2
    //type 1 : 
    if((reg_write_mem)&(Rd_mem == Rs_exe))
        do_forward_Rs = 2'b01;
    else
        do_forward_Rs = 2'b00;

    if((reg_write_mem)&(Rd_mem == Rd_exe))
        do_forward_Rd = 2'b01;
    else
        do_forward_Rd = 2'b00;

    //type 2    
    if((reg_write_wb)&(Rd_wb == Rs_exe)&(Rd_mem != Rs_exe))
        do_forward_Rs = 2'b10;
    if((reg_write_wb)&(Rd_wb == Rd_exe)&(Rd_mem != Rd_exe))
        do_forward_Rd = 2'b10;
end

endmodule //forwarding_unit support both type 1 and type 2 forwarding and load stall