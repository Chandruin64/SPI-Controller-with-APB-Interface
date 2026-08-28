//------------------------------------------------------------------------------
// Interface: spi_intf
// Description:
// SPI interface used to connect the DUT with the SPI driver and monitor.
//------------------------------------------------------------------------------

interface spi_intf (input bit clock);

    logic ss;
    logic sclk;
    logic mosi;
    logic miso;
    logic spi_inpt_req;

    // SPI driver clocking block.
    clocking spi_drv_cb @(posedge clock);
        default input #1 output #1;

        input ss;
        input sclk;
        input mosi;
        output miso;
        input spi_inpt_req;
    endclocking

    // SPI monitor clocking block.
    clocking spi_mon_cb @(posedge clock);
        default input #1 output #1;

        input ss;
        input sclk;
        input mosi;
        input miso;
        input spi_inpt_req;
    endclocking

    // DUT-facing SPI modport.
    modport SPI_DUV_MP (
        input miso,
        output ss,
        sclk,
        mosi,
        spi_inpt_req
    );

    // Driver and monitor modports.
    modport SPI_DRV_MP (clocking spi_drv_cb);
    modport SPI_MON_MP (clocking spi_mon_cb);

endinterface
