`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2023 04:50:23 PM
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk,
    input btn,
    output debounced
    );
    
    reg debounce_temp;
    reg [15:0] counter;
    reg sync_to_clk0;
    reg sync_to_clk1;
    
    always @ (posedge clk) begin
        sync_to_clk0 <= btn;
    end
    
    always @ (posedge clk) begin
        sync_to_clk1 <= sync_to_clk0;
    end
    
    always @ (posedge clk) begin
        if (debounce_temp == sync_to_clk1) begin
            counter <= 0;
        end
        else begin 
            counter <= counter + 1'b1;
            if (counter == 16'hffff) begin
                debounce_temp <= ~debounced;
            end
        end
    end
    assign debounced = debounce_temp;
    
endmodule
