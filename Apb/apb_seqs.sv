// =============================================================================
// APB Sequence Library
//
// Description:
//   Contains APB sequences for configuring the SPI controller through the
//   APB register interface. Separate sequences are provided to verify all
//   combinations of CPOL, CPHA and LSB-first configurations, along with
//   low-power, read and status-register access scenarios.
// =============================================================================


// =============================================================================
// Base APB Sequence
// =============================================================================

class apb_base_seqs extends uvm_sequence #(apb_xtn);

        `uvm_object_utils(apb_base_seqs)

        extern function new(string name = "apb_base_seqs");

endclass : apb_base_seqs


function apb_base_seqs::new(string name = "apb_base_seqs");
        super.new(name);
endfunction : new


// =============================================================================
// CPOL = 0, CPHA = 0, LSB First = 0
// =============================================================================

class apb_cpol0_cpha0_lsbfe0_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol0_cpha0_lsbfe0_seq)

        extern function new(string name = "apb_cpol0_cpha0_lsbfe0_seq");
        extern task body();

endclass : apb_cpol0_cpha0_lsbfe0_seq


function apb_cpol0_cpha0_lsbfe0_seq::new(
        string name = "apb_cpol0_cpha0_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task apb_cpol0_cpha0_lsbfe0_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // ---------------------------------------------------------
                // Configure SPI Control Register 1
                // CPOL = 0, CPHA = 0, LSB First = 0
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0101_0010;
                });
                finish_item(req);

                // ---------------------------------------------------------
                // Configure SPI Control Register 2
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // ---------------------------------------------------------
                // Configure SPI Baud Rate Register
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // ---------------------------------------------------------
                // Write data to SPI Data Register
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// CPOL = 0, CPHA = 1, LSB First = 0
// =============================================================================

class apb_cpol0_cpha1_lsbfe0_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol0_cpha1_lsbfe0_seq)

        extern function new(string name = "apb_cpol0_cpha1_lsbfe0_seq");
        extern task body();

endclass : apb_cpol0_cpha1_lsbfe0_seq


function apb_cpol0_cpha1_lsbfe0_seq::new(
        string name = "apb_cpol0_cpha1_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task apb_cpol0_cpha1_lsbfe0_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // Configure SPI Control Register 1
                // CPOL = 0, CPHA = 1, LSB First = 0
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0111_0110;
                });
                finish_item(req);

                // Configure SPI Control Register 2
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Configure SPI Baud Rate Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Write data to SPI Data Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// CPOL = 1, CPHA = 0, LSB First = 0
// =============================================================================

class apb_cpol1_cpha0_lsbfe0_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol1_cpha0_lsbfe0_seq)

        extern function new(string name = "apb_cpol1_cpha0_lsbfe0_seq");
        extern task body();

endclass : apb_cpol1_cpha0_lsbfe0_seq


function apb_cpol1_cpha0_lsbfe0_seq::new(
        string name = "apb_cpol1_cpha0_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task apb_cpol1_cpha0_lsbfe0_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // Configure SPI Control Register 1
                // CPOL = 1, CPHA = 0, LSB First = 0
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0111_1010;
                });
                finish_item(req);

                // Configure SPI Control Register 2
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Configure SPI Baud Rate Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Write data to SPI Data Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// CPOL = 1, CPHA = 1, LSB First = 0
// =============================================================================

class apb_cpol1_cpha1_lsbfe0_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol1_cpha1_lsbfe0_seq)

        extern function new(string name = "apb_cpol1_cpha1_lsbfe0_seq");
        extern task body();

endclass : apb_cpol1_cpha1_lsbfe0_seq


function apb_cpol1_cpha1_lsbfe0_seq::new(
        string name = "apb_cpol1_cpha1_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task apb_cpol1_cpha1_lsbfe0_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // Configure SPI Control Register 1
                // CPOL = 1, CPHA = 1, LSB First = 0
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0111_1110;
                });
                finish_item(req);

                // Configure SPI Control Register 2
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Configure SPI Baud Rate Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Write data to SPI Data Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// CPOL = 0, CPHA = 0, LSB First = 1
// =============================================================================

class apb_cpol0_cpha0_lsbfe1_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol0_cpha0_lsbfe1_seq)

        extern function new(string name = "apb_cpol0_cpha0_lsbfe1_seq");
        extern task body();

endclass : apb_cpol0_cpha0_lsbfe1_seq


function apb_cpol0_cpha0_lsbfe1_seq::new(
        string name = "apb_cpol0_cpha0_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task apb_cpol0_cpha0_lsbfe1_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // Configure SPI Control Register 1
                // CPOL = 0, CPHA = 0, LSB First = 1
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0111_0011;
                });
                finish_item(req);

                // Configure SPI Control Register 2
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Configure SPI Baud Rate Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Write data to SPI Data Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// CPOL = 0, CPHA = 1, LSB First = 1
// =============================================================================

class apb_cpol0_cpha1_lsbfe1_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol0_cpha1_lsbfe1_seq)

        extern function new(string name = "apb_cpol0_cpha1_lsbfe1_seq");
        extern task body();

endclass : apb_cpol0_cpha1_lsbfe1_seq


function apb_cpol0_cpha1_lsbfe1_seq::new(
        string name = "apb_cpol0_cpha1_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task apb_cpol0_cpha1_lsbfe1_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // Configure SPI Control Register 1
                // CPOL = 0, CPHA = 1, LSB First = 1
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0111_0111;
                });
                finish_item(req);

                // Configure SPI Control Register 2
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Configure SPI Baud Rate Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Write data to SPI Data Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// CPOL = 1, CPHA = 0, LSB First = 1
// =============================================================================

class apb_cpol1_cpha0_lsbfe1_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol1_cpha0_lsbfe1_seq)

        extern function new(string name = "apb_cpol1_cpha0_lsbfe1_seq");
        extern task body();

endclass : apb_cpol1_cpha0_lsbfe1_seq


function apb_cpol1_cpha0_lsbfe1_seq::new(
        string name = "apb_cpol1_cpha0_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task apb_cpol1_cpha0_lsbfe1_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // Configure SPI Control Register 1
                // CPOL = 1, CPHA = 0, LSB First = 1
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0111_1011;
                });
                finish_item(req);

                // Configure SPI Control Register 2
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Configure SPI Baud Rate Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Write data to SPI Data Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// CPOL = 1, CPHA = 1, LSB First = 1
// =============================================================================

class apb_cpol1_cpha1_lsbfe1_seq extends apb_base_seqs;

        `uvm_object_utils(apb_cpol1_cpha1_lsbfe1_seq)

        extern function new(string name = "apb_cpol1_cpha1_lsbfe1_seq");
        extern task body();

