//=============================================================================
// SPI Agent Configuration
//-----------------------------------------------------------------------------
// Stores the virtual interface, agent mode and transaction counters required
// by the SPI driver and monitor.
//=============================================================================

class spi_agent_config extends uvm_object;

        `uvm_object_utils(spi_agent_config)

        // Transaction statistics.
        int spi_drv_sent_data_count = 0;
        int spi_mon_rcvd_data_count = 0;

        // Virtual interface used by SPI driver and monitor.
        virtual spi_intf vif;

        // Configure the agent as active or passive.
        uvm_active_passive_enum is_active = UVM_ACTIVE;

        extern function new(string name = "spi_agent_config");

endclass : spi_agent_config


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------
function spi_agent_config::new(string name = "spi_agent_config");
        super.new(name);
endfunction : new
