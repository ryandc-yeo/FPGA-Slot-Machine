`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 12:23:52 PM
// Design Name: 
// Module Name: random_gen
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

module RandomNumberGenerator (
  input wire clk,
  input wire rst,
  output wire [3:0] random_number
);

  reg [3:0] num;

initial begin
    num <= 4'd0;
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        num <= 4'd0; // Initial seed value
    end else begin
        // Linear Feedback Shift Register (LFSR) with XOR feedback
        if (num == 4'd9) begin
            num <= 4'd0;
        end
        else begin
        num <= num + 4'd1;
        end
    end
end


assign random_number = num;

endmodule