endclass : apb_cpol1_cpha1_lsbfe1_seq


function apb_cpol1_cpha1_lsbfe1_seq::new(
        string name = "apb_cpol1_cpha1_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task apb_cpol1_cpha1_lsbfe1_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // Configure SPI Control Register 1
                // CPOL = 1, CPHA = 1, LSB First = 1
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0111_1111;
                });
                finish_item(req);

                // Configure SPI Control Register 2
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Configure SPI Baud Rate Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // Write data to SPI Data Register
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// Low-Power Mode Sequence
// =============================================================================

class apb_low_power_seq extends apb_base_seqs;

        `uvm_object_utils(apb_low_power_seq)

        extern function new(string name = "apb_low_power_seq");
        extern task body();

endclass : apb_low_power_seq


function apb_low_power_seq::new(string name = "apb_low_power_seq");
        super.new(name);
endfunction : new


task apb_low_power_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // ---------------------------------------------------------
                // Configure Control Register 1 for low-power operation
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b0;
                        PWDATA  == 8'b0001_1110;
                });
                finish_item(req);

                // ---------------------------------------------------------
                // Configure Control Register 2
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'b1;
                        PWDATA  == 8'b0000_0010;
                });
                finish_item(req);

                // ---------------------------------------------------------
                // Configure Baud Rate Register
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd2;
                        PWDATA  == 8'b0000_0000;
                });
                finish_item(req);

                // ---------------------------------------------------------
                // Write data to SPI Data Register
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b1;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// APB Data Register Read Sequence
// =============================================================================

class apb_rd_seq extends apb_base_seqs;

        `uvm_object_utils(apb_rd_seq)

        extern function new(string name = "apb_rd_seq");
        extern task body();

endclass : apb_rd_seq


function apb_rd_seq::new(string name = "apb_rd_seq");
        super.new(name);
endfunction : new


task apb_rd_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // ---------------------------------------------------------
                // Read data from SPI Data Register
                // PWRITE = 0 indicates an APB read transaction
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b0;
                        PADDR   == 3'd5;
                });
                finish_item(req);

        end

endtask : body


// =============================================================================
// APB Status Register Read Sequence
// =============================================================================

class apb_status_seq extends apb_base_seqs;

        `uvm_object_utils(apb_status_seq)

        extern function new(string name = "apb_status_seq");
        extern task body();

endclass : apb_status_seq


function apb_status_seq::new(string name = "apb_status_seq");
        super.new(name);
endfunction : new


task apb_status_seq::body();

        repeat(1) begin

                req = apb_xtn::type_id::create("req");

                // ---------------------------------------------------------
                // Read SPI Status Register
                // PWRITE = 0 indicates an APB read transaction
                // ---------------------------------------------------------
                start_item(req);
                assert(req.randomize() with {
                        PRESETn == 1'b1;
                        PWRITE  == 1'b0;
                        PADDR   == 3'd3;
                });
                finish_item(req);

        end

endtask : body
