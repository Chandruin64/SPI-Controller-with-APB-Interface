//------------------------------------------------------------------------------
// Virtual Sequencer
//------------------------------------------------------------------------------
// Holds handles to the APB and SPI sequencers so that virtual sequences
// can coordinate protocol-specific sequences.
//------------------------------------------------------------------------------

class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

        `uvm_component_utils(virtual_sequencer)

        // Protocol-specific sequencer handles
        spi_sequencer spi_seqr;
        apb_sequencer apb_seqr;

        // Constructor
        function new (string name = "virtual_sequencer",
                      uvm_component parent);
                super.new(name, parent);
        endfunction

endclass
