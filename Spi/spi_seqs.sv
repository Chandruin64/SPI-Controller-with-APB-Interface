
//=============================================================================
// SPI Base Sequence
//-----------------------------------------------------------------------------
// Common base class for all SPI mode-specific sequences.
//=============================================================================

class spi_base_seqs extends uvm_sequence#(spi_xtn);

        `uvm_object_utils(spi_base_seqs)

        extern function new(string name = "spi_base_seqs");

endclass : spi_base_seqs


function spi_base_seqs::new(string name = "spi_base_seqs");
        super.new(name);
endfunction : new


//=============================================================================
// SPI Mode 0 Sequence
//-----------------------------------------------------------------------------
// CPOL = 0, CPHA = 0, LSB First = 0 (MSB First)
// Generates SPI input data for Mode 0 operation.
//=============================================================================

class spi_cpol0_cpha0_lsbfe0_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol0_cpha0_lsbfe0_seq)

        extern function new(string name = "spi_cpol0_cpha0_lsbfe0_seq");
        extern task body();

endclass : spi_cpol0_cpha0_lsbfe0_seq


function spi_cpol0_cpha0_lsbfe0_seq::new(
        string name = "spi_cpol0_cpha0_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task spi_cpol0_cpha0_lsbfe0_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate constrained MISO data for SPI transfer.
                start_item(req);
                assert(req.randomize() with {
                        miso inside {[8'h00 : 8'h0F]};
                });
                finish_item(req);

        end

endtask : body


//=============================================================================
// SPI Mode 1 Sequence
//-----------------------------------------------------------------------------
// CPOL = 0, CPHA = 1, LSB First = 0 (MSB First)
// Generates randomized SPI input data for Mode 1 operation.
//=============================================================================

class spi_cpol0_cpha1_lsbfe0_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol0_cpha1_lsbfe0_seq)

        extern function new(string name = "spi_cpol0_cpha1_lsbfe0_seq");
        extern task body();

endclass : spi_cpol0_cpha1_lsbfe0_seq


function spi_cpol0_cpha1_lsbfe0_seq::new(
        string name = "spi_cpol0_cpha1_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task spi_cpol0_cpha1_lsbfe0_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate randomized MISO data for SPI Mode 1.
                start_item(req);
                assert(req.randomize());
                finish_item(req);

        end

endtask : body


//=============================================================================
// SPI Mode 2 Sequence
//-----------------------------------------------------------------------------
// CPOL = 1, CPHA = 0, LSB First = 0 (MSB First)
// Generates randomized SPI input data for Mode 2 operation.
//=============================================================================

class spi_cpol1_cpha0_lsbfe0_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol1_cpha0_lsbfe0_seq)

        extern function new(string name = "spi_cpol1_cpha0_lsbfe0_seq");
        extern task body();

endclass : spi_cpol1_cpha0_lsbfe0_seq


function spi_cpol1_cpha0_lsbfe0_seq::new(
        string name = "spi_cpol1_cpha0_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task spi_cpol1_cpha0_lsbfe0_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate randomized MISO data for SPI Mode 2.
                start_item(req);
                assert(req.randomize());
                finish_item(req);

        end

endtask : body


//=============================================================================
// SPI Mode 3 Sequence
//-----------------------------------------------------------------------------
// CPOL = 1, CPHA = 1, LSB First = 0 (MSB First)
// Generates randomized SPI input data for Mode 3 operation.
//=============================================================================

class spi_cpol1_cpha1_lsbfe0_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol1_cpha1_lsbfe0_seq)

        extern function new(string name = "spi_cpol1_cpha1_lsbfe0_seq");
        extern task body();

endclass : spi_cpol1_cpha1_lsbfe0_seq


function spi_cpol1_cpha1_lsbfe0_seq::new(
        string name = "spi_cpol1_cpha1_lsbfe0_seq"
);
        super.new(name);
endfunction : new


task spi_cpol1_cpha1_lsbfe0_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate randomized MISO data for SPI Mode 3.
                start_item(req);
                assert(req.randomize());
                finish_item(req);

        end

endtask : body


//=============================================================================
// SPI Mode 0 - LSB First Sequence
//-----------------------------------------------------------------------------
// CPOL = 0, CPHA = 0, LSB First = 1
// Generates randomized SPI input data for LSB-first transmission.
//=============================================================================

class spi_cpol0_cpha0_lsbfe1_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol0_cpha0_lsbfe1_seq)

        extern function new(string name = "spi_cpol0_cpha0_lsbfe1_seq");
        extern task body();

endclass : spi_cpol0_cpha0_lsbfe1_seq


function spi_cpol0_cpha0_lsbfe1_seq::new(
        string name = "spi_cpol0_cpha0_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task spi_cpol0_cpha0_lsbfe1_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate randomized MISO data for LSB-first Mode 0.
                start_item(req);
                assert(req.randomize());
                finish_item(req);

        end

endtask : body


//=============================================================================
// SPI Mode 1 - LSB First Sequence
//-----------------------------------------------------------------------------
// CPOL = 0, CPHA = 1, LSB First = 1
// Generates randomized SPI input data for LSB-first transmission.
//=============================================================================

class spi_cpol0_cpha1_lsbfe1_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol0_cpha1_lsbfe1_seq)

        extern function new(string name = "spi_cpol0_cpha1_lsbfe1_seq");
        extern task body();

endclass : spi_cpol0_cpha1_lsbfe1_seq


function spi_cpol0_cpha1_lsbfe1_seq::new(
        string name = "spi_cpol0_cpha1_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task spi_cpol0_cpha1_lsbfe1_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate randomized MISO data for LSB-first Mode 1.
                start_item(req);
                assert(req.randomize());
                finish_item(req);

        end

endtask : body


//=============================================================================
// SPI Mode 2 - LSB First Sequence
//-----------------------------------------------------------------------------
// CPOL = 1, CPHA = 0, LSB First = 1
// Generates randomized SPI input data for LSB-first transmission.
//=============================================================================

class spi_cpol1_cpha0_lsbfe1_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol1_cpha0_lsbfe1_seq)

        extern function new(string name = "spi_cpol1_cpha0_lsbfe1_seq");
        extern task body();

endclass : spi_cpol1_cpha0_lsbfe1_seq


function spi_cpol1_cpha0_lsbfe1_seq::new(
        string name = "spi_cpol1_cpha0_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task spi_cpol1_cpha0_lsbfe1_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate randomized MISO data for LSB-first Mode 2.
                start_item(req);
                assert(req.randomize());
                finish_item(req);

        end

endtask : body


//=============================================================================
// SPI Mode 3 - LSB First Sequence
//-----------------------------------------------------------------------------
// CPOL = 1, CPHA = 1, LSB First = 1
// Generates randomized SPI input data for LSB-first transmission.
//=============================================================================

class spi_cpol1_cpha1_lsbfe1_seq extends spi_base_seqs;

        `uvm_object_utils(spi_cpol1_cpha1_lsbfe1_seq)

        extern function new(string name = "spi_cpol1_cpha1_lsbfe1_seq");
        extern task body();

endclass : spi_cpol1_cpha1_lsbfe1_seq


function spi_cpol1_cpha1_lsbfe1_seq::new(
        string name = "spi_cpol1_cpha1_lsbfe1_seq"
);
        super.new(name);
endfunction : new


task spi_cpol1_cpha1_lsbfe1_seq::body();

        repeat(1) begin

                req = spi_xtn::type_id::create("req");

                // Generate randomized MISO data for LSB-first Mode 3.
                start_item(req);
                assert(req.randomize());
                finish_item(req);

        end

endtask : body
