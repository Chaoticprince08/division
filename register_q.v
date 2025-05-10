`timescale 1ns/1ps
module register_q (
    input rst,
    input clk,
    input ld_register,
    input [15:0] input_data,
    output reg [15:0] output_data
);

always @(posedge(clk) or posedge(rst)) begin
    if(rst) begin
        output_data <= 16'b0; // Reset the register to 0
    end 
    else if(ld_register) begin
        output_data <= input_data; // Store the input data in the register
    end
end
    
endmodule