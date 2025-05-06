`timescale 1ns / 1ps

module lcd_module(
    input clk,
    input rst,
    input [3:0] quotient,
    //input [3:0] tens,
    //input [3:0] hundreds,
    //input [3:0] thousands,
    output reg [6:0] seg,       // segment pattern 0-9
    output reg [3:0] digit      // digit select signals
    );

    //assign ones = quotient; // 3-bit count to 4-bit ones digit
    
    // Parameters for segment patterns
parameter ZERO   = 7'b000_0001;  // Reversed of 100_0000
parameter ONE    = 7'b100_1111;  // Reversed of 111_1001
parameter TWO    = 7'b001_0010;  // Reversed of 010_0100
parameter THREE  = 7'b000_0110;  // Reversed of 011_0000
parameter FOUR   = 7'b100_1100;  // Reversed of 001_1001
parameter FIVE   = 7'b010_0100;  // Reversed of 001_0010
parameter SIX    = 7'b010_0000;  // Reversed of 000_0010
parameter SEVEN  = 7'b000_1111;  // Reversed of 111_1000
parameter EIGHT  = 7'b000_0000;  // Reversed of 000_0000
parameter NINE   = 7'b000_1100;  // Reversed of 001_0000
parameter A      = 7'b000_1000;  // Reversed of 000_1000 (same as original)
parameter B      = 7'b110_0000;  // Reversed of 110_0000
parameter C      = 7'b011_0001;  // Reversed of 011_0001
parameter D      = 7'b100_0010;  // Reversed of 100_0010
parameter E      = 7'b001_0000;  // Reversed of 011_0000
parameter F      = 7'b011_1000;  // Reversed of 011_1000

    
    // To select each digit in turn
    //reg [1:0] digit_select;     // 2 bit counter for selecting each of 4 digits
    //reg [19:0] digit_timer;     // counter for digit refresh
    
    // Logic for controlling digit select and digit timer
    /*
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            digit_select <= 0;
            digit_timer <= 0; 
        end
        else                                        // 1ms x 4 displays = 4ms refresh period
            if(digit_timer == 99_999) begin         // The period of 100MHz clock is 10ns (1/100,000,000 seconds)
                digit_timer <= 0;                   // 10ns x 100,000 = 1ms
                digit_select <=  digit_select + 1;
            end
            else
                digit_timer <=  digit_timer + 1;
    end
    */

    //Only enabling the first digit for now
    always @(posedge(clk)) begin
        //digit_select <= 2'b00;
		digit <= 4'b1110;
    end
    
/*      Logic for driving the 4 bit anode output based on digit select
    always @(digit_select) begin
        case(digit_select) 
            2'b00 : digit = 4'b1110;   // Turn on ones digit
            2'b01 : digit = 4'b1101;   // Turn on tens digit
            2'b10 : digit = 4'b1011;   // Turn on hundreds digit
            2'b11 : digit = 4'b0111;   // Turn on thousands digit
        endcase
    end
     */
    // Logic for driving segments based on which digit is selected and the value of each digit
    always @(*) begin
/*         case(digit_select)
            2'b00 : begin   */     // ONES DIGIT
                        case(quotient)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                            4'b1010 : seg = A;
                            4'b1011 : seg = B;
                            4'b1100 : seg = C;
                            4'b1101 : seg = D;
                            4'b1110 : seg = E; 
                            4'b1111 : seg = F;
							default: seg = 7'b000_0000;
                        endcase
    end
/*       
            2'b01 : begin       // TENS DIGIT
                        case(tens)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                            4'b1010 : seg = A;
                            4'b1011 : seg = B;
                            4'b1100 : seg = C;
                            4'b1101 : seg = D;
                            4'b1110 : seg = E;
                            4'b1111 : seg = F;
                        endcase
                    end
                    
            2'b10 : begin       // HUNDREDS DIGIT
                        case(hundreds)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                            4'b1010 : seg = A;
                            4'b1011 : seg = B;
                            4'b1100 : seg = C;
                            4'b1101 : seg = D;
                            4'b1110 : seg = E;
                            4'b1111 : seg = F;
                        endcase
                    end
                    
            2'b11 : begin       // Thousands DIGIT
                        case(thousands)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                            4'b1010 : seg = A;
                            4'b1011 : seg = B;
                            4'b1100 : seg = C;
                            4'b1101 : seg = D;
                            4'b1110 : seg = E;
                            4'b1111 : seg = F;
                        endcase
                    end
                    */
             // Default case to turn off all segments
        //endcase
   // end


endmodule