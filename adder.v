`timescale 1ns/1ps
module adder (
    input [16:0] A,
    input [16:0] B,
    output reg [16:0] sum
);
    
        always @(A or B) begin
            sum = A + B; // Perform addition
        end
    
endmodule