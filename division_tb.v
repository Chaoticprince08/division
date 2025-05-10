`timescale 1ns / 1ps
`include "non_restoring_division_topmodule.v"

module division_4bit_tb;

    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg [15:0] dividend;
    reg [15:0] divisor;

    // Outputs
    //wire [6:0] seg;
	//wire [3:0] digit;
	wire [15:0] quotient;
    wire [16:0] remainder;
    wire done;
    // Instantiate the Unit Under Test (UUT)
    non_restoring_division_topmodule uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient), 
		//.seg(seg),
		//.digit(digit),
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
        dividend = 16'd15;
        divisor  = 16'd15;
        start = 1;
        #20 start = 0;
        #5000;
         
		#10 rst = 1; 
		#10 rst = 0;
        // Test Case 2: 7 / 2
        dividend = 16'd7;
        divisor  = 16'd2;
        start = 1;
        #20 start = 0;
        #5000;
	#10 rst = 1; 
		#10 rst = 0;
        // Test Case 3: 15 / 4
        dividend = 16'd15;
        divisor  = 16'd4;
        start = 1;
        #20 start = 0;
        #5000;
	#10 rst = 1; 
		#10 rst = 0;
        // Test Case 4: 9 / 1
        dividend = 16'd9;
        divisor  = 16'd2;
        start = 1;
        #20 start = 0;
        #5000;
			#10 rst = 1; 
		#10 rst = 0;
		dividend = 16'd8;
		divisor = 16'd3;
		start=1;
		#20 start = 0;
		#5000;
	
	#10 rst = 1; 
		#10 rst = 0;
        // Test Case 5: 6 / 0 (Divide by zero - optional handling)
        dividend = 16'd15;
        divisor  = 16'd15;
        start = 1;
        #20 start = 0;
        #5000;
    #10 rst = 1; 
		#10 rst = 0;
        // Test Case 5: 6 / 0 (Divide by zero - optional handling)
        dividend = 16'd6;
        divisor  = 16'd15;
        start = 1;
        #20 start = 0;
        #5000;
    #10 rst = 1; 
		#10 rst = 0;
        // Test Case 5: 6 / 0 (Divide by zero - optional handling)
        dividend = 16'd12;
        divisor  = 16'd15;
        start = 1;
        #20 start = 0;
        #5000;
    #10 rst = 1; 
		#10 rst = 0;
        // Test Case 5: 6 / 0 (Divide by zero - optional handling)
        dividend = 16'd3219;
        divisor  = 16'd2017;
        start = 1;
        #20 start = 0;
        #5000;
    #10 rst = 1; 
		#10 rst = 0;
        // Test Case 5: 6 / 0 (Divide by zero - optional handling)
        dividend = 16'd3219;
        divisor  = 16'd7;
        start = 1;
        #20 start = 0;
        #5000;

       $finish;
    end

endmodule
