module RegisterFile (clk,ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, ReadData1, ReadData2,data_lookup0,data_lookup1,data_lookup2,data_lookup3,data_lookup4,data_lookup5,data_lookup6,data_lookup7);

reg [7:0] data [0:7];

input[2:0]ReadRegister1, ReadRegister2, WriteRegister;
input[7:0]WriteData;
input RegWrite,clk;
output [7:0]ReadData1, ReadData2;
output reg [7:0] data_lookup0,data_lookup1,data_lookup2,data_lookup3,data_lookup4,data_lookup5,data_lookup6,data_lookup7;


integer i;
initial begin
    for (i=0; i<8; i = i + 1)begin data[i] = 0; end
    data[4] = 45;        
end

assign ReadData1 = data[ReadRegister1];
assign ReadData2 = data[ReadRegister2];


always @(negedge clk) begin
    data[WriteRegister] = RegWrite? WriteData :  data[WriteRegister];
    data_lookup0 = data[0];
    data_lookup1 = data[1];
    data_lookup2 = data[2];
    data_lookup3 = data[3];
    data_lookup4 = data[4];
    data_lookup5 = data[5];
    data_lookup6 = data[6];
    data_lookup7 = data[7];
end



endmodule //RegisterFile