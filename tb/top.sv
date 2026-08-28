`timescale 1ns/1ps

module top;

    import uvm_pkg::*;
    import pkg::*;

    // ============================================================
    // Clock
    // ============================================================

    bit clock;

    always #5 clock = ~clock;

    // ============================================================
    // Interfaces
    // ============================================================

    apb_intf apb_if(clock);
    spi_intf spi_if(clock);

    // ============================================================
    // DUT
    // ============================================================

    spi dut (
        apb_if,
        spi_if
    );

    // ============================================================
    // UVM Configuration and Test
    // ============================================================

    initial begin

        uvm_config_db#(virtual apb_intf)::set(
            null,
            "*",
            "apb_intf",
            apb_if
        );

        uvm_config_db#(virtual spi_intf)::set(
            null,
            "*",
            "spi_intf",
            spi_if
        );

        run_test();

    end

endmodule : top
