`timescale 1ns/1ps
module correctness(
	input [3:0] divisor,
	input [4:0] remainder_partial,
	output reg [4:0] remainder
	
);

always @(remainder_partial) begin
	if(remainder_partial[4] == 1'b1) begin
		remainder = divisor + {1'b0,remainder_partial};
	end
	else begin
		remainder = remainder_partial;
	end
end
endmodule