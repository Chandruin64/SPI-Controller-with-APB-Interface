//------------------------------------------------------------------------------
// Module: baud_generator
// Description:
// Generates the SPI serial clock (SCLK) based on the programmed baud-rate
// prescaler and selector values.
//------------------------------------------------------------------------------

module baud_generator (
    input         PCLK,
    input         PRESETn,
    input  [1:0]  spi_mode,
    input         spiswai,
    input  [2:0]  sppr,
    input  [2:0]  spr,
    input         cpol,
    input         ss,
    output reg    sclk,
    output [11:0] BaudRateDivisor
);

    wire pre_sclk;
    reg  [11:0] count;

    // Calculate the SPI clock divider from the baud-rate configuration fields.
    assign BaudRateDivisor = ((sppr + 1) * (2 ** (spr + 1)));

    // CPOL determines the idle level of SCLK.
    assign pre_sclk = cpol ? 1'b1 : 1'b0;

    // Generate SCLK while SPI is active and the slave is selected.
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            count <= 12'b0;
            sclk  <= pre_sclk;
        end
        else if ((!ss) &&
                 ((spi_mode == 2'b00) ||
                  ((spi_mode == 2'b01) && (!spiswai)))) begin

            if (count == (BaudRateDivisor - 1'b1)) begin
                count <= 12'b0;
                sclk  <= ~sclk;
            end
            else begin
                count <= count + 1'b1;
            end
        end
        else begin
            sclk  <= pre_sclk;
            count <= 12'b0;
        end
    end

endmodule
