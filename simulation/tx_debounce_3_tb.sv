`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2022 08:56:18 PM
// Design Name: 
// Module Name: tx_debounce_3_tb
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


module tx_debounce_3_tb();

logic clk, switch, stable;

tx_debounce_3 UUT (
    .i_Clk(clk),
    .i_Switch(switch),
    .o_Stable(stable)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    switch = 0;
    #10 switch = 1;
    #250 switch = 0;
    #200 $finish;
end

endmodule
