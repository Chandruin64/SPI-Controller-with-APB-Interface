//------------------------------------------------------------------------------
// Module: spi_slave_select
// Description:
// Generates the active-low SPI slave-select signal and indicates when the
// SPI transfer is complete.
//------------------------------------------------------------------------------

module spi_slave_select (
    input         PRESETn,
    input  [1:0]  spi_mode,
    input         mstr,
    input         spiswai,
    input         PCLK,
    input         send_data,
    input  [11:0] BaudRateDivisor,
    output reg    ss,
    output reg    receive_data,
    output        tip
);

    reg  [15:0] count;
    wire [15:0] target;
    reg         rcv;

    // Determine the duration for which the slave-select remains active.
    assign target = BaudRateDivisor * 5'd16;

    // TIP indicates that an SPI transfer is in progress.
    assign tip = ~ss;

    // Generate slave-select and transfer-completion indication.
    always @(negedge PRESETn or posedge PCLK) begin
        if (!PRESETn) begin
            count <= 16'hffff;
            ss    <= 1'b1;
            rcv   <= 1'b0;
        end
        else if (mstr &&
                 ((spi_mode == 2'b00) ||
                  ((spi_mode == 2'b01) && (!spiswai)))) begin

            // Start a new SPI transfer when transmit data is available.
            if (send_data) begin
                ss    <= 1'b0;
                count <= 16'h0;
            end

            // Keep the slave selected until the programmed transfer period
            // has elapsed.
            else if (count <= (target - 1'b1)) begin
                ss    <= 1'b0;
                count <= count + 1'b1;

                if (count == (target - 1'b1))
                    rcv <= 1'b1;
            end

            // End the SPI transfer and return SS to its inactive state.
            else begin
                ss    <= 1'b1;
                rcv   <= 1'b0;
                count <= 16'hffff;
            end
        end
        else begin
            ss    <= 1'b1;
            rcv   <= 1'b0;
            count <= 16'hffff;
        end
    end

    // Delay the receive indication by one PCLK cycle.
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            receive_data <= 1'b0;
        else
            receive_data <= rcv;
    end

endmodule
