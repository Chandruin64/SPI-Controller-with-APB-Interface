//------------------------------------------------------------------------------
// Module: shifter
// Description:
// Handles SPI serial transmission and reception for all four SPI modes
// defined by the CPOL/CPHA combinations. Supports both MSB-first and
// LSB-first data transmission.
//------------------------------------------------------------------------------

module shifter (
    input PCLK,
    input sclk,
    input PRESETn,
    input ss,
    input send_data,
    input lsbfe,
    input cpha,
    input cpol,
    input [`APB_DATA_WIDTH-1:0] data_mosi,
    input miso,
    input receive_data,
    output [`APB_DATA_WIDTH-1:0] data_miso,
    output mosi
);

    reg [`APB_DATA_WIDTH-1:0] shift_register;

    reg [`APB_DATA_WIDTH-1:0] temp_reg1;
    reg [`APB_DATA_WIDTH-1:0] temp_reg2;

    // Bit counters for the four CPOL/CPHA transmission paths.
    reg [3:0] count;
    reg [3:0] count1;
    reg [3:0] count2;
    reg [3:0] count3;
    reg [3:0] count4;
    reg [3:0] count5;
    reg [3:0] count6;
    reg [3:0] count7;

    // Bit counters for the two receive paths.
    reg [3:0] count8;
    reg [3:0] count9;
    reg [3:0] count10;
    reg [3:0] count11;

    // MOSI values generated for each CPOL/CPHA combination.
    reg mosi1;
    reg mosi2;
    reg mosi3;
    reg mosi4;

    //--------------------------------------------------------------------------
    // Transmit Shift Register
    //--------------------------------------------------------------------------

    // Load transmit data when a new SPI transfer is initiated.
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            shift_register <= 8'b0;
        else if (send_data)
            shift_register <= data_mosi;
    end

    // Select the MOSI path corresponding to the configured CPOL/CPHA mode.
    assign mosi = cpha ? (cpol ? mosi4 : mosi3) :
                        (cpol ? mosi2 : mosi1);

    // Select the receive buffer corresponding to the configured SPI mode.
    assign data_miso = receive_data ?
                       (((cpha && cpol) || (!cpha && !cpol)) ?
                        temp_reg1 : temp_reg2) :
                       8'b0000_0000;

    //--------------------------------------------------------------------------
    // MOSI Generation: CPHA = 0, CPOL = 0
    //--------------------------------------------------------------------------

    always @(negedge sclk or negedge ss or negedge PRESETn or posedge receive_data) begin
        if (!PRESETn) begin
            count  <= 4'd0;
            count1 <= 4'd7;
        end
        else if (receive_data) begin
            count  <= 4'd0;
            count1 <= 4'd7;
        end
        else begin
            if (!ss) begin
                if ((!cpha) && (!cpol)) begin
                    if (lsbfe) begin
                        if (count <= 4'd7) begin
                            mosi1 <= shift_register[count];
                            count <= count + 1'b1;
                        end
                    end
                    else begin
                        if (count1 >= 4'd0) begin
                            mosi1 <= shift_register[count1];
                            count1 <= count1 - 1'b1;
                        end
                    end
                end
            end
        end
    end

    //--------------------------------------------------------------------------
    // MOSI Generation: CPHA = 0, CPOL = 1
    //--------------------------------------------------------------------------

    always @(posedge sclk or negedge ss or negedge PRESETn or posedge receive_data) begin
        if (!PRESETn) begin
            count2 <= 4'd0;
            count3 <= 4'd7;
        end
        else if (receive_data) begin
            count2 <= 4'd0;
            count3 <= 4'd7;
        end
        else begin
            if (!ss) begin
                if ((!cpha) && cpol) begin
                    if (lsbfe) begin
                        if (count2 <= 4'd7) begin
                            mosi2 <= shift_register[count2];
                            count2 <= count2 + 1'b1;
                        end
                    end
                    else begin
                        if (count3 >= 4'd0) begin
                            mosi2 <= shift_register[count3];
                            count3 <= count3 - 1'b1;
                        end
                    end
                end
            end
        end
    end

    //--------------------------------------------------------------------------
    // MOSI Generation: CPHA = 1, CPOL = 0
    //--------------------------------------------------------------------------

    always @(posedge sclk or negedge PRESETn or posedge receive_data) begin
        if (!PRESETn) begin
            count4 <= 4'd0;
            count5 <= 4'd7;
        end
        else if (receive_data) begin
            count4 <= 4'd0;
            count5 <= 4'd7;
        end
        else begin
            if (!ss) begin
                if (cpha && (!cpol)) begin
                    if (lsbfe) begin
                        if (count4 <= 4'd7) begin
                            mosi3 <= shift_register[count4];
                            count4 <= count4 + 1'b1;
                        end
                    end
                    else begin
                        if (count5 >= 4'd0) begin
                            mosi3 <= shift_register[count5];
                            count5 <= count5 - 1'b1;
                        end
                    end
                end
            end
        end
    end

    //--------------------------------------------------------------------------
    // MOSI Generation: CPHA = 1, CPOL = 1
    //--------------------------------------------------------------------------

    always @(negedge sclk or negedge PRESETn or posedge receive_data) begin
        if (!PRESETn) begin
            count6 <= 4'd0;
            count7 <= 4'd7;
        end
        else if (receive_data) begin
            count6 <= 4'd0;
            count7 <= 4'd7;
        end
        else begin
            if (!ss) begin
                if (cpha && cpol) begin
                    if (lsbfe) begin
                        if (count6 <= 4'd7) begin
                            mosi4 <= shift_register[count6];
                            count6 <= count6 + 1'b1;
                        end
                    end
                    else begin
                        if (count7 >= 4'd0) begin
                            mosi4 <= shift_register[count7];
                            count7 <= count7 - 1'b1;
                        end
                    end
                end
            end
        end
    end

    //--------------------------------------------------------------------------
    // MISO Sampling: CPHA = 0, CPOL = 0
    //              or CPHA = 1, CPOL = 1
    //--------------------------------------------------------------------------

    always @(posedge sclk or negedge PRESETn or posedge receive_data) begin
        if (!PRESETn) begin
            count8 <= 4'd0;
            count9 <= 4'd7;
        end
        else if (receive_data) begin
            count8 <= 4'd0;
            count9 <= 4'd7;
        end
        else begin
            if (!ss) begin
                if (((!cpha) && (!cpol)) || (cpha && cpol)) begin
                    if (lsbfe) begin
                        if (count8 <= 4'd7) begin
                            temp_reg1[count8] <= miso;
                            count8 <= count8 + 1'b1;
                        end
                    end
                    else begin
                        if (count9 >= 4'd0) begin
                            temp_reg1[count9] <= miso;
                            count9 <= count9 - 1'b1;
                        end
                    end
                end
            end
        end
    end

    //--------------------------------------------------------------------------
    // MISO Sampling: CPHA = 1, CPOL = 0
    //              or CPHA = 0, CPOL = 1
    //--------------------------------------------------------------------------

    always @(negedge sclk or negedge PRESETn or posedge receive_data) begin
        if (!PRESETn) begin
            count10 <= 4'd0;
            count11 <= 4'd7;
        end
        else if (receive_data) begin
            count10 <= 4'd0;
            count11 <= 4'd7;
        end
        else begin
            if (!ss) begin
                if ((cpha && (!cpol)) || ((!cpha) && cpol)) begin
                    if (lsbfe) begin
                        if (count10 <= 4'd7) begin
                            temp_reg2[count10] <= miso;
                            count10 <= count10 + 1'b1;
                        end
                    end
                    else begin
                        if (count11 >= 4'd0) begin
                            temp_reg2[count11] <= miso;
                            count11 <= count11 - 1'b1;
                        end
                    end
                end
            end
        end
    end

endmodule
