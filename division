`timescale 1ns/1ps
module adder_subtractor (
    input [16:0] A,
    input [15:0] divisor,
    input add,
    output reg [16:0] sum
);

always @(A or divisor or add) begin
    if(add) begin
        sum = A + divisor; // Perform addition
    end else begin
        sum = A - divisor; // Perform subtraction
    end
end
    
endmodule