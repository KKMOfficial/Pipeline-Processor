module SignExtend #(parameter input_size=3, parameter output_size=8) (
    inputData, outputData);

input signed [input_size - 1:0] inputData;
output reg signed[output_size - 1:0] outputData;

always @(inputData) begin
    outputData = {inputData,{(output_size - input_size){1'b0}}};
    outputData = outputData >>> (output_size - input_size);
end

endmodule //SignExtend