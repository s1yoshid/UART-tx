`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2022 01:18:30 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();

logic button, clk, TxD;

top UUT (
    .i_Button(button),
    .i_Clk(clk),
    .o_TxD(TxD)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    button = 0;
    #10 button = 1;
    #100000100 button = 0;
    //#1100000 $finish;
end

endmodule
