`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2022 10:49:11 AM
// Design Name: 
// Module Name: tx_timer_tb
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


module tx_timer_tb();

    logic clk, stable, transmit;

    tx_timer UUT (
        .i_Clk(clk),
        .i_Stable(stable),
        .o_Transmit(transmit)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        stable = 0;
        #10 stable = 1;
        #100 stable = 0;
        #50 stable = 1;
        #300 stable = 0;
        #100 $finish;
    end

endmodule
