`timescale 1ns / 1ps

module seven_seg(
    input clk_100MHz,
    input reset,
    input [3:0] ones,
    input [3:0] tens,
    input [3:0] hundreds,
    input [3:0] thousands,
    output reg [0:6] seg,
    output reg [3:0] digit
);
    
    // Corrected 7-segment patterns (Common Anode)
    parameter ZERO  = 7'b0000001;  // 0
    parameter ONE   = 7'b1001111;  // 1
    parameter TWO   = 7'b0010010;  // 2 
    parameter THREE = 7'b0000110;  // 3
    parameter FOUR  = 7'b1001100;  // 4
    parameter FIVE  = 7'b0100100;  // 5
    parameter SIX   = 7'b0100000;  // 6
    parameter SEVEN = 7'b0001111;  // 7
    parameter EIGHT = 7'b0000000;  // 8
    parameter NINE  = 7'b0000100;  // 9
    
    reg [1:0] digit_select;
    reg [16:0] digit_timer;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if(reset) begin
            digit_select <= 0;
            digit_timer <= 0; 
        end else begin
            if(digit_timer == 99_999) begin
                digit_timer <= 0;
                digit_select <= digit_select + 1;
            end else begin
                digit_timer <= digit_timer + 1;
            end
        end
    end
   
    always @* begin
        case(digit_select)
            2'b00: digit = 4'b1110;  // Ones
            2'b01: digit = 4'b1101;  // Tens
            2'b10: digit = 4'b1011;  // Hundreds
            2'b11: digit = 4'b0111;  // Thousands
        endcase
    end
    
    always @* begin
        case(digit_select)
            2'b00: seg = get_seg(ones);
            2'b01: seg = get_seg(tens);
            2'b10: seg = get_seg(hundreds);
            2'b11: seg = get_seg(thousands);
        endcase
    end
    
    function [6:0] get_seg(input [3:0] num);
        case(num)
            0: get_seg = ZERO;
            1: get_seg = ONE;
            2: get_seg = TWO;
            3: get_seg = THREE;
            4: get_seg = FOUR;
            5: get_seg = FIVE;
            6: get_seg = SIX;
            7: get_seg = SEVEN;
            8: get_seg = EIGHT;
            9: get_seg = NINE;
            default: get_seg = 7'b1111111;
        endcase
    endfunction
endmodule


