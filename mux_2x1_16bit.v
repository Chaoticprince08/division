`timescale 1ns/1ps
module mux_2x1_16bit (
    input select,
    input [3:0] A,
    input [3:0] B,
    output reg [3:0] out
);

    always @(select or A or B) begin
        if (select) begin
            out = A; // Select input A
        end else begin
            out = B; // Select input B
        end
    end
    
endmodule