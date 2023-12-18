`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 12:19:00 PM
// Design Name: 
// Module Name: lfsr
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

module lfsr(
    output wire [3:0] out,  // Output in the range 0-9
    input wire clk,
    input wire reset
);
    reg [4:0] lfsr = 5'b00001;
    reg[3:0] temp;
    // LFSR feedback taps for 5-bit LFSR (example: taps at 5 and 3)
    wire feedback = !(lfsr[4] ^ lfsr[2]);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 5'b00001; // Initialize to a non-zero state
        end else begin
            lfsr <= {lfsr[3:0], feedback}; // Standard LFSR operation
        end
    end

    // Skewed mapping logic for 5-bit LFSR with specified distribution
    always @(lfsr) begin
        case (lfsr)
            // Mapping states to numbers as per the specified distribution
            5'b00000, 5'b00001, 5'b00010, 
            5'b00100, 5'b00101, 5'b00110: temp <= 0; // 7 states
            5'b00111, 5'b01000, 5'b01001, 5'b01010, 
            5'b01011, 5'b01100: temp <= 1;           // 6 states
            5'b01101, 5'b01110, 5'b01111, 5'b10000, 
            5'b10001: temp <= 2;                     // 5 states
            5'b10010, 5'b10011, 5'b10100, 5'b10101: temp <= 3; // 4 states
            5'b10110, 5'b10111, 5'b11000: temp <= 4; // 3 states
            5'b11001, 5'b11010: temp <= 5;           // 2 states
            5'b11011, 5'b11100: temp <= 6;           // 2 states
            5'b11101: temp <= 7;                     // 1 state
            5'b11110: temp <= 8;                     // 1 state
            default: temp <= 9;                     // 1 state
        endcase
    end
assign out  = temp;
endmodule

