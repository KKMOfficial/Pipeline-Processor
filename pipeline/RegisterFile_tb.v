//auto generated test by : MR_X
//Dec:12:2020
`include "RegisterFile.v"
module RegisterFile_tb ();
initial begin
$dumpfile("RegisterFile.vcd");
$dumpvars(0, RegisterFile_tb);
end
initial clk = 0;
always #20 clk = ~clk;
//make new instance of module here
RegisterFile instance1(clk,ReadRegister1, ReadRegister2, WriteRegister, ExchangeRegister, WriteData, ExchangeData, RegExchange, RegWrite, ReadData1, ReadData2);

reg[2:0]ReadRegister1, ReadRegister2, WriteRegister, ExchangeRegister, ExchangeData;
reg[7:0]WriteData;
reg RegWrite,RegExchange,clk;
wire [7:0]ReadData1, ReadData2;
initial
begin
ExchangeData = 4;
ExchangeRegister = 7;
RegExchange= 0;

ReadRegister1 = 6;
ReadRegister2 = 4;
WriteRegister = 4;
WriteData = 122;
RegWrite = 0;
#40;

ExchangeData = 4;
ExchangeRegister = 7;
RegExchange= 1;

ReadRegister1 = 6;
ReadRegister2 = 4;
WriteRegister = 4;
WriteData = 122;
RegWrite = 1;
#40;

ExchangeData = 4;
ExchangeRegister = 7;
RegExchange= 0;

ReadRegister1 = 7;
ReadRegister2 = 4;
WriteRegister = 4;
WriteData = -66;
RegWrite = 1;
#40;
$finish;
end
endmodule //RegisterFile_tb













