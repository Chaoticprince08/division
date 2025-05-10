`timescale 1ns/1ps
module subtractor (
    input [16:0] A,
    input [16:0] B,
    output reg [16:0] difference
);
    
        always @(A or B) begin
            difference = A - B; // Perform Subtraction
        end
    
endmodule