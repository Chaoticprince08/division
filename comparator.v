`timescale 1ns/1ps
module comparator (
    input [1:0] A,
    input [1:0] B,
    output reg equal
);

    always @(A or B) begin
        if (A == B) begin
            equal = 1'b1; // A is equal than B
        end 
        else begin
            equal = 1'b0; // A is not equal than B
        end
    end
    
endmodule