//------------------------------------------------------------------------------
// SPI Sequencer
//------------------------------------------------------------------------------
// Passes SPI sequence items from the sequence to the driver.
//------------------------------------------------------------------------------

class spi_sequencer extends uvm_sequencer#(spi_xtn);

        `uvm_component_utils(spi_sequencer)

        // Constructor
        extern function new(string name = "spi_sequencer",
                            uvm_component parent);

endclass: spi_sequencer


//------------------------------------------------------------------------------
// Constructor
//------------------------------------------------------------------------------

function spi_sequencer::new(string name = "spi_sequencer",
                            uvm_component parent);
        super.new(name, parent);
endfunction: new
