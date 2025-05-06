`timescale 1ns/1ps
module non_restoring_division_control_path (
    input clk,
    input rst,
    input start,
    input negative_flag,
    input [1:0] count,
    //input status_correctness_check,
    input status,
    output reg select_A,
    output reg select_Q,
    output reg ld_A,
    output reg ld_Q,
    output reg shift_left_enable_a,
    output reg select_add,
    output reg select_mux_2,
    output reg shift_left_enable_q,
    output reg count_enable,
    output reg ld_rem_quotient,
    output reg done 
);

//FSM states using parameters
parameter [3:0] idle = 4'b0000;
parameter [3:0] load = 4'b0001;
parameter [3:0] load_wait = 4'b0010;
parameter [3:0] shift_a = 4'b0011;
parameter [3:0] wait_a = 4'b0100;
parameter [3:0] adder = 4'b0101;
parameter [3:0] subtractor = 4'b0110;
parameter [3:0] shift_q = 4'b0111;
parameter [3:0] wait_q = 4'b1000;
parameter [3:0] iter = 4'b1001;
parameter [3:0] check = 4'b1010;
parameter [3:0] correct = 4'b1011;
parameter [3:0] display = 4'b1100;

//State variables
reg  [3:0] present_state, next_state; // 3-bit state register

//State Updation Logic
always @(posedge(clk) or posedge(rst)) begin
    if(rst) begin
        /*It is to be noted that for FPGA synthesis you can
        write the output signals here and vivado is clever
        enough to synthesis the design.
        However when the same design is synthesized it is not
        at all recommended to write the register on LHS
        in different always blocks.
        It is even not recommended to write output signals here*/
        select_A <= 1'b0;
        select_Q <= 1'b0;
        ld_A <= 1'b0;
        ld_Q <= 1'b0;
        shift_left_enable_a <= 1'b0;
        select_add <= 1'b0;
        select_mux_2 <= 1'b0;
        shift_left_enable_q <= 1'b0;
        count_enable <= 1'b0;
        ld_rem_quotient <= 1'b0;
        present_state <= idle; // Reset to idle state
    end 
    else begin
        present_state <= next_state; // Update state on clock edge
    end
end

//Next State Logic
always @(present_state or start) begin
    case (present_state)
        idle : begin
            next_state = (start == 1'b1) ? load : idle; // Transition to load state if start signal is high
        end
        
        load : begin
            next_state = shift_a; // Transition to load_wait state after loading
        end
        
        shift_a : begin
            next_state = wait_a; // Transition to wait_a state after shifting A
        end
        wait_a : begin
            next_state = (negative_flag == 1'b1)?adder:subtractor; // Transition to add_sub_wait state after waiting for A
        end
        adder : begin
            next_state = shift_q; // Transition to add_sub_wait state after addition
        end
        subtractor : begin
            next_state = shift_q; // Transition to add_sub_wait state after subtraction
        end
        
        shift_q : begin
            next_state = wait_q; // Transition to wait_q state after shifting Q
        end
        
        wait_q : begin
                next_state = (status == 1'b1)? check : iter; // Transition back to idle state when done signal is high
        end 
        iter : begin
            next_state = shift_a;//Transition back to shift_a state after counting  
        end

        check : begin
            next_state = (negative_flag == 1'b1) ? correct : display; // Transition to display state after checking
        end
        correct : begin
            next_state = display; // Transition to display state after correction
        end
        display : begin
            next_state = idle; // Transition to idle state after displaying result
        end

        default: begin
            next_state = idle; // Default case to avoid latches, go back to idle state
        end
        
    endcase
end

//Control Outputs based on the states
always @(present_state) begin
    case (present_state)
        idle: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end
        
        load: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b1; // Select A register in idle state
            select_Q = 1'b1; // Select Q register in idle state
            ld_A = 1'b1; // Load A register in idle state
            ld_Q = 1'b1; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end
        
        shift_a: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b1; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end

        wait_a: begin
             count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end

        adder: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b1; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end

        subtractor: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end
        
        shift_q: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b1; // Load A register in idle state
            ld_Q = 1'b1; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b1; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            //select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end

        wait_q: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b1; // Load A register in idle state
            ld_Q = 1'b1; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            //select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end
        
        iter: begin
            count_enable = 1'b1; // Enable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            //select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end

        check: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            //select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end
        correct: begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b1; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b1; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b1; // selection of mux_2 in idle state
            done = 1'b0; // Disable done signal in idle state
        end

        display: begin 
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            //select_add = 1'b1; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b1; // Enable loading of remainder and quotient in idle state
            //select_mux_2 = 1'b0; // selection of mux_2 in idle state
            done = 1'b1; // Disable done signal in idle state
        end

        default : begin
            count_enable = 1'b0; // Disable counter in idle state
            select_A = 1'b0; // Select A register in idle state
            select_Q = 1'b0; // Select Q register in idle state
            ld_A = 1'b0; // Load A register in idle state
            ld_Q = 1'b0; // Load Q register in idle state
            shift_left_enable_a = 1'b0; // Disable left shift for A in idle state
            select_add = 1'b0; 
            shift_left_enable_q = 1'b0; // Disable left shift for Q in idle state
            ld_rem_quotient = 1'b0; // Disable loading of remainder and quotient in idle state
            select_mux_2 = 1'b0; // selection of mux_2 in idle state
        end
    endcase
end

endmodule