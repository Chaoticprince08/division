`timescale 1ns / 1ps
module counter (
    input clk,
    input rst,
    input count_enable,
    output reg [1:0] count
);

always @(posedge(clk)) begin
    if(rst) begin
        count <= 4'b0; // Reset the counter to 0
    end 
    else if(count_enable == 1'b1) begin
        count <= count + 1; // Increment the counter
    end
end
    
endmodule