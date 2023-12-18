`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 12:28:35 PM
// Design Name: 
// Module Name: tb
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


module tb_score;
reg clk;
reg btnR;
reg btnS;
reg[1:0] sw;

initial begin
    clk = 0;
    btnR = 0;
    btnS = 0;
    sw[0] = 0;
    forever #1 clk = ~clk;
end

   wire [13:0] score;
    wire [3:0] score1;
    wire[3:0] score2;
    wire [3:0] score3;
    wire[3:0] score4;
    wire clk_onehz;
    wire clk_twohz;
    wire clk_fast;
    wire clk_blink;
    wire [6:0] seg1;
    wire [6:0] seg2;
    wire [6:0] seg3;
    wire [6:0] seg4;
    wire [6:0] score_seg1;
    wire [6:0] score_seg2;
    wire [6:0] score_seg3;
    wire [6:0] score_seg4;
    reg [3:0] count = 4'd0;
    reg [3:0] num = 4'd0;
    reg to_score = 1'b1;
   
      display n1( .num(num), .stop(stop1), .seg(seg1));
      display n2(  .num(num),.stop(stop2),.seg(seg2));
      display n3( .num(num),.stop(stop3),.seg(seg3));
      display n4( .num(num),.stop(stop4),.seg(seg4));
         
      scoring scoring(.num1(seg1), .num2(seg2), .num3(seg3), .num4(seg4), .btnR(btnR_db), .to_score(to_score), .score(score), .is_broke(is_broke));
      split_nums numsplit(.score(score), .score1(score1), .score2(score2), .score3(score3), .score4(score4));
      
always @(score) begin
    $display("number %d", num);
    $display("seg1 : %d seg2 : %d seg3 : %d seg4 : %d", seg1, seg2, seg3, seg4); 
    $display("score1 : %d score2 : %d score3 : %d score4 : %d", score1, score2, score3, score4);
    
end
endmodule
