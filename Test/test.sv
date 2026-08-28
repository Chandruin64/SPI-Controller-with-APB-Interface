//=============================================================================
// Base Test
//=============================================================================

class base_test extends uvm_test;

        `uvm_component_utils(base_test)

        environment         env;
        env_config          env_cfg;
        spi_agent_config    spi_cfg;
        apb_agent_config    apb_cfg;
        reg_block           reg_model;

        extern function new(string name = "base_test",
                            uvm_component parent);

        extern function void build_phase(uvm_phase phase);
        extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : base_test


function base_test::new(string name = "base_test",
                        uvm_component parent);
        super.new(name, parent);
endfunction : new


function void base_test::build_phase(uvm_phase phase);

        super.build_phase(phase);

        //------------------------------------------------------------------------
        // Create configuration objects
        //------------------------------------------------------------------------

        env_cfg  = env_config::type_id::create("env_cfg");
        spi_cfg  = spi_agent_config::type_id::create("spi_cfg");
        apb_cfg  = apb_agent_config::type_id::create("apb_cfg");
        reg_model = reg_block::type_id::create("reg_model");

        //------------------------------------------------------------------------
        // Build RAL model
        //------------------------------------------------------------------------

        reg_model.build();

        //------------------------------------------------------------------------
        // Get virtual interfaces
        //------------------------------------------------------------------------

        if (!uvm_config_db#(virtual spi_intf)::get(
                this, "*", "spi_intf", spi_cfg.vif))
                `uvm_fatal("SPI_IF", "Failed to get SPI virtual interface")

        if (!uvm_config_db#(virtual apb_intf)::get(
                this, "*", "apb_intf", apb_cfg.vif))
                `uvm_fatal("APB_IF", "Failed to get APB virtual interface")

        //------------------------------------------------------------------------
        // Pass configuration to environment
        //------------------------------------------------------------------------

        env_cfg.reg_model = reg_model;
        env_cfg.spi_cfg   = spi_cfg;
        env_cfg.apb_cfg   = apb_cfg;

        //------------------------------------------------------------------------
        // Create environment
        //------------------------------------------------------------------------

        env = environment::type_id::create("env", this);

endfunction : build_phase


function void base_test::end_of_elaboration_phase(uvm_phase phase);

        super.end_of_elaboration_phase(phase);

        uvm_top.print_topology();

endfunction : end_of_elaboration_phase


//=============================================================================
// CPOL0 - CPHA0 - LSBFE0
//=============================================================================

class cpol0_cpha0_lsbfe0_test extends base_test;

        `uvm_component_utils(cpol0_cpha0_lsbfe0_test)

        apb_cpol0_cpha0_lsbfe0_seq apb;
        spi_cpol0_cpha0_lsbfe0_seq spi;
        apb_rd_seq rd;
        apb_status_seq status;

        function new(string name = "cpol0_cpha0_lsbfe0_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0010);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha0_lsbfe0_seq::type_id::create("apb");
                spi = spi_cpol0_cpha0_lsbfe0_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");
                status = apb_status_seq::type_id::create("status");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);

                #30;

                rd.start(env.apb_top.agent.seqr);
                status.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha0_lsbfe0_test


//=============================================================================
// CPOL0 - CPHA1 - LSBFE0
//=============================================================================

class cpol0_cpha1_lsbfe0_test extends base_test;

        `uvm_component_utils(cpol0_cpha1_lsbfe0_test)

        apb_cpol0_cpha1_lsbfe0_seq apb;
        spi_cpol0_cpha1_lsbfe0_seq spi;
        apb_rd_seq rd;

        function new(string name = "cpol0_cpha1_lsbfe0_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0110);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha1_lsbfe0_seq::type_id::create("apb");
                spi = spi_cpol0_cpha1_lsbfe0_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);
                rd.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha1_lsbfe0_test


//=============================================================================
// CPOL1 - CPHA0 - LSBFE0
//=============================================================================

class cpol1_cpha0_lsbfe0_test extends base_test;

        `uvm_component_utils(cpol1_cpha0_lsbfe0_test)

        apb_cpol1_cpha0_lsbfe0_seq apb;
        spi_cpol1_cpha0_lsbfe0_seq spi;
        apb_rd_seq rd;

        function new(string name = "cpol1_cpha0_lsbfe0_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1010);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha0_lsbfe0_seq::type_id::create("apb");
                spi = spi_cpol1_cpha0_lsbfe0_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);

                #30;

                rd.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha0_lsbfe0_test


