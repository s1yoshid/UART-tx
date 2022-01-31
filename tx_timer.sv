//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2022 10:29:48 AM
// Design Name: 
// Module Name: tx_timer
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


module tx_timer(
    input i_Clk,
    input i_Stable,
    output o_Transmit
    );

    localparam c_TEST_HOLD_DURATION = 10;
    localparam c_HOLD_DURATION = 10000000; // 0.1 s at 100Mhz

    logic [23:0] r_Counter = 0;
    logic r_Transmit = 1'b0;

    always @(posedge i_Clk) begin
        if(r_Counter == c_HOLD_DURATION - 1) begin
            r_Counter <= 0;
            r_Transmit <= 1;
        end
        else if(i_Stable) begin
            r_Counter <= r_Counter + 1;
            r_Transmit <= 0;
        end
        else begin
            r_Counter <= 0;
            r_Transmit <= 0;
        end
    end

    assign o_Transmit = r_Transmit;
 
endmodule
