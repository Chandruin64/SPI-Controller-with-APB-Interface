
//=============================================================================
// SPI Driver
//-----------------------------------------------------------------------------
// Drives MISO data to the DUT based on the configured SPI mode.
// Supports CPOL, CPHA and LSB/MSB-first configurations.
//=============================================================================

class spi_driver extends uvm_driver#(spi_xtn);

        `uvm_component_utils(spi_driver)

        // SPI control configuration.
        bit [7:0] ctrl;
        bit       lsb;
        bit       cpol;
        bit       cpha;

        spi_agent_config cfg;
        virtual spi_intf.SPI_DRV_MP vif;

        extern function new(string name = "spi_driver",
                            uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task drive(spi_xtn xtn);
        extern function void report_phase(uvm_phase phase);

endclass : spi_driver


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------
function spi_driver::new(string name = "spi_driver",
                         uvm_component parent);
        super.new(name, parent);
endfunction : new


//-----------------------------------------------------------------------------
// Retrieve SPI agent configuration.
//-----------------------------------------------------------------------------
function void spi_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(spi_agent_config)::get(
                this, "", "spi_agent_config", cfg))
                `uvm_fatal("SPI Agent Config", "Failed");

endfunction : build_phase


//-----------------------------------------------------------------------------
// Connect the virtual interface from the agent configuration.
//-----------------------------------------------------------------------------
function void spi_driver::connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        vif = cfg.vif;

endfunction : connect_phase


//-----------------------------------------------------------------------------
// Fetch transactions from the sequencer and drive them onto the SPI interface.
//-----------------------------------------------------------------------------
task spi_driver::run_phase(uvm_phase phase);

        forever begin

                seq_item_port.get_next_item(req);
                drive(req);
                seq_item_port.item_done();

        end

endtask : run_phase


//-----------------------------------------------------------------------------
// Drive MISO according to CPOL, CPHA and bit-order configuration.
//-----------------------------------------------------------------------------
task spi_driver::drive(spi_xtn xtn);

        // Retrieve SPI control register configuration.
        if(!uvm_config_db#(bit[7:0])::get(this, "", "ctrl", ctrl))
                `uvm_fatal("SPI Driver Control", "Failed");

        // Decode SPI mode and bit-order settings.
        lsb  = ctrl[0];
        cpha = ctrl[2];
        cpol = ctrl[3];

        // Wait for the beginning of an active SPI transaction.
        wait(!vif.spi_drv_cb.ss);

        // For CPHA = 0, drive the first MISO bit before the first clock edge.
        if(!cpha)
                vif.spi_drv_cb.miso <= xtn.miso[lsb ? 0 : 7];

        // Drive remaining MISO bits on the appropriate clock edge.
        for(int i = (cpha ? 0 : 1); i < 8; i++) begin

                // Select sampling/driving edge based on CPOL and CPHA.
                if(cpha ^ cpol)
                        @(posedge vif.spi_drv_cb.sclk);
                else
                        @(negedge vif.spi_drv_cb.sclk);

                // Select bit order based on LSB/MSB-first configuration.
                vif.spi_drv_cb.miso <= xtn.miso[lsb ? i : (7-i)];

        end

        `uvm_info(get_full_name(),
                  $sformatf("The Data sent from SPI DRIVER:\n%s",
                            xtn.sprint()),
                  UVM_LOW);

        cfg.spi_drv_sent_data_count++;

endtask : drive


//-----------------------------------------------------------------------------
// Report number of SPI transactions driven.
//-----------------------------------------------------------------------------
function void spi_driver::report_phase(uvm_phase phase);

        `uvm_info(get_full_name(),
                  $sformatf("SPI DRIVER: No of transaction sent: %0d",
                            cfg.spi_drv_sent_data_count),
                  UVM_LOW);

endfunction : report_phase