//=============================================================================
// CPOL1 - CPHA1 - LSBFE0
//=============================================================================

class cpol1_cpha1_lsbfe0_test extends base_test;

        `uvm_component_utils(cpol1_cpha1_lsbfe0_test)

        apb_cpol1_cpha1_lsbfe0_seq apb;
        spi_cpol1_cpha1_lsbfe0_seq spi;
        apb_rd_seq rd;

        function new(string name = "cpol1_cpha1_lsbfe0_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1110);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha1_lsbfe0_seq::type_id::create("apb");
                spi = spi_cpol1_cpha1_lsbfe0_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);
                rd.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha1_lsbfe0_test


//=============================================================================
// CPOL0 - CPHA0 - LSBFE1
//=============================================================================

class cpol0_cpha0_lsbfe1_test extends base_test;

        `uvm_component_utils(cpol0_cpha0_lsbfe1_test)

        apb_cpol0_cpha0_lsbfe1_seq apb;
        spi_cpol0_cpha0_lsbfe1_seq spi;
        apb_rd_seq rd;

        function new(string name = "cpol0_cpha0_lsbfe1_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0011);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha0_lsbfe1_seq::type_id::create("apb");
                spi = spi_cpol0_cpha0_lsbfe1_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);

                #30;

                rd.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha0_lsbfe1_test


//=============================================================================
// CPOL0 - CPHA1 - LSBFE1
//=============================================================================

class cpol0_cpha1_lsbfe1_test extends base_test;

        `uvm_component_utils(cpol0_cpha1_lsbfe1_test)

        apb_cpol0_cpha1_lsbfe1_seq apb;
        spi_cpol0_cpha1_lsbfe1_seq spi;
        apb_rd_seq rd;

        function new(string name = "cpol0_cpha1_lsbfe1_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0111);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha1_lsbfe1_seq::type_id::create("apb");
                spi = spi_cpol0_cpha1_lsbfe1_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);
                rd.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha1_lsbfe1_test


//=============================================================================
// CPOL1 - CPHA0 - LSBFE1
//=============================================================================

class cpol1_cpha0_lsbfe1_test extends base_test;

        `uvm_component_utils(cpol1_cpha0_lsbfe1_test)

        apb_cpol1_cpha0_lsbfe1_seq apb;
        spi_cpol1_cpha0_lsbfe1_seq spi;
        apb_rd_seq rd;

        function new(string name = "cpol1_cpha0_lsbfe1_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1011);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha0_lsbfe1_seq::type_id::create("apb");
                spi = spi_cpol1_cpha0_lsbfe1_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);

                #30;

                rd.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha0_lsbfe1_test


//=============================================================================
// CPOL1 - CPHA1 - LSBFE1
//=============================================================================

class cpol1_cpha1_lsbfe1_test extends base_test;

        `uvm_component_utils(cpol1_cpha1_lsbfe1_test)

        apb_cpol1_cpha1_lsbfe1_seq apb;
        spi_cpol1_cpha1_lsbfe1_seq spi;
        apb_rd_seq rd;

        function new(string name = "cpol1_cpha1_lsbfe1_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1111);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha1_lsbfe1_seq::type_id::create("apb");
                spi = spi_cpol1_cpha1_lsbfe1_seq::type_id::create("spi");
                rd  = apb_rd_seq::type_id::create("rd");

                apb.start(env.apb_top.agent.seqr);
                spi.start(env.spi_top.agent.seqr);
                rd.start(env.apb_top.agent.seqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha1_lsbfe1_test


//=============================================================================
// Low Power Test
//=============================================================================

class low_power_test extends base_test;

        `uvm_component_utils(low_power_test)

        apb_cpol1_cpha1_lsbfe0_seq apb;
        apb_low_power_seq apb1;

        function new(string name = "low_power_test",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0011_1110);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha1_lsbfe0_seq::type_id::create("apb");
                apb1 = apb_low_power_seq::type_id::create("apb1");

                apb.start(env.apb_top.agent.seqr);

                #1000;

                apb1.start(env.apb_top.agent.seqr);

                #1000;

                phase.drop_objection(this);

        endtask : run_phase

endclass : low_power_test


//=============================================================================
// Virtual Sequence Tests
//=============================================================================

//----------------------------------------------------------------------------
// CPOL0 - CPHA0 - LSBFE0
//----------------------------------------------------------------------------

class cpol0_cpha0_lsbfe0_vtest extends base_test;

        `uvm_component_utils(cpol0_cpha0_lsbfe0_vtest)

        apb_cpol0_cpha0_lsbfe0_vseq apb;
        spi_cpol0_cpha0_lsbfe0_vseq spi;
        apb_rd_vseq rd;
        apb_status_vseq status;

        function new(string name = "cpol0_cpha0_lsbfe0_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0010);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha0_lsbfe0_vseq::type_id::create("apb");
                spi = spi_cpol0_cpha0_lsbfe0_vseq::type_id::create("spi");
                rd = apb_rd_vseq::type_id::create("rd");
                status = apb_status_vseq::type_id::create("status");

                apb.start(env.vseqr);
                spi.start(env.vseqr);

                #30;

                rd.start(env.vseqr);
                status.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha0_lsbfe0_vtest


//----------------------------------------------------------------------------
// CPOL0 - CPHA1 - LSBFE0
//----------------------------------------------------------------------------

class cpol0_cpha1_lsbfe0_vtest extends base_test;

        `uvm_component_utils(cpol0_cpha1_lsbfe0_vtest)

        apb_cpol0_cpha1_lsbfe0_vseq apb;
        spi_cpol0_cpha1_lsbfe0_vseq spi;
        apb_rd_vseq rd;

        function new(string name = "cpol0_cpha1_lsbfe0_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0110);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha1_lsbfe0_vseq::type_id::create("apb");
                spi = spi_cpol0_cpha1_lsbfe0_vseq::type_id::create("spi");
                rd  = apb_rd_vseq::type_id::create("rd");

                apb.start(env.vseqr);
                spi.start(env.vseqr);
                rd.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha1_lsbfe0_vtest


//----------------------------------------------------------------------------
// CPOL1 - CPHA0 - LSBFE0
//----------------------------------------------------------------------------

class cpol1_cpha0_lsbfe0_vtest extends base_test;

        `uvm_component_utils(cpol1_cpha0_lsbfe0_vtest)

        apb_cpol1_cpha0_lsbfe0_vseq apb;
        spi_cpol1_cpha0_lsbfe0_vseq spi;
        apb_rd_vseq rd;

        function new(string name = "cpol1_cpha0_lsbfe0_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1010);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha0_lsbfe0_vseq::type_id::create("apb");
                spi = spi_cpol1_cpha0_lsbfe0_vseq::type_id::create("spi");
                rd  = apb_rd_vseq::type_id::create("rd");

                apb.start(env.vseqr);
                spi.start(env.vseqr);
                rd.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha0_lsbfe0_vtest


//----------------------------------------------------------------------------
// CPOL1 - CPHA1 - LSBFE0
//----------------------------------------------------------------------------

class cpol1_cpha1_lsbfe0_vtest extends base_test;

        `uvm_component_utils(cpol1_cpha1_lsbfe0_vtest)

        apb_cpol1_cpha1_lsbfe0_vseq apb;
        spi_cpol1_cpha1_lsbfe0_vseq spi;
        apb_rd_vseq rd;

        function new(string name = "cpol1_cpha1_lsbfe0_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1110);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha1_lsbfe0_vseq::type_id::create("apb");
                spi = spi_cpol1_cpha1_lsbfe0_vseq::type_id::create("spi");
                rd  = apb_rd_vseq::type_id::create("rd");

                apb.start(env.vseqr);
                spi.start(env.vseqr);
                rd.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha1_lsbfe0_vtest


//----------------------------------------------------------------------------
// CPOL0 - CPHA0 - LSBFE1
//----------------------------------------------------------------------------

class cpol0_cpha0_lsbfe1_vtest extends base_test;

        `uvm_component_utils(cpol0_cpha0_lsbfe1_vtest)

        apb_cpol0_cpha0_lsbfe1_vseq apb;
        spi_cpol0_cpha0_lsbfe1_vseq spi;
        apb_rd_vseq rd;

        function new(string name = "cpol0_cpha0_lsbfe1_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0011);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha0_lsbfe1_vseq::type_id::create("apb");
                spi = spi_cpol0_cpha0_lsbfe1_vseq::type_id::create("spi");
                rd  = apb_rd_vseq::type_id::create("rd");

                apb.start(env.vseqr);
                spi.start(env.vseqr);
                rd.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha0_lsbfe1_vtest


//----------------------------------------------------------------------------
// CPOL0 - CPHA1 - LSBFE1
//----------------------------------------------------------------------------

class cpol0_cpha1_lsbfe1_vtest extends base_test;

        `uvm_component_utils(cpol0_cpha1_lsbfe1_vtest)

        apb_cpol0_cpha1_lsbfe1_vseq apb;
        spi_cpol0_cpha1_lsbfe1_vseq spi;
        apb_rd_vseq rd;

        function new(string name = "cpol0_cpha1_lsbfe1_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_0111);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol0_cpha1_lsbfe1_vseq::type_id::create("apb");
                spi = spi_cpol0_cpha1_lsbfe1_vseq::type_id::create("spi");
                rd  = apb_rd_vseq::type_id::create("rd");

                apb.start(env.vseqr);
                spi.start(env.vseqr);
                rd.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol0_cpha1_lsbfe1_vtest


//----------------------------------------------------------------------------
// CPOL1 - CPHA0 - LSBFE1
//----------------------------------------------------------------------------

class cpol1_cpha0_lsbfe1_vtest extends base_test;

        `uvm_component_utils(cpol1_cpha0_lsbfe1_vtest)

        apb_cpol1_cpha0_lsbfe1_vseq apb;
        spi_cpol1_cpha0_lsbfe1_vseq spi;
        apb_rd_vseq rd;

        function new(string name = "cpol1_cpha0_lsbfe1_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1011);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha0_lsbfe1_vseq::type_id::create("apb");
                spi = spi_cpol1_cpha0_lsbfe1_vseq::type_id::create("spi");
                rd  = apb_rd_vseq::type_id::create("rd");

                apb.start(env.vseqr);
                spi.start(env.vseqr);
                rd.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha0_lsbfe1_vtest


//----------------------------------------------------------------------------
// CPOL1 - CPHA1 - LSBFE1
//----------------------------------------------------------------------------

class cpol1_cpha1_lsbfe1_vtest extends base_test;

        `uvm_component_utils(cpol1_cpha1_lsbfe1_vtest)

        apb_cpol1_cpha1_lsbfe1_vseq apb;
        spi_cpol1_cpha1_lsbfe1_vseq spi;
        apb_rd_vseq rd;

        function new(string name = "cpol1_cpha1_lsbfe1_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0111_1111);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha1_lsbfe1_vseq::type_id::create("apb");
                spi = spi_cpol1_cpha1_lsbfe1_vseq::type_id::create("spi");
                rd  = apb_rd_vseq::type_id::create("rd");

                apb.start(env.vseqr);
                spi.start(env.vseqr);
                rd.start(env.vseqr);

                phase.drop_objection(this);

        endtask : run_phase

endclass : cpol1_cpha1_lsbfe1_vtest


//=============================================================================
// Low Power Virtual Test
//=============================================================================

class low_power_vtest extends base_test;

        `uvm_component_utils(low_power_vtest)

        apb_cpol1_cpha1_lsbfe0_vseq apb;
        apb_low_power_vseq apb1;

        function new(string name = "low_power_vtest",
                     uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);

                super.build_phase(phase);

                env_cfg.has_virtual_sequence = 1;

                uvm_config_db#(env_config)::set(
                        this, "*", "env_config", env_cfg);

                uvm_config_db#(bit[7:0])::set(
                        this, "*", "ctrl", 8'b0011_1110);

        endfunction : build_phase


        task run_phase(uvm_phase phase);

                phase.raise_objection(this);

                apb = apb_cpol1_cpha1_lsbfe0_vseq::type_id::create("apb");
                apb1 = apb_low_power_vseq::type_id::create("apb1");

                apb.start(env.vseqr);

                #1000;

                apb1.start(env.vseqr);

                #1000;

                phase.drop_objection(this);

        endtask : run_phase

endclass : low_power_vtest
