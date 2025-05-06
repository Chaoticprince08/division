`timescale 1ns/1ps
module subtractor (
    input [4:0] A,
    input [4:0] B,
    output reg [4:0] difference
);
    
        always @(A or B) begin
            difference = A - B; // Perform Subtraction
        end
    
endmodule