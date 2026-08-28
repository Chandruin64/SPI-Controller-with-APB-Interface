//------------------------------------------------------------------------------
// Interface: apb_intf
// Description:
// APB interface used to connect the DUT with the APB driver and monitor.
// Includes clocking blocks, modports, and APB protocol assertions.
//------------------------------------------------------------------------------

interface apb_intf (input bit clock);

    bit PCLK;
    logic PRESETn;
    logic PWRITE;
    logic PSEL;
    logic PENABLE;
    logic [2:0] PADDR;
    logic [7:0] PWDATA;
    logic [7:0] PRDATA;
    logic PREADY;
    logic PSLVERR;

    // Connect the testbench clock to the APB clock signal.
    assign PCLK = clock;

    // APB driver clocking block.
    clocking apb_drv_cb @(posedge clock);
        default input #1 output #1;

        output PRESETn;
        output PWRITE;
        output PSEL;
        output PENABLE;
        output PADDR;
        output PWDATA;

        input PRDATA;
        input PREADY;
        input PSLVERR;
    endclocking

    // APB monitor clocking block.
    clocking apb_mon_cb @(posedge clock);
        default input #1 output #1;

        input PRESETn;
        input PWRITE;
        input PSEL;
        input PENABLE;
        input PADDR;
        input PWDATA;
        input PRDATA;
        input PREADY;
        input PSLVERR;
    endclocking

    // DUT-facing APB modport.
    modport APB_DUV_MP (
        input PCLK,
        PRESETn,
        PWRITE,
        PSEL,
        PENABLE,
        PADDR,
        PWDATA,
        output PRDATA,
        PREADY,
        PSLVERR
    );

    // Driver and monitor modports.
    modport APB_DRV_MP (clocking apb_drv_cb);
    modport APB_MON_MP (clocking apb_mon_cb);

    //--------------------------------------------------------------------------
    // APB Protocol Assertions
    //--------------------------------------------------------------------------

    // APB control signals must remain stable during an active transfer.
    property signals_stable;
        @(posedge clock)
        $rose(PSEL) |->
        ($stable(PWRITE) &&
         $stable(PADDR) &&
         $stable(PWDATA)) until PREADY[->1];
    endproperty

    // PENABLE and PSEL must remain stable during the access phase.
    property penable_stable;
        @(posedge clock)
        $rose(PENABLE) |->
        ($stable(PSEL) &&
         $stable(PENABLE)) until PREADY[->1];
    endproperty

    // A selected APB access must eventually receive PREADY.
    property psel_to_pready;
        @(posedge clock)
        (PSEL && PENABLE) |-> ##[0:$] PREADY;
    endproperty

    // Check that reserved APB addresses are not accessed.
    property address_reserved;
        @(posedge clock)
        PSEL |-> ((PADDR != 3'b100) ||
                  (PADDR != 3'b110) ||
                  (PADDR != 3'b111));
    endproperty

    // PENABLE must be deasserted when PSEL is deasserted.
    property penable_deassert;
        @(posedge clock)
        (!PSEL) |-> (!PENABLE);
    endproperty

    // Write data must be known during a valid APB write.
    property valid_write_data_transfer;
        @(posedge clock)
        (PSEL && PENABLE && PWRITE) |-> (PWDATA !== 'hx);
    endproperty

    // Read data must be known during a valid APB read.
    property valid_read_data_transfer;
        @(posedge clock)
        (PSEL && PENABLE && !PWRITE) |-> (PRDATA !== 'hx);
    endproperty

    // PREADY must remain low during the APB setup phase.
    property pready_low_at_start;
        @(posedge clock)
        (PSEL && !PENABLE) |-> (!PREADY);
    endproperty

    // PREADY must be deasserted when no APB transfer is active.
    property pready_deassert;
        @(posedge clock)
        (!PSEL) |-> (!PREADY);
    endproperty

    // Assertion instances.
    SIGNAL_STABLE    : assert property (signals_stable);
    PENABLE_STABLE   : assert property (penable_stable);
    PSEL_TO_PREADY   : assert property (psel_to_pready);
    ADDRESS_RESERVED : assert property (address_reserved);
    PENABLE_DEASSERT : assert property (penable_deassert);
    PWDATA_TRANSFER  : assert property (valid_write_data_transfer);
    PRDATA_TRANSFER  : assert property (valid_read_data_transfer);
    PREADY_START     : assert property (pready_low_at_start);
    PREADY_DEASSERT  : assert property (pready_deassert);

endinterface
