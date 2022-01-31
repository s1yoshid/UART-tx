//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2022 05:26:28 PM
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
    //input [3:0] sw,
    //input btn0,
    input i_Button,
    input i_Clk,
    output o_TxD
    //output TxD_debug,
    //output transmit_debug,
    //output button_debug, 
    //output clk_debug
); 

logic w_Transmit;
logic w_Stable;
logic [7:0] data = 8'b01100001;
//logic [7:0] data = 8'b10101010;
//assign TxD_debug = TxD;
//assign transmit_debug = transmit;
//assign button_debug = btn1;
//assign clk_debug = clk;

tx_debounce_3 D2 (
    .i_Clk(i_Clk), 
    .i_Switch(i_Button), 
    .o_Stable(w_Stable)
);
tx_timer T1 (
    .i_Clk(i_Clk),
    .i_Stable(w_Stable),
    .o_Transmit(w_Transmit)
);
tx_2 TX1 (
    .i_Clk(i_Clk), 
    .i_Transmit(w_Transmit),
    .o_TxD(o_TxD),
    .i_Data(data)
);

endmodule

