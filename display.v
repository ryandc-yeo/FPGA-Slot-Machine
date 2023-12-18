`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2023 12:52:23 PM
// Design Name: 
// Module Name: display
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


module display(
    input [3:0] num,
    input stop,    
    output [6:0] seg
    
    );
    
    reg [6:0] temp;
    always @(*) begin
        if (stop) begin
            temp = seg; //UNHARDCCODEs
        end
        else begin
            case(num) 
                0: temp  = 7'b1000000;
                1: temp =  7'b1111001;
                2: temp=  7'b0100100;
                3: temp=  7'b0110000;
                4: temp=  7'b0011001;
                5: temp=  7'b0010010;
                6: temp=  7'b0000010;
                7: temp=  7'b1111000;
                8: temp=  7'b0000000;
                9: temp=  7'b0010000;
                default: temp=  7'b1111111;
           endcase
       end
    end
    
    assign seg = temp;
endmodule
