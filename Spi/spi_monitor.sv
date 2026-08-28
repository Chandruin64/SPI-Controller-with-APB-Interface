
//=============================================================================
// SPI Monitor
//-----------------------------------------------------------------------------
// Observes SPI transfers and reconstructs MISO/MOSI data based on the
// configured CPOL, CPHA and bit-order settings.
//=============================================================================

class spi_monitor extends uvm_monitor;

        `uvm_component_utils(spi_monitor)

        // SPI control configuration.
        bit [7:0] ctrl;
        bit       lsb;
        bit       cpha;
        bit       cpol;

        uvm_analysis_port #(spi_xtn) monitor_port;
        virtual spi_intf.SPI_MON_MP vif;
        spi_agent_config cfg;

        extern function new(string name = "spi_monitor",
                            uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task collect();
        extern function void report_phase(uvm_phase phase);

endclass : spi_monitor


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------
function spi_monitor::new(string name = "spi_monitor",
                          uvm_component parent);
        super.new(name, parent);

        monitor_port = new("monitor_port", this);

endfunction : new


//-----------------------------------------------------------------------------
// Retrieve SPI agent configuration.
//-----------------------------------------------------------------------------
function void spi_monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(spi_agent_config)::get(
                this, "", "spi_agent_config", cfg))
                `uvm_fatal("SPI Agent Config", "Failed");

endfunction : build_phase


//-----------------------------------------------------------------------------
// Connect the virtual interface from the agent configuration.
//-----------------------------------------------------------------------------
function void spi_monitor::connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        vif = cfg.vif;

endfunction : connect_phase


//-----------------------------------------------------------------------------
// Continuously monitor SPI transactions.
//-----------------------------------------------------------------------------
task spi_monitor::run_phase(uvm_phase phase);

        forever begin
                collect();
        end

endtask : run_phase


//-----------------------------------------------------------------------------
// Capture and reconstruct an SPI transaction.
//-----------------------------------------------------------------------------
task spi_monitor::collect();

        int idx;
        spi_xtn xtn;

        xtn = spi_xtn::type_id::create("xtn");

        // Retrieve SPI control register configuration.
        if(!uvm_config_db#(bit[7:0])::get(this, "", "ctrl", ctrl))
                `uvm_fatal("SPI Monitor Control", "Failed");

        // Decode SPI mode and bit-order settings.
        lsb  = ctrl[0];
        cpha = ctrl[2];
        cpol = ctrl[3];

        // Wait until the SPI slave select becomes active.
        wait(!vif.spi_mon_cb.ss);

        // Capture all 8 bits of the SPI transfer.
        for(int i = 0; i < 8; i++) begin

                // Map the received bit according to the configured bit order.
                idx = lsb ? i : (7-i);

                // Sample data on the appropriate SPI clock edge.
                if(cpol ^ cpha)
                        @(negedge vif.spi_mon_cb.sclk);
                else
                        @(posedge vif.spi_mon_cb.sclk);

                xtn.miso[idx] = vif.spi_mon_cb.miso;
                xtn.mosi[idx] = vif.spi_mon_cb.mosi;

                // Capture SPI control/status signals.
                xtn.ss           = vif.spi_mon_cb.ss;
                xtn.sclk         = vif.spi_mon_cb.sclk;
                xtn.spi_inpt_req = vif.spi_mon_cb.spi_inpt_req;

        end

        `uvm_info(get_full_name(),
                  $sformatf("The Data Collected from SPI MONITOR:\n%s",
                            xtn.sprint()),
                  UVM_LOW);

        // Publish the completed transaction to analysis components.
        monitor_port.write(xtn);

        cfg.spi_mon_rcvd_data_count++;

        @(vif.spi_mon_cb);

endtask : collect


//-----------------------------------------------------------------------------
// Report number of SPI transactions monitored.
//-----------------------------------------------------------------------------
function void spi_monitor::report_phase(uvm_phase phase);

        `uvm_info(get_full_name(),
                  $sformatf("SPI MONITOR: No of transactions received: %0d",
                            cfg.spi_mon_rcvd_data_count),
                  UVM_LOW);

endfunction : report_phase

