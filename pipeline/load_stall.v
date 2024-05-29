module load_stall (mem_read_exe, Rs_id, Rd_id, Rd_ex, do_stall);

input [2:0] Rs_id, Rd_id, Rd_ex;
input mem_read_exe;
output do_stall;

assign do_stall = ((mem_read_exe)&((Rs_id==Rd_ex)|(Rd_id==Rd_ex)));


endmodule //load_stall