`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2023 04:30:59 PM
// Design Name: 
// Module Name: actual_display
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

module actual_display(
	// Inputs
	fast_clk,
	clk_blink,
	sel,
	seg1,
	seg2,
	seg3,
	seg4,
	score1,
	score2,
	score3,
	score4,
	is_spinning,
    seg, 
    an
	
	);
	//make a fast clock thats slower than 100mhz for updating the clock display
	// do this in the clock divider and pass it in
	input fast_clk; //fast clk to update segments
	input clk_blink;
	input sel;
	input  [6:0] seg1;
    input [6:0] seg2;
	input [6:0] seg3;
	input [6:0] seg4;
	input [6:0] score1;
	input [6:0] score2;
	input [6:0] score3;
	input [6:0] score4;
    input is_spinning;
	output  [6:0] seg;
	output  [3:0] an;
	
	reg[6:0] temp_seg = 7'b1111001;
	reg[3:0] temp_an = 4'b0000;
	reg[1:0] pos = 2'b00;
    
    always @(posedge fast_clk) begin
        if (pos ==0) begin //m10
            if (!is_spinning && sel) begin
                temp_seg <= score1;
            end
            else begin
                temp_seg <= seg1;
            end
            temp_an <= 4'b0111;
            pos <= pos + 1'b1;

        end
        else if (pos ==1) begin //m1
            if (!is_spinning && sel) begin
                temp_seg <= score2;
            end
            else begin
                temp_seg <= seg2;
            end
            temp_an <= 4'b1011;
            pos <= pos + 1'b1;

        end
        else if (pos ==2) begin //m1
            if (!is_spinning && sel) begin
                temp_seg <= score3;
            end
            else begin
                temp_seg <= seg3;
            end
            temp_an <= 4'b1101;
            pos <= pos + 1'b1;

       end
       else if (pos ==3) begin //m1
            if (!is_spinning && sel) begin
               temp_seg <= score4;
           end
           else begin
               temp_seg <= seg4;
           end
           temp_an <= 4'b1110;
           pos <= pos + 1'b1;
       end
    end

    assign an = temp_an;
    assign seg = temp_seg;
	
	
endmodule

