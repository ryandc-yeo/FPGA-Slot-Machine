`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 01:12:20 PM
// Design Name: 
// Module Name: clk_gradual
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



module clk_gradual(
    input clk,
    input clk_twohz, //for counter
    input is_spinning,
    output stop1,
    output  stop2,
    output  stop3,
    output stop4
);

reg[7:0] counter = 0;

reg temp1 = 1'b0;
reg temp2 = 1'b0;
reg temp3 = 1'b0;
reg temp4 = 1'b0;

always @(posedge clk_twohz) begin
    //left most stops after 1 s
    //each one stops half a second after 
    //slow down clk each 
    if (counter == 8'd2) begin
        temp1 <= 1'b1;
    end
    if (counter == 8'd3) begin
        temp2 <= 1'b1;
    end
    if (counter == 8'd4) begin
        temp3 <= 1'b1;
    end
    if (counter == 8'd5) begin
        temp4 <= 1'b1;
    end
    else begin
        counter <= counter + 8'b1;
    end
end

//add something so when we start a new spin we reset counter


assign stop1 = temp1;
assign stop2 = temp2;
assign stop3 = temp3;
assign stop4 = temp4;



endmodule
