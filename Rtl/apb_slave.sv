//------------------------------------------------------------------------------
// Module: apb_slave
// Description:
// Implements the APB slave interface for the SPI controller. Handles APB
// register accesses, SPI configuration, status generation, interrupt logic,
// and SPI operating modes.
//------------------------------------------------------------------------------

module apb_slave (
    input  PCLK,
    input  PRESETn,
    input  [`APB_ADDR_WIDTH-1:0] PADDR,
    input  PWRITE,
    input  PSEL,
    input  PENABLE,
    input  [`APB_DATA_WIDTH-1:0] PWDATA,
    output [`APB_DATA_WIDTH-1:0] PRDATA,
    output PREADY,
    output PSLVERR,
    input  ss,
    input  [`APB_DATA_WIDTH-1:0] miso_data,
    output reg send_data,
    input  receive_data,
    input  tip,
    output reg [`APB_DATA_WIDTH-1:0] mosi_data,
    output reg [1:0] spi_mode,
    output mstr,
    output cpol,
    output cpha,
    output lsbfe,
    output spiswai,
    output [2:0] sppr,
    output [2:0] spr,
    output spi_interrupt_request
);

    // APB state encoding.
    localparam IDLE   = 2'b00;
    localparam SETUP  = 2'b01;
    localparam ENABLE = 2'b10;

    // SPI operating modes.
    localparam spi_run  = 2'b00;
    localparam spi_wait = 2'b01;
    localparam spi_stop = 2'b10;

    // Masks for writable control and baud-rate register fields.
    localparam cr2_mask = 8'b0001_1011;
    localparam br_mask  = 8'b0111_0111;

    reg [1:0] STATE, next_state;
    reg [1:0] next_mode;

    wire spie;
    wire sptie;
    wire spe;

    wire modf;
    wire ssoe;
    wire modfen;

    reg sptef;
    reg spif;

    wire wr_enb;
    wire rd_enb;

    // SPI register set.
    reg [7:0] SPI_CR_1;
    reg [7:0] SPI_CR_2;
    reg [7:0] SPI_BR;
    reg [7:0] SPI_SR;
    reg [7:0] SPI_DR;

    //--------------------------------------------------------------------------
    // APB State Register
    //--------------------------------------------------------------------------

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            STATE <= IDLE;
        else
            STATE <= next_state;
    end

    //--------------------------------------------------------------------------
    // APB State Transition Logic
    //--------------------------------------------------------------------------

    always @(*) begin
        case (STATE)
            IDLE: begin
                if (PSEL && !PENABLE)
                    next_state <= SETUP;
                else
                    next_state <= IDLE;
            end

            SETUP: begin
                if (PSEL && PENABLE)
                    next_state <= ENABLE;
                else if (PSEL && !PENABLE)
                    next_state <= SETUP;
                else
                    next_state <= IDLE;
            end

            ENABLE: begin
                if (PSEL)
                    next_state <= SETUP;
                else
                    next_state <= IDLE;
            end

            default:
                next_state <= IDLE;
        endcase
    end

    // PREADY is asserted during the APB access phase.
    // PSLVERR indicates an SPI transfer-in-progress condition.
    assign PREADY  = (STATE == ENABLE) ? 1'b1 : 1'b0;
    assign PSLVERR = (STATE == ENABLE) ? tip   : 1'b0;

    // Generate APB read and write enables.
    assign wr_enb = PWRITE && (STATE == ENABLE);
    assign rd_enb = !PWRITE && (STATE == ENABLE);

    //--------------------------------------------------------------------------
    // SPI Register Write and Data Transfer Logic
    //--------------------------------------------------------------------------

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            SPI_CR_1  <= 8'b0000_0100;
            SPI_CR_2  <= 8'b0000_0000;
            SPI_BR    <= 8'b0000_0000;
            SPI_DR    <= 8'b0000_0000;
            send_data <= 1'b0;
        end
        else if (wr_enb) begin
            case (PADDR)
                3'b000: SPI_CR_1 <= PWDATA;
                3'b001: SPI_CR_2 <= PWDATA & cr2_mask;
                3'b010: SPI_BR   <= PWDATA & br_mask;
                3'b101: SPI_DR   <= PWDATA;
                default: SPI_DR  <= PWDATA;
            endcase
        end
        else if (((SPI_DR == PWDATA) &&
                  (SPI_DR != miso_data)) &&
                 (spi_mode == spi_run || spi_mode == spi_wait)) begin

            send_data <= 1'b1;
            mosi_data <= SPI_DR;
            SPI_DR    <= 8'b0;
        end
        else if (receive_data &&
                 (spi_mode == spi_run || spi_mode == spi_wait)) begin

            SPI_DR    <= miso_data;
            send_data <= 1'b0;
        end
        else begin
            send_data <= 1'b0;
        end
    end

    //--------------------------------------------------------------------------
    // APB Read Data Multiplexer
    //--------------------------------------------------------------------------

    assign PRDATA = rd_enb ?
                    (PADDR == 3'b000 ? SPI_CR_1 :
                    (PADDR == 3'b001 ? SPI_CR_2 :
                    (PADDR == 3'b010 ? SPI_BR :
                    (PADDR == 3'b011 ? SPI_SR : SPI_DR))))
                    : 8'b0;

    //--------------------------------------------------------------------------
    // SPI Control Register Fields
    //--------------------------------------------------------------------------

    assign mstr   = SPI_CR_1[4];
    assign cpol   = SPI_CR_1[3];
    assign cpha   = SPI_CR_1[2];
    assign ssoe   = SPI_CR_1[1];
    assign lsbfe  = SPI_CR_1[0];
    assign spie   = SPI_CR_1[7];
    assign spe    = SPI_CR_1[6];
    assign sptie  = SPI_CR_1[5];

    assign modfen  = SPI_CR_2[4];
    assign spiswai = SPI_CR_2[1];

    // SPI baud-rate configuration fields.
    assign sppr = SPI_BR[6:4];
    assign spr  = SPI_BR[2:0];

    // Mode-fault condition.
    assign modf = (~ss) && mstr && modfen && (~ssoe);

    // Generate the SPI interrupt request from the enabled status flags.
    assign spi_interrupt_request = (!spie && !sptie) ? 1'b0 :
                                   ( spie && !sptie) ? (spif || modf) :
                                   (!spie &&  sptie) ? sptef :
                                   (spif || sptef || modf);

    //--------------------------------------------------------------------------
    // SPI Operating Mode Register
    //--------------------------------------------------------------------------

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            spi_mode <= spi_run;
        else
            spi_mode <= next_mode;
    end

    // Determine the next SPI operating mode based on SPE and SPISWAI.
    always @(*) begin
        case (spi_mode)
            spi_run: begin
                if (!spe)
                    next_mode <= spi_wait;
                else
                    next_mode <= spi_run;
            end

            spi_wait: begin
                if (spe)
                    next_mode <= spi_run;
                else if (spiswai)
                    next_mode <= spi_stop;
                else
                    next_mode <= spi_wait;
            end

            spi_stop: begin
                if (spe)
                    next_mode <= spi_run;
                else if (!spiswai)
                    next_mode <= spi_wait;
                else
                    next_mode <= spi_stop;
            end

            default:
                next_mode <= spi_run;
        endcase
    end

    //--------------------------------------------------------------------------
    // SPI Status Register and Flags
    //--------------------------------------------------------------------------

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            SPI_SR <= 8'b0010_0000;
        else begin

            // Transmit buffer empty flag.
            if (SPI_DR == 8'b0000_0000)
                sptef <= 1'b1;
            else
                sptef <= 1'b0;

            // SPI transfer complete flag.
            if ((SPI_DR == PWDATA) ||
                ((SPI_DR == miso_data) && (SPI_DR != 8'b0000_0000)))
                spif <= 1'b1;
            else
                spif <= 1'b0;

            SPI_SR <= {spif, 1'b0, sptef, modf, 4'b0};
        end
    end

endmodule
