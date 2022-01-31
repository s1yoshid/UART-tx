//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2022 08:48:25 PM
// Design Name: 
// Module Name: tx_debounce_3
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


module tx_debounce_3(
    input i_Clk,
    input i_Switch,
    output o_Stable
);

    localparam c_TEST_DEBOUNCE_LIMIT = 10;
    localparam c_DEBOUNCE_LIMIT = 1000000;  // 10 ms at 100 MHz
   
    reg [19:0] r_Count = 0;
    reg r_State = 1'b0;
    reg r_Button_Ff1 = 1'b0; //button flip-flop for synchronization. Initialize it to 0
    reg r_Button_Ff2 = 1'b0; //button flip-flop for synchronization. Initialize it to 0
    
    always @(posedge i_Clk)begin
        r_Button_Ff1 <= i_Switch;
        r_Button_Ff2 <= r_Button_Ff1;
    end

    always @(posedge i_Clk) begin
        // Switch input is different than internal switch value, so an input is
        // changing.  Increase the counter until it is stable for enough time.  
        //if (i_Switch !== r_State && r_Count < c_TEST_DEBOUNCE_LIMIT)
        if (r_Button_Ff2 !== r_State && r_Count < c_DEBOUNCE_LIMIT)
            r_Count <= r_Count + 1;
    
        // End of counter reached, switch is stable, register it, reset counter
        else if (r_Count == c_DEBOUNCE_LIMIT) begin
            //r_State <= i_Switch;
            r_State <= r_Button_Ff2;
            r_Count <= 0;
        end 
    
        // Switches are the same state, reset the counter
        else
            r_Count <= 0;
    end
    
    // Assign internal register to output (debounced!)
    assign o_Stable = r_State;

endmodule
