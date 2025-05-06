`timescale 1ns / 1ps
module register_a (
    input rst,
    input clk,
    input ld_register,
    input [4:0] input_data,
    output reg [4:0] output_data
);

always @(posedge(clk) or posedge(rst)) begin
    if(rst) begin
        output_data <= 4'b0; // Reset the register to 0
    end 
    else if(ld_register) begin
        output_data <= input_data; // Store the input data in the register
    end
end
    
endmodule