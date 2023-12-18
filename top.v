`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 01:29:38 PM
// Design Name: 
// Module Name: top
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



module top(
    input clk, 
    input btnR, //rst
    input btnD, //run
    input [1:0]sw,
    output [6:0] seg,
    output [3:0] an
    );
    
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
    wire [13:0] score;
    wire to_score;
    wire spinning;
    wire btnD_db;
    wire is_broke;
    wire btnR_db;
    
    clk_dv clk_dv(
        .clk(clk),
        .clk_onehz(clk_onehz),
        .clk_twohz(clk_twohz),
        .clk_fast(clk_fast),
        .clk_blink(clk_blink)
    );
    debounce set_debouncce(.clk(clk), .btn(btnD), .debounced(btnD_db));
    debounce sel_debounce(.clk(clk), .btn(sw[0]), .debounced(sel_db));
    debounce rst_debounce(.clk(clk), .btn(btnR), .debounced(btnR_db));


    stop stop (.clk_twohz(clk_twohz), .btnS(btnD_db),.is_broke(is_broke), .score(score), .stop1(stop1), .stop2(stop2), .stop3(stop3), .stop4(stop4),.to_score(to_score), .spinning(spinning));

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
        
    scoring(.num1(seg1), .num2(seg2), .num3(seg3), .num4(seg4), .btnR(btnR_db), .to_score(to_score), .score(score), .is_broke(is_broke));
    split_nums(.score(score), .score1(score1), .score2(score2), .score3(score3), .score4(score4));
    
    actual_display test(
       .fast_clk(clk_fast),
       .clk_blink(clk_blink),
       .sel(sel_db),
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
    

endmodule
