
//=============================================================================
// SPI Transaction
//-----------------------------------------------------------------------------
// Represents an SPI transaction exchanged between the sequence, driver,
// monitor, and scoreboard.
//=============================================================================

class spi_xtn extends uvm_sequence_item;

        `uvm_object_utils(spi_xtn)

        // SPI interface signals.
        bit        ss;            // Slave Select
        bit        sclk;          // Serial Clock
        bit [7:0]  mosi;          // Master Out Slave In
        rand bit [7:0] miso;       // Master In Slave Out
        bit        spi_inpt_req;   // SPI input request

        //-------------------------------------------------------------------------
        // Constructor
        //-------------------------------------------------------------------------
        function new(string name = "spi_xtn");
                super.new(name);
        endfunction : new


        //-------------------------------------------------------------------------
        // Print transaction fields for UVM debug messages.
        //-------------------------------------------------------------------------
        function void do_print(uvm_printer printer);
                super.do_print(printer);

                printer.print_field("ss",          ss,          1, UVM_BIN);
                printer.print_field("sclk",        sclk,        1, UVM_BIN);
                printer.print_field("mosi",        mosi,        8, UVM_BIN);
                printer.print_field("miso",        miso,        8, UVM_BIN);
                printer.print_field("spi_inpt_req", spi_inpt_req, 1, UVM_BIN);

        endfunction : do_print

endclass : spi_xtn

