`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: t
// 
// Create Date: 12/04/2023 12:23:55 PM
// Design Name: 
// Module Name: scoring
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module scoring(
    input clk,
    input [6:0] num1,
    input [6:0] num2,
    input [6:0] num3,
    input [6:0] num4,
    input btnR,
    input to_score,
    output [13:0] score,
    output is_broke
    );
    // need to keep tracj of past score
    // need to dertermine when to score
    reg[13:0] temp_score =  14'b1100100;
    reg scored = 1'b0;
    reg temp_broke = 1'b0;

    always @(*) begin

        if (btnR) begin
            if (temp_score  < 14'b1010) begin
                temp_score <= 14'b1100100;
            end
        end

        else if (to_score)begin
            if (num1== num2 && num2== num3 && num3 == num4 && !scored) begin
                case(num1) 
                    7'b1000000: temp_score <= score + 14'b00000101; //might need to deduct 10 from all of these ?
                    7'b1111001: temp_score <= score + 14'b000001010;
                    7'b0100100: temp_score <= score + 14'b000001111;
                    7'b0110000: temp_score <= score + 14'b0000010100;
                    7'b0011001: temp_score <= score + 14'b0000011001;
                    7'b0010010: temp_score <= score + 14'b0000011110;
                    7'b0000010: temp_score <= score + 14'b00000101000;
                    7'b1111000: temp_score <= score + 14'b000001000110;
                    7'b0000000: temp_score <= score +  14'b00000011001000;
                    default: temp_score <= score +  14'b1100100000;
                endcase
                scored <= 1'b1;
                 
            end
            else begin
                if (!scored) begin
                    if (temp_score >= 14'b1010) begin
                        temp_score <= score - 14'b1010;
                        scored <= 1'b1;
                    end
                 end
            end
            //scored = 1'b1;
        end
        else begin
            if (temp_score  <  14'b1010) begin
                if (btnR) begin
                    temp_score <= 14'b1100100;
                end
            end else begin
                temp_score  <= score;
            end     
            scored <= 1'b0;

        end
    end
    assign score = temp_score;
    assign is_broke = temp_broke;
endmodule
