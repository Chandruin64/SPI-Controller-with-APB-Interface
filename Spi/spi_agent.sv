
//=============================================================================
// SPI Agent
//-----------------------------------------------------------------------------
// Encapsulates the SPI sequencer, driver and monitor.
// Supports both active and passive agent configurations.
//=============================================================================

class spi_agent extends uvm_agent;

        `uvm_component_utils(spi_agent)

        spi_driver        drv;
        spi_monitor       mon;
        spi_sequencer     seqr;
        spi_agent_config  cfg;

        extern function new(string name = "spi_agent",
                            uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

endclass : spi_agent


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------
function spi_agent::new(string name = "spi_agent",
                        uvm_component parent);
        super.new(name, parent);
endfunction : new


//-----------------------------------------------------------------------------
// Create agent components based on the active/passive configuration.
//-----------------------------------------------------------------------------
function void spi_agent::build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!uvm_config_db#(spi_agent_config)::get(
                this, "", "spi_agent_config", cfg))
                `uvm_fatal("Agent Config", "Failed");

        // Monitor is present in both active and passive modes.
        mon = spi_monitor::type_id::create("mon", this);

        // Driver and sequencer are required only for an active agent.
        if(cfg.is_active == UVM_ACTIVE) begin
                drv  = spi_driver::type_id::create("drv", this);
                seqr = spi_sequencer::type_id::create("seqr", this);
        end

endfunction : build_phase


//-----------------------------------------------------------------------------
// Connect sequencer to driver for active-agent operation.
//-----------------------------------------------------------------------------
function void spi_agent::connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        if(cfg.is_active == UVM_ACTIVE)
                drv.seq_item_port.connect(seqr.seq_item_export);

endfunction : connect_phase
