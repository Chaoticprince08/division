`timescale 1ns/1ps
module mux_2x1_16bit (
    input select,
    input [15:0] A,
    input [15:0] B,
    output reg [15:0] out
);

    always @(select or A or B) begin
        if (select) begin
            out = A; // Select input A
        end else begin
            out = B; // Select input B
        end
    end
    
endmodule