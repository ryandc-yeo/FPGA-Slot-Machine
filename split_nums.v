`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 04:34:18 PM
// Design Name: 
// Module Name: split_nums
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



module split_nums(
input [13:0] score,
output  [3:0] score1,
output  [3:0]score2,
output  [3:0] score3,
output  [3:0] score4


    );
     assign score1 = score/1000;
     assign score2 = (score - (score1*1000))/100;
     assign score3 = (score - (score1*1000) - (score2*100))/10;
     assign score4 = (score - (score1*1000) - (score2*100) - (score3*10));
     always @(score) begin
     $display ("score %d", score);
     $display("%d%d%d%d", score1, score2,score3,score4);
       end
endmodule


