`timescale 1ns/1ps
module or_gate (
    input A,
    input B,
    output Y
);

assign Y = A | B; // OR operation

endmodule