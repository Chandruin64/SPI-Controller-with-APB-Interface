//=============================================================================
// SPI Agent Top
//-----------------------------------------------------------------------------
// Top-level container for the SPI agent.
//=============================================================================

class spi_agt_top extends uvm_component;

        `uvm_component_utils(spi_agt_top)

        spi_agent agent;

        extern function new(string name = "spi_agt_top",
                            uvm_component parent);

endclass : spi_agt_top


//-----------------------------------------------------------------------------
// Constructor and agent creation.
//-----------------------------------------------------------------------------
function spi_agt_top::new(string name = "spi_agt_top",
                          uvm_component parent);

        super.new(name, parent);

        agent = spi_agent::type_id::create("spi_agent", this);

endfunction : new
