//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2022 02:16:32 PM
// Design Name: 
// Module Name: tx_2
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
// CLKS_PER_BIT = (input clk frequency) / (baud rate frequency)
// CLKS_PER_BIT = 100 MHz / 9600 = 10417
// 
// CLK_SIZE_BITS = size of clock to count cycles per bit
// 
//////////////////////////////////////////////////////////////////////////////////

module tx_2 #(
  parameter CLKS_PER_BIT = 10417,
  parameter CLK_SIZE_BITS = 14
) (
  input i_Clk,
  input i_Transmit,
  input [7:0] i_Data,
  //output o_active,
  output o_TxD
  //output o_done
);

localparam IDLE=3'd0, START_BIT=3'd1, DATA_BITS=3'd2, STOP_BIT=3'd3, DONE=3'd4;

logic [2:0] tx_state, tx_next_state;
logic [CLK_SIZE_BITS-1:0] clk_count = 0;
logic [7:0] data_store = 0;
logic [2:0] data_index = 0;
logic r_TxD = 0;
//logic r_active, r_done, r_serial_data = 0;

always @(posedge i_Clk) begin
    //if(~i_Transmit)
        //tx_state <= IDLE;
        // add clk and index reset later if needed

    if (tx_state == START_BIT && tx_state == tx_next_state) begin
        clk_count <= clk_count + 1;
        tx_state <= tx_next_state;
    end

    else if (tx_state == DATA_BITS && tx_state == tx_next_state) begin
        if(clk_count == CLKS_PER_BIT-1) begin
            clk_count <= 0;
            data_index <= data_index + 1;
        end
        else
            clk_count <= clk_count + 1;

        tx_state <= tx_next_state;
    end

    else if (tx_state == STOP_BIT && tx_state == tx_next_state) begin
        clk_count <= clk_count + 1;
        tx_state <= tx_next_state;
    end

    else begin
        clk_count <= 0;
        data_index <= 0;
        tx_state <= tx_next_state;
    end
end

always_comb begin
    case(tx_state)
        IDLE : begin
            if(i_Transmit) begin
                tx_next_state = START_BIT;
                data_store = i_Data;
            end
            else begin
                tx_next_state = IDLE;
            end
            
            //r_active = 1'b0;
            r_TxD = 1'b1;
            //r_done = 1'b0;
        end

        START_BIT : begin
            if(clk_count < CLKS_PER_BIT-1)
                tx_next_state = START_BIT;
            else
                tx_next_state = DATA_BITS;
            
            //r_active = 1'b1;
            r_TxD = 1'b0;
            //r_done = 1'b0;
        end

        DATA_BITS : begin
            if(clk_count < CLKS_PER_BIT-1)
                tx_next_state = DATA_BITS;
            else begin
                if(data_index < 7)
                    tx_next_state = DATA_BITS;
                else
                    tx_next_state = STOP_BIT;
            end
            
            //r_active = 1'b1;
            r_TxD = data_store[data_index];
            //r_done = 1'b0;
        end
        
        STOP_BIT : begin
            if(clk_count < CLKS_PER_BIT-1)
                tx_next_state = STOP_BIT;
            else
                tx_next_state = DONE;
            
            //r_active = 1'b1;
            r_TxD = 1'b1;
            //r_done = 1'b0;
        end

        DONE : begin
            tx_next_state = IDLE;

            //r_active = 1'b0;
            r_TxD = 1'b1;
            //r_done = 1'b1;
        end

        default:
            tx_next_state = IDLE;
    endcase
end

assign o_TxD = r_TxD;
//assign o_done = r_done;

endmodule
