`include "non_restoring_division_controlpath.v"
`include "non_restoring_division_datapath.v"
//`include "correctness.v"
`include "lcd_module.v"
`timescale 1ns / 1ps
module non_restoring_division_topmodule (
    input clk,
    input [3:0] dividend,
    input [3:0] divisor,
    input start,
    input rst,
     output [6:0] seg,
	output [3:0] digit, 
	//output [3:0] quotient,
    output [4:0] remainder,
    output done
);

wire [3:0] quotient;
wire [4:0] remainder;
wire select_A;
wire select_Q;
wire ld_A;
wire ld_Q;
wire shift_left_enable_a;
wire select_add;
wire select_mux_2;
wire [1:0] count;
wire negative_flag;
wire status;
wire shift_left_enable_q;
wire count_enable;
wire ld_rem_quotient;
//wire status_correctness_check;

// Instantiation of Datapath and Controlpath modules

non_restoring_division_datapath datapath (
    .clk(clk),
    .rst(rst),
    .dividend(dividend),
    .divisor(divisor),
    .select_A(select_A),
    .select_Q(select_Q),
    .ld_A(ld_A),
    .ld_Q(ld_Q),
    .shift_left_enable_a(shift_left_enable_a),
    .select_add(select_add),
    .select_mux_2(select_mux_2),
    .shift_left_enable_q(shift_left_enable_q),
    .count_enable(count_enable),
    .ld_rem_quotient(ld_rem_quotient),
    .negative_flag(negative_flag),
    .count(count),
    .status(status),
    //.status_correctness_check(status_correctness_check),
    .quotient(quotient),
    .remainder(remainder)
);

non_restoring_division_control_path controlpath (
    .clk(clk),
    .rst(rst),
    .start(start),
    .negative_flag(negative_flag),
    .count(count),
    .status(status),
    //.status_correctness_check(status_correctness_check),
    .done(done),
    .count_enable(count_enable),
    .select_A(select_A),
    .select_Q(select_Q),
    .ld_A(ld_A),
    .ld_Q(ld_Q),
    .shift_left_enable_a(shift_left_enable_a),
    .shift_left_enable_q(shift_left_enable_q),
    .select_add(select_add),
    .select_mux_2(select_mux_2),
    .ld_rem_quotient(ld_rem_quotient)
);


lcd_module lcd1(
	.quotient(quotient),
	.clk(clk),
	.rst(rst),
	.digit(digit),
	.seg(seg)
); 
    
endmodule