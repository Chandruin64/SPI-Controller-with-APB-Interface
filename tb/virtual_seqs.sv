//==============================================================================
// Base Virtual Sequence
//==============================================================================

class virtual_seqs extends uvm_sequence#(uvm_sequence_item);

        `uvm_object_utils(virtual_seqs)

        virtual_sequencer vseqr;
        spi_sequencer     spi_seqr;
        apb_sequencer     apb_seqr;

        function new (string name = "virtual_seqs");
                super.new(name);
        endfunction

        // Get handles of APB and SPI sequencers from the virtual sequencer
        task body();
                if(!$cast(vseqr,m_sequencer))
                        `uvm_fatal("VIRTUAL SEQUENCER CASTING","FAILED")

                apb_seqr = vseqr.apb_seqr;
                spi_seqr = vseqr.spi_seqr;
        endtask

endclass: virtual_seqs


//==============================================================================
// APB Virtual Sequences - SPI Mode Configuration
//==============================================================================

//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 0, LSB First = 0
//------------------------------------------------------------------------------

class apb_cpol0_cpha0_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol0_cpha0_lsbfe0_vseq)

        apb_cpol0_cpha0_lsbfe0_seq seq;

        function new (string name = "apb_cpol0_cpha0_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol0_cpha0_lsbfe0_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 1, LSB First = 0
//------------------------------------------------------------------------------

class apb_cpol0_cpha1_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol0_cpha1_lsbfe0_vseq)

        apb_cpol0_cpha1_lsbfe0_seq seq;

        function new (string name = "apb_cpol0_cpha1_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol0_cpha1_lsbfe0_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 0, LSB First = 0
//------------------------------------------------------------------------------

class apb_cpol1_cpha0_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol1_cpha0_lsbfe0_vseq)

        apb_cpol1_cpha0_lsbfe0_seq seq;

        function new (string name = "apb_cpol1_cpha0_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol1_cpha0_lsbfe0_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 1, LSB First = 0
//------------------------------------------------------------------------------

class apb_cpol1_cpha1_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol1_cpha1_lsbfe0_vseq)

        apb_cpol1_cpha1_lsbfe0_seq seq;

        function new (string name = "apb_cpol1_cpha1_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol1_cpha1_lsbfe0_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 0, LSB First = 1
//------------------------------------------------------------------------------

class apb_cpol0_cpha0_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol0_cpha0_lsbfe1_vseq)

        apb_cpol0_cpha0_lsbfe1_seq seq;

        function new (string name = "apb_cpol0_cpha0_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol0_cpha0_lsbfe1_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 1, LSB First = 1
//------------------------------------------------------------------------------

class apb_cpol0_cpha1_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol0_cpha1_lsbfe1_vseq)

        apb_cpol0_cpha1_lsbfe1_seq seq;

        function new (string name = "apb_cpol0_cpha1_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol0_cpha1_lsbfe1_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 0, LSB First = 1
//------------------------------------------------------------------------------

class apb_cpol1_cpha0_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol1_cpha0_lsbfe1_vseq)

        apb_cpol1_cpha0_lsbfe1_seq seq;

        function new (string name = "apb_cpol1_cpha0_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol1_cpha0_lsbfe1_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 1, LSB First = 1
//------------------------------------------------------------------------------

class apb_cpol1_cpha1_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(apb_cpol1_cpha1_lsbfe1_vseq)

        apb_cpol1_cpha1_lsbfe1_seq seq;

        function new (string name = "apb_cpol1_cpha1_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_cpol1_cpha1_lsbfe1_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//==============================================================================
// APB Virtual Sequences - Special Test Cases
//==============================================================================

//------------------------------------------------------------------------------
// Low Power Mode Sequence
//------------------------------------------------------------------------------

class apb_low_power_vseq extends virtual_seqs;

        `uvm_object_utils(apb_low_power_vseq)

        apb_low_power_seq seq;

        function new (string name = "apb_low_power_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_low_power_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// APB Read Sequence
//------------------------------------------------------------------------------

class apb_rd_vseq extends virtual_seqs;

        `uvm_object_utils(apb_rd_vseq)

        apb_rd_seq seq;

        function new (string name = "apb_rd_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_rd_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// APB Status Register Read Sequence
//------------------------------------------------------------------------------

class apb_status_vseq extends virtual_seqs;

        `uvm_object_utils(apb_status_vseq)

        apb_status_seq seq;

        function new (string name = "apb_status_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = apb_status_seq::type_id::create("seq");
                seq.start(apb_seqr);
        endtask

endclass


//==============================================================================
// SPI Virtual Sequences
//==============================================================================

//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 0, LSB First = 0
//------------------------------------------------------------------------------

class spi_cpol0_cpha0_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol0_cpha0_lsbfe0_vseq)

        spi_cpol0_cpha0_lsbfe0_seq seq;

        function new (string name = "spi_cpol0_cpha0_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol0_cpha0_lsbfe0_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 1, LSB First = 0
//------------------------------------------------------------------------------

class spi_cpol0_cpha1_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol0_cpha1_lsbfe0_vseq)

        spi_cpol0_cpha1_lsbfe0_seq seq;

        function new (string name = "spi_cpol0_cpha1_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol0_cpha1_lsbfe0_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 0, LSB First = 0
//------------------------------------------------------------------------------

class spi_cpol1_cpha0_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol1_cpha0_lsbfe0_vseq)

        spi_cpol1_cpha0_lsbfe0_seq seq;

        function new (string name = "spi_cpol1_cpha0_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol1_cpha0_lsbfe0_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 1, LSB First = 0
//------------------------------------------------------------------------------

class spi_cpol1_cpha1_lsbfe0_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol1_cpha1_lsbfe0_vseq)

        spi_cpol1_cpha1_lsbfe0_seq seq;

        function new (string name = "spi_cpol1_cpha1_lsbfe0_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol1_cpha1_lsbfe0_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 0, LSB First = 1
//------------------------------------------------------------------------------

class spi_cpol0_cpha0_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol0_cpha0_lsbfe1_vseq)

        spi_cpol0_cpha0_lsbfe1_seq seq;

        function new (string name = "spi_cpol0_cpha0_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol0_cpha0_lsbfe1_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 0, CPHA = 1, LSB First = 1
//------------------------------------------------------------------------------

class spi_cpol0_cpha1_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol0_cpha1_lsbfe1_vseq)

        spi_cpol0_cpha1_lsbfe1_seq seq;

        function new (string name = "spi_cpol0_cpha1_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol0_cpha1_lsbfe1_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 0, LSB First = 1
//------------------------------------------------------------------------------

class spi_cpol1_cpha0_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol1_cpha0_lsbfe1_vseq)

        spi_cpol1_cpha0_lsbfe1_seq seq;

        function new (string name = "spi_cpol1_cpha0_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol1_cpha0_lsbfe1_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass


//------------------------------------------------------------------------------
// CPOL = 1, CPHA = 1, LSB First = 1
//------------------------------------------------------------------------------

class spi_cpol1_cpha1_lsbfe1_vseq extends virtual_seqs;

        `uvm_object_utils(spi_cpol1_cpha1_lsbfe1_vseq)

        spi_cpol1_cpha1_lsbfe1_seq seq;

        function new (string name = "spi_cpol1_cpha1_lsbfe1_vseq");
                super.new(name);
        endfunction

        task body();
                super.body();

                seq = spi_cpol1_cpha1_lsbfe1_seq::type_id::create("seq");
                seq.start(spi_seqr);
        endtask

endclass
