`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:27:39 PM
// Design Name: 
// Module Name: stop
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


module stop(
input clk_twohz,
input btnS,
input is_broke,
input [13:0] score,
output stop1,
output stop2,
output stop3,
output stop4,
output to_score,
output spinning
);
reg is_spinning = 1'b0;
reg to_score_temp = 1'b0;

reg temp1 =  1'b0;
reg temp2=  1'b0;
reg temp3=  1'b0;
reg temp4=  1'b0;

reg[3:0] counter1 = 3'd0;
reg[3:0] counter2= 3'd0;
reg[3:0] counter3= 3'd0;
reg[3:0] counter4= 3'd0;

always @(posedge clk_twohz or posedge btnS) begin
    if (btnS) begin
        if (!is_spinning && score >= 13'b1010) begin
            temp1 <= 3'b0;
            temp2 <= 3'b0;
            temp3 <= 3'b0;
            temp4 <= 3'b0;
            is_spinning <= 1'b1;
        end
    end
    else begin
        if ( !temp1) begin
            $display("temp1 %b counter1 %d", temp1, counter1);
            if (counter1 == 3'd1 ) begin
                temp1 <= 1'd1;
                counter1 <= 0;
            end 
            else begin
                counter1 <= counter1 + 3'd1;
            end
        end
        if (!temp2) begin
            if (counter2 == 3'd2) begin
                temp2 <= 1'd1;
                counter2 <= 0;
             end
             else begin
                 counter2 <= counter2 + 3'd1;
             end
        end
        if (!temp3) begin    
            if (counter3 == 3'd3 && !temp3) begin
                temp3 <= 1'd1;
                counter3 <= 0;
            end
            else begin
                 counter3 <= counter3 + 3'd1;
             end
        end
        if (!temp4) begin
            if (counter4 == 3'd4 && !temp4) begin
                temp4 <= 1'd1;
                counter4 <= 0;
            end
            else begin
                 counter4 <= counter4 + 3'd1;
            end
        end
        if (!temp1 || !temp2 || !temp3 || !temp4) begin
            is_spinning <= 1'b1; //0 is numbers r still bein generated
            to_score_temp <= 1'b0;
        end else begin
            is_spinning <= 1'b0;
            to_score_temp <= 1'b1;
        end
    end
end

assign stop1 = temp1;
assign stop2 = temp2;
assign stop3 = temp3;
assign stop4 = temp4;
assign to_score =  to_score_temp;
assign spinning  = is_spinning;
endmodule
