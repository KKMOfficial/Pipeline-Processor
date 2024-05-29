module FUnit (
    reg_d_mem, reg_d_mem_is_load, reg_d_wb, reg_d_wb_is_load,rt,rs,mux_1, mux2
);

always @(Reg_d_Mem, Reg_d_WB,Rt,Rs) begin
    if(
        reg_d_mem_is_load &
        Reg_d_Mem != 0 &
        
    )
end

endmodule //FUnit