//=============================================================================
// ENVIRONMENT
//=============================================================================

class environment extends uvm_env;

        `uvm_component_utils(environment)

        env_config env_cfg;

        virtual_sequencer vseqr;

        spi_agt_top spi_top;
        apb_agt_top apb_top;

        scoreboard sb;

        extern function new(
                string name = "environment",
                uvm_component parent
        );

        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

endclass : environment


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------

function environment::new(
        string name = "environment",
        uvm_component parent
);

        super.new(name, parent);

endfunction


//-----------------------------------------------------------------------------
// Build Phase
//-----------------------------------------------------------------------------

function void environment::build_phase(uvm_phase phase);

        super.build_phase(phase);

        //-------------------------------------------------------------------------
        // Get environment configuration
        //-------------------------------------------------------------------------

        if (!uvm_config_db#(env_config)::get(
                this,
                "",
                "env_config",
                env_cfg
        ))
                `uvm_fatal("ENV_CONFIG", "Failed to get env_config")


        //-------------------------------------------------------------------------
        // SPI Agent
        //-------------------------------------------------------------------------

        if (env_cfg.has_spi_agent) begin

                spi_top = spi_agt_top::type_id::create(
                        "spi_top",
                        this
                );

                uvm_config_db#(spi_agent_config)::set(
                        this,
                        "*",
                        "spi_agent_config",
                        env_cfg.spi_cfg
                );

        end


        //-------------------------------------------------------------------------
        // APB Agent
        //-------------------------------------------------------------------------

        if (env_cfg.has_apb_agent) begin

                apb_top = apb_agt_top::type_id::create(
                        "apb_top",
                        this
                );

                uvm_config_db#(apb_agent_config)::set(
                        this,
                        "*",
                        "apb_agent_config",
                        env_cfg.apb_cfg
                );

        end


        //-------------------------------------------------------------------------
        // Scoreboard
        //-------------------------------------------------------------------------

        if (env_cfg.has_scoreboard)
                sb = scoreboard::type_id::create("sb", this);


        //-------------------------------------------------------------------------
        // Virtual Sequencer
        //-------------------------------------------------------------------------

        if (env_cfg.has_virtual_sequence)
                vseqr = virtual_sequencer::type_id::create("vseqr", this);

endfunction : build_phase


//-----------------------------------------------------------------------------
// Connect Phase
//-----------------------------------------------------------------------------

function void environment::connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        //-------------------------------------------------------------------------
        // Scoreboard connections
        //-------------------------------------------------------------------------

        if (env_cfg.has_scoreboard) begin

                spi_top.agent.mon.monitor_port.connect(
                        sb.spi_fifo.analysis_export
                );

                apb_top.agent.mon.monitor_port.connect(
                        sb.apb_fifo.analysis_export
                );

        end


        //-------------------------------------------------------------------------
        // Virtual Sequencer connections
        //-------------------------------------------------------------------------

        if (env_cfg.has_virtual_sequence) begin

                vseqr.spi_seqr = spi_top.agent.seqr;
                vseqr.apb_seqr = apb_top.agent.seqr;

        end

endfunction : connect_phase
