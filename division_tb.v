`timescale 1ns / 1ps
`include "non_restoring_division_topmodule.v"

module division_4bit_tb;

    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg [3:0] dividend;
    reg [3:0] divisor;

    // Outputs
     wire [6:0] seg;
	wire [3:0] digit;
	//wire [3:0] quotient;
    wire [4:0] remainder;
    wire done;
    // Instantiate the Unit Under Test (UUT)
    non_restoring_division_topmodule uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .dividend(dividend),
        .divisor(divisor),
        //.quotient(quotient), 
		.seg(seg),
		.digit(digit),
		.done(done),
        .remainder(remainder)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        $dumpfile("division_4bit_tb.vcd");
        $dumpvars;
        // Initialize Inputs
        clk = 0;
        rst = 1;
        start = 0;
        dividend = 0;
        divisor = 0;

        // Apply reset
        #10 rst = 0;
        #10 rst = 1;

        // Test Case 1: 13 / 3
        #10;
		rst =0;
        dividend = 4'd15;
        divisor  = 4'd15;
        start = 1;
        #20 start = 0;
        #300;
         
		#10 rst = 1; 
		#10 rst = 0;
        // Test Case 2: 7 / 2
        dividend = 4'd7;
        divisor  = 4'd2;
        start = 1;
        #20 start = 0;
        #300;
	#10 rst = 1; 
		#10 rst = 0;
        // Test Case 3: 15 / 4
        dividend = 4'd15;
        divisor  = 4'd4;
        start = 1;
        #20 start = 0;
        #300;
	#10 rst = 1; 
		#10 rst = 0;
        // Test Case 4: 9 / 1
        dividend = 4'd9;
        divisor  = 4'd2;
        start = 1;
        #20 start = 0;
        #300;
			#10 rst = 1; 
		#10 rst = 0;
		dividend = 4'd8;
		divisor = 4'd3;
		start=1;
		#20 start = 0;
		#300;
	
	#10 rst = 1; 
		#10 rst = 0;
        // Test Case 5: 6 / 0 (Divide by zero - optional handling)
        dividend = 4'd15;
        divisor  = 4'd15;
        start = 1;
        #20 start = 0;
        #300;
    #10 rst = 1; 
		#10 rst = 0;
        // Test Case 5: 6 / 0 (Divide by zero - optional handling)
        dividend = 4'd15;
        divisor  = 4'd15;
        start = 1;
        #20 start = 0;
        #300;
       $finish;
    end

endmodule
