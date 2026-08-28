//------------------------------------------------------------------------------
// Module: spi
// Description:
// Connects the SPI core to the APB and SPI interfaces used by the
// verification environment.
//------------------------------------------------------------------------------

module spi (
    apb_intf.APB_DUV_MP apb,
    spi_intf.SPI_DUV_MP spi
);

    spi_core core (
        .PCLK(apb.PCLK),
        .PRESETn(apb.PRESETn),
        .PWRITE(apb.PWRITE),
        .PSEL(apb.PSEL),
        .PENABLE(apb.PENABLE),
        .PADDR(apb.PADDR),
        .PWDATA(apb.PWDATA),
        .PRDATA(apb.PRDATA),
        .PREADY(apb.PREADY),
        .PSLVERR(apb.PSLVERR),
        .miso(spi.miso),
        .ss(spi.ss),
        .sclk(spi.sclk),
        .mosi(spi.mosi),
        .spi_interrupt_request(spi.spi_inpt_req)
    );

endmodule
