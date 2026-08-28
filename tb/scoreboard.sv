//------------------------------------------------------------------------------
// Scoreboard
//------------------------------------------------------------------------------
// Performs:
// 1. APB functional coverage
// 2. SPI functional coverage
// 3. APB-to-SPI data comparison
// 4. Register-level comparison using UVM RAL
//------------------------------------------------------------------------------

class scoreboard extends uvm_scoreboard;

        `uvm_component_utils(scoreboard)

        // Transactions received from APB and SPI monitors
        apb_xtn apb_data, apb_cov_data;
        spi_xtn spi_data, spi_cov_data;

        // Environment configuration and RAL model
        env_config env_cfg;
        reg_block reg_model;
        uvm_status_e status;
        bit [7:0] CTRL_REG;

        // Analysis FIFOs for APB and SPI monitor data
        uvm_tlm_analysis_fifo#(apb_xtn) apb_fifo;
        uvm_tlm_analysis_fifo#(spi_xtn) spi_fifo;


        //--------------------------------------------------------------------------
        // APB Functional Coverage
        //--------------------------------------------------------------------------

        covergroup apb_cover_group;
                option.per_instance = 1;

                // APB reset behavior
                Reset: coverpoint apb_cov_data.PRESETn {
                        bins rst = {0,1};
                }

                // Valid APB register addresses
                Addr: coverpoint apb_cov_data.PADDR {
                        bins addr[] = {0,1,2,3,5};
                }

                // APB select signal
                Selx: coverpoint apb_cov_data.PSEL {
                        bins sel = {0,1};
                }

                // APB enable phase
                Enable: coverpoint apb_cov_data.PENABLE {
                        bins enb = {0,1};
                }

                // APB read/write operation
                Write: coverpoint apb_cov_data.PWRITE {
                        bins wrt = {0,1};
                }

                // APB transfer completion
                Ready: coverpoint apb_cov_data.PREADY {
                        bins rdy = {0,1};
                }

                // APB slave error response
                Error: coverpoint apb_cov_data.PSLVERR {
                        bins err = {0,1};
                }

                // APB write-data value ranges
                Wdata: coverpoint apb_cov_data.PWDATA {
                        bins low  = {[8'h00:8'h0f]};
                        bins high = {[8'h10:8'hff]};
                }

                // APB read-data value ranges
                Rdata: coverpoint apb_cov_data.PRDATA {
                        bins low  = {[8'h00:8'h0f]};
                        bins high = {[8'h10:8'hff]};
                }

                // Cross coverage for APB transfer phases
                Selx_Enable: cross Selx, Enable;
                Selx_Enable_Ready: cross Selx, Enable, Ready;

        endgroup


        //--------------------------------------------------------------------------
        // SPI Functional Coverage
        //--------------------------------------------------------------------------

        covergroup spi_cover_group;
                option.per_instance = 1;

                // Slave-select behavior
                slave_select: coverpoint spi_cov_data.ss {
                        bins ss = {0,1};
                }

                // MISO data value ranges
                miso_data: coverpoint spi_cov_data.miso {
                        bins low  = {[8'h00:8'h0f]};
                        bins high = {[8'h10:8'hff]};
                }

                // MOSI data value ranges
                mosi_data: coverpoint spi_cov_data.mosi {
                        bins low  = {[8'h00:8'h0f]};
                        bins high = {[8'h10:8'hff]};
                }

                // SPI interrupt request behavior
                spi_int_req: coverpoint spi_cov_data.spi_inpt_req {
                        bins inpt[] = {0,1};
                }

        endgroup


        //--------------------------------------------------------------------------
        // Constructor
        //--------------------------------------------------------------------------

        function new (string name = "scoreboard", uvm_component parent);
                super.new(name, parent);

                // Create coverage group instances
                apb_cover_group = new();
                spi_cover_group = new();
        endfunction: new


        //--------------------------------------------------------------------------
        // Build Phase
        //--------------------------------------------------------------------------

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                // Create analysis FIFOs for monitor transactions
                apb_fifo = new("apb_fifo", this);
                spi_fifo = new("spi_fifo", this);

                // Retrieve environment configuration
                if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
                        `uvm_fatal("SCOREBOARD ENV CONFIG","FAILED")

                // Get the register model from environment configuration
                reg_model = env_cfg.reg_model;
        endfunction


        //--------------------------------------------------------------------------
        // Run Phase
        //--------------------------------------------------------------------------

        task run_phase(uvm_phase phase);
                fork

                        // Process APB transactions
                        forever begin
                                apb_fifo.get(apb_data);

                                apb_cov_data = apb_data;
                                apb_cover_group.sample();

                                // Compare APB and SPI data
                                check_data();
                                check_data1();

                                // Perform RAL register comparison
                                ral();
                        end

                        // Process SPI transactions
                        forever begin
                                spi_fifo.get(spi_data);

                                spi_cov_data = spi_data;
                                spi_cover_group.sample();
                        end

                join
        endtask


        //--------------------------------------------------------------------------
        // APB Write Data vs SPI MOSI Comparison
        //--------------------------------------------------------------------------

        task check_data1();
                wait(spi_data != null);
                wait(apb_data != null);

                // APB write to Data Register transfers data to SPI MOSI
                if(apb_data.PWRITE && (apb_data.PADDR == 3'b101)) begin

                        $display("********************SCOREBOARD********************");

                        if(apb_data.PWDATA == spi_data.mosi)
                                `uvm_info(get_type_name(),
                                          "MOSI data comparison is successful",
                                          UVM_LOW)
                        else
                                `uvm_error(get_type_name(),
                                           "MOSI data comparison is failed");

                        `uvm_info(get_type_name,
                                  $sformatf("Scoreboard:\n APB:\n%s \n SPI:\n%s",
                                            apb_data.sprint(),
                                            spi_data.sprint()),
                                  UVM_LOW)

                        $display("**************************************************\n");
                end
        endtask


        //--------------------------------------------------------------------------
        // SPI MISO Data vs APB Read Data Comparison
        //--------------------------------------------------------------------------

        task check_data();
                wait(spi_data != null);

                // APB read from Data Register receives SPI MISO data
                if(!apb_data.PWRITE && (apb_data.PADDR == 3'b101)) begin

                        $display("####################SCOREBOARD####################");

                        if(apb_data.PRDATA == spi_data.miso)
                                `uvm_info(get_type_name(),
                                          "MISO data comparison is successful",
                                          UVM_LOW)
                        else
                                `uvm_error(get_type_name(),
                                           "MISO data comparison is failed");

                        `uvm_info(get_type_name,
                                  $sformatf("Scoreboard:\n APB:\n%s \n SPI:\n%s",
                                            apb_data.sprint(),
                                            spi_data.sprint()),
                                  UVM_LOW)

                        $display("##################################################\n");
                end
        endtask


        //--------------------------------------------------------------------------
        // Register Abstraction Layer (RAL) Comparison
        //--------------------------------------------------------------------------

        task ral();

                //--------------------------------------------------------------------------
                // Control Register 1 (CR1)
                //--------------------------------------------------------------------------

                reg_model.cr1.read(status, CTRL_REG, UVM_BACKDOOR,
                                    .map(reg_model.map));

                if(apb_data.PADDR == 0 && apb_data.PWRITE == 1)
                        if(apb_data.PWDATA == CTRL_REG) begin
                                $display("Pass addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                                `uvm_info("REGISTER COMPARISON SUCCEED",
                                          "CR1", UVM_LOW)
                        end
                        else begin
                                `uvm_error("REGISTER COMPARISON FAILED",
                                           "CR1")
                                $display("Fail addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                        end


                //--------------------------------------------------------------------------
                // Control Register 2 (CR2)
                //--------------------------------------------------------------------------

                reg_model.cr2.read(status, CTRL_REG, UVM_BACKDOOR,
                                    .map(reg_model.map));

                if(apb_data.PADDR == 1 && apb_data.PWRITE == 1)
                        if(apb_data.PWDATA == CTRL_REG) begin
                                $display("Pass addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                                `uvm_info("REGISTER COMPARISON SUCCEED",
                                          "CR2", UVM_LOW)
                        end
                        else begin
                                `uvm_error("REGISTER COMPARISON FAILED",
                                           "CR2")
                                $display("Fail addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                        end


                //--------------------------------------------------------------------------
                // Baud Rate Register (BR)
                //--------------------------------------------------------------------------

                reg_model.br.read(status, CTRL_REG, UVM_BACKDOOR,
                                   .map(reg_model.map));

                if(apb_data.PADDR == 2 && apb_data.PWRITE == 1) begin
                        if(apb_data.PWDATA == CTRL_REG) begin
                                $display("Pass addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                                `uvm_info("REGISTER COMPARISON SUCCEED",
                                          "BR", UVM_LOW)
                        end
                        else begin
                                `uvm_error("REGISTER COMPARISON FAILED",
                                           "BR")
                                $display("Fail addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                        end
                end


                //--------------------------------------------------------------------------
                // Data Register (DR)
                //--------------------------------------------------------------------------

                reg_model.dr.read(status, CTRL_REG, UVM_BACKDOOR,
                                   .map(reg_model.map));

                if(apb_data.PADDR == 5 && apb_data.PWRITE == 1) begin
                        if(apb_data.PRDATA == CTRL_REG) begin
                                $display("Pass addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                                `uvm_info("REGISTER COMPARISON SUCCEED",
                                          "DR", UVM_LOW)
                        end
                        else begin
                                `uvm_error("REGISTER COMPARISON FAILED",
                                           "DR")
                                $display("Fail addr = %p, data = %h",
                                         apb_data.PADDR, apb_data.PWDATA);
                        end
                end

        endtask

endclass: scoreboard
