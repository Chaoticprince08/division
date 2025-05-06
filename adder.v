`timescale 1ns/1ps
module adder (
    input [4:0] A,
    input [4:0] B,
    output reg [4:0] sum
);
    
        always @(A or B) begin
            sum = A + B; // Perform addition
        end
    
endmodule