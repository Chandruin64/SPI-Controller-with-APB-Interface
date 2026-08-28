//=============================================================================
// ENVIRONMENT CONFIGURATION
//=============================================================================

class env_config extends uvm_object;

        `uvm_object_utils(env_config)

        //-------------------------------------------------------------------------
        // Environment components
        //-------------------------------------------------------------------------

        bit has_scoreboard        = 1;
        bit has_spi_agent         = 1;
        bit has_apb_agent         = 1;
        bit has_virtual_sequence  = 0;

        //-------------------------------------------------------------------------
        // Agent configurations
        //-------------------------------------------------------------------------

        spi_agent_config spi_cfg;
        apb_agent_config apb_cfg;

        //-------------------------------------------------------------------------
        // RAL model
        //-------------------------------------------------------------------------

        reg_block reg_model;

        extern function new(string name = "env_config");

endclass : env_config


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------

function env_config::new(string name = "env_config");

        super.new(name);

endfunction : new
