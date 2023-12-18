`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2023 12:41:15 PM
// Design Name: 
// Module Name: clk_dv
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


module clk_dv(
    input clk,
    output clk_onehz,
    output  clk_twohz,
    output  clk_fast,
    output clk_blink
);

reg temp_one = 0;
reg temp_two = 0;
reg temp_fast=0;
reg temp_blink = 0;

reg [31:0] counter_one = 0;
reg [31:0] counter_two = 0;
reg [31:0] counter_fast = 0;
reg [31:0] counter_blink = 0;
//100Mhz base

//one hz period  50 000 000
always @(posedge clk) begin
    if (counter_one == 32'd50000000) begin
        temp_one <= ~temp_one;
        counter_one <= 32'b0;
    end 
    else begin
        counter_one <= counter_one + 32'b1;
    end

end

//two hz period 25 000 000 ns
always @(posedge clk) begin
    // divide 100 mil to get 1Hz
    if (counter_two == 32'd25000000) begin
        temp_two <= ~temp_two;
        counter_two <= 32'b0;
    end
    else begin
       counter_two <= counter_two + 32'b1;
    end

end

always @(posedge clk) begin
    // divide 100 mil to get 1Hz
    if (counter_fast == 32'd250000) begin
        temp_fast <= ~temp_fast;
        counter_fast <= 32'b0;
    end
    else begin
       counter_fast <= counter_fast + 32'b1;
    end

end

always @(posedge clk) begin
    // 4hz
    if (counter_blink == 32'd12500000) begin
        temp_blink <= ~temp_blink;
        counter_blink <= 32'b0;
    end
    else begin
       counter_blink <= counter_blink + 32'b1;
    end

end

assign clk_onehz = temp_one;
assign clk_twohz = temp_two;
assign clk_fast = temp_fast;
assign clk_blink = temp_blink;

endmodule

