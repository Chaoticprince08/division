`timescale 1ns/1ps
module comparator_1bit (
    input A,
    input B,
    output reg equal
);

    always @(A or B) begin
        if(A==B) begin
            equal = 1'b1; // Set equal to 1 if A and B are equal
        end 
        else begin
            equal = 1'b0; // Set equal to 0 if A and B are not equal
        end        
    end
    
endmodule