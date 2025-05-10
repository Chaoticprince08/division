`timescale 1ns/1ps
module shift_register_a (
    input rst,
    input clk,
    input [16:0] A,
    input [15:0] Q,
    input shift_left_enable_a,
    output reg [16:0] shift_out
);

//reg [16:0] A;
//reg [32:0] AandQ;

always @(posedge(rst) or posedge(clk)) begin
    if(rst) begin
        shift_out <= 17'b0; // Reset the shift register to 0
    end 
    else if(shift_left_enable_a == 1'b1) begin
        shift_out <= {A[15:0], Q[15]};
    end
end
    
endmodule