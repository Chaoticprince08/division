`timescale 1ns/1ps
module shift_register_q (
    input rst,
    input clk,
    input shift_left_enable_q,
    input [3:0] Q,
    input A,
    output reg [3:0] shift_out
);

always @(posedge(clk) or posedge(rst)) begin
    if(rst) begin
        shift_out <= 4'b0; // Reset the shift register to 0
    end 
    else if(shift_left_enable_q == 1'b1) begin
        shift_out <= {Q[2:0], ~A}; // Shift left and insert the inverted A value
    end
end
    
endmodule