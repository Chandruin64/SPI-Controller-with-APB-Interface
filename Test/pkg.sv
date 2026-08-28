package pkg;

    import uvm_pkg::*;

    `include "uvm_macros.svh"

    // ============================================================
    // RAL Model
    // ============================================================

    `include "reg.sv"
    `include "reg_block.sv"

    // ============================================================
    // Configuration Classes
    // ============================================================

    `include "spi_config.sv"
    `include "apb_config.sv"
    `include "env_config.sv"

    // ============================================================
    // SPI Agent
    // ============================================================

    `include "spi_xtn.sv"
    `include "spi_seqs.sv"
    `include "spi_driver.sv"
    `include "spi_monitor.sv"
    `include "spi_sequencer.sv"
    `include "spi_agent.sv"
    `include "spi_agt_top.sv"

    // ============================================================
    // APB Agent
    // ============================================================

    `include "apb_xtn.sv"
    `include "apb_seqs.sv"
    `include "apb_driver.sv"
    `include "apb_monitor.sv"
    `include "apb_sequencer.sv"
    `include "apb_agent.sv"
    `include "apb_agt_top.sv"

    // ============================================================
    // Environment
    // ============================================================

    `include "scoreboard.sv"
    `include "virtual_sequencer.sv"
    `include "virtual_seqs.sv"
    `include "env.sv"

    // ============================================================
    // Tests
    // ============================================================

    `include "test.sv"

endpackage : pkg
