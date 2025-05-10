`timescale 1ns/1ps
module shift_register_q (
    input rst,
    input clk,
    input shift_left_enable_q,
    input [15:0] Q,
    input A,
    output reg [15:0] shift_out
);

always @(posedge(clk) or posedge(rst)) begin
    if(rst) begin
        shift_out <= 16'b0; // Reset the shift register to 0
    end 
    else if(shift_left_enable_q == 1'b1) begin
        shift_out <= {Q[14:0], ~A}; // Shift left and insert the inverted A value
    end
end
    
endmodule