`include "mux_2x1.v"
`include "mux_2x1_16bit.v"
`include "register_a.v"
`include "register_q.v"
`include "shift_register_a.v"
`include "shift_register_q.v"
`include "adder.v"
`include "subtractor.v"
`include "counter.v"
`include "comparator.v"
`include "comparator_1bit.v"
//`include "or_gate.v"
`timescale 1ns/1ps


module non_restoring_division_datapath (
    input clk,
    input rst,
    input [3:0] dividend,
    input [3:0] divisor,
    input select_A,
    input select_Q,
    input ld_A,
    input ld_Q,
    input shift_left_enable_a,
    input select_add,
    input select_mux_2,
    input shift_left_enable_q,
    input count_enable,
    input ld_rem_quotient,
    output negative_flag,
    output [3:0] quotient,
    output [4:0] remainder,
    output [1:0] count,
    output status
);

// Internal signals
wire [4:0] A; // 17 bits to accommodate the sign bit
wire [3:0] Q;
//reg [3:0] M;
//wire negative_flag;
wire [4:0] mux_out_1;
wire [4:0] shift_register_out_a;
wire [3:0] shift_register_out_q;
wire [4:0] adder_out;
wire [4:0] subtractor_out;
wire [4:0] mux_out_2;
wire [3:0] mux_out_3;
wire [4:0] mux_out_4;
wire [1:0] count;
wire complete;
wire rst_out;


//Select the A register or the output of the second mux for the first stage
//.B(2nd mux_output)
mux_2x1 mux1(
    .select(select_A),
    .A(5'b0),
    .B(mux_out_2),
    .out(mux_out_1)
);

//load the A register
register_a A_reg(
    .rst(rst),
    .clk(clk),
    .input_data(mux_out_1),
    .ld_register(ld_A),
    .output_data(A)
);

//load the Q register
register_q Q_reg(
    .rst(rst),
    .clk(clk),
    .input_data(mux_out_3),
    .ld_register(ld_Q),
    .output_data(Q)
);

//shift register for A
shift_register_a shift_A_left(
    .rst(rst),
    .clk(clk),
    .A(A),
    .Q(Q),
    .shift_left_enable_a(shift_left_enable_a),
    .shift_out(shift_register_out_a)
);

comparator_1bit cmp1(
    .A(A[4]),
    .B(1'b1),
    .equal(negative_flag)
);

mux_2x1 mux4(
    .select(select_add), //Give the proper Value here
    .A(A),
    .B(shift_register_out_a),
    .out(mux_out_4)
);


//Addition
adder adder1(
    .A(mux_out_4),
    .B({1'b0,divisor}),
    .sum(adder_out)
);

//Subtraction
subtractor subtractor1(
    .A(shift_register_out_a),
    .B({1'b0,divisor}),
    .difference(subtractor_out)
);

//Multiplexer for the second stage
mux_2x1 mux2(
    .select(select_mux_2), //Modify here to select between adder and subtractor
    .A(adder_out),
    .B(subtractor_out),
    .out(mux_out_2)
);

//shift register for Q
shift_register_q shift_Q_left(
    .rst(rst),
    .clk(clk),
    .shift_left_enable_q(shift_left_enable_q),
    .Q(Q),
    .A(mux_out_2[4]), //Use the sign bit of the output of the second stage
    .shift_out(shift_register_out_q)
);

//Multiplexer for the third stage
mux_2x1_16bit mux3(
    .select(select_Q),
    .A(dividend),
    .B(shift_register_out_q),
    .out(mux_out_3)
);



//Counter for the number of iterations
counter incrementer(
    .clk(clk),
    .rst(rst),
    .count_enable(count_enable),
    .count(count)
);

//Comparator to check whether counter has reached 16 iterations
comparator cmp(
    .A(count),
    .B(2'b11),
    .equal(status)
);

//Output register for remainder and quotient
register_a remainder_reg(
    .rst(rst),
    .clk(clk),
    .input_data(mux_out_2),
    .ld_register(ld_rem_quotient),
    .output_data(remainder)
);

//Output register for quotient
register_q quotient_reg(
    .rst(rst),
    .clk(clk),
    .input_data(shift_register_out_q),
    .ld_register(ld_rem_quotient),
    .output_data(quotient)
);

    
endmodule