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


module tb;
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

   
    wire [3:0] num1;
    wire[3:0] num2;
    wire [3:0] num3;
    wire[3:0] num4;
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
    wire stop1;
    wire stop2;
    wire stop3;
    wire stop4;
    wire stop_score = 1'b0;
    wire [14:0] score;
    wire to_score;
    wire spinning;
    
    clk_dv clk_dv(
        .clk(clk),
        .clk_onehz(clk_onehz),
        .clk_twohz(clk_twohz),
        .clk_fast(clk_fast),
        .clk_blink(clk_blink)
    );
    stop stop_mod (.clk_twohz(clk_twohz), .btnS(btnD), .stop1(stop1), .stop2(stop2), .stop3(stop3), .stop4(stop4),.to_score(to_score), .spinning(spinning));

    lfsr lfsr1 (.out(num1), .clk(clk_fast), .reset(btnR));
    lfsr lfsr2 (.out(num2), .clk(clk_fast), .reset(btnR));
    lfsr lfsr3 (.out(num3), .clk(clk_fast), .reset(btnR));
    lfsr lfsr4 (.out(num4), .clk(clk_fast), .reset(btnR));
    

    display n1( .num(num1), .stop(stop1), .seg(seg1));
    display n2(  .num(num2),.stop(stop2),.seg(seg2));
    display n3( .num(num3),.stop(stop3),.seg(seg3));
    display n4( .num(num4),.stop(stop4),.seg(seg4));
    
    display s1( .num(score1), .stop(stop_score), .seg(score_seg1));
    display s2(  .num(score2),.stop(stop_score),.seg(score_seg2));
    display s3( .num(score3),.stop(stop_score),.seg(score_seg3));
    display s4( .num(score4),.stop(stop_score),.seg(score_seg4));
    
    scoring scoring(.num1(num1), .num2(num2), .num3(num3), .num4(num4), .to_score(to_score), .score(score));
    split_nums split(.score(score), .score1(score1), .score2(score2), .score3(score3), .score4(score4));

    
    actual_display test(
       .fast_clk(clk_fast),
       .clk_blink(clk_blink),
       .sel(sw[0]),
       .seg1(seg1),
       .seg2(seg2),
       .seg3(seg3),
       .seg4(seg4),
       .score1(score_seg1),
       .score2(score_seg2),
       .score3(score_seg3),
       .score4(score_seg4),
       .is_spinning(spinning),
       .seg(seg),
       .an(an)
           
       );
    
//always @(posedge clk_twohz) begin
//    $display("num1 : %d num2 : %d num3 : %d num4 : %d", out1, out2, out3, out4); 
//    $display("stop1 : %d stop2 : %d stop3 : %d stop4 : %d", stop1, stop2, stop3, stop4);
    
//end
endmodule
