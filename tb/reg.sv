//=============================================================================
// RAL REGISTER MODEL
//=============================================================================

class cr1_reg extends uvm_reg;

        `uvm_object_utils(cr1_reg)

        rand uvm_reg_field LSBFE;
        rand uvm_reg_field SSOE;
        rand uvm_reg_field CPHA;
        rand uvm_reg_field CPOL;
        rand uvm_reg_field MSTR;
        rand uvm_reg_field SPTIE;
        rand uvm_reg_field SPE;
        rand uvm_reg_field SPIE;

        function new(string name = "cr1_reg");
                super.new(name, 8, UVM_NO_COVERAGE);
        endfunction

        function void build();

                LSBFE = uvm_reg_field::type_id::create("LSBFE");
                SSOE  = uvm_reg_field::type_id::create("SSOE");
                CPHA  = uvm_reg_field::type_id::create("CPHA");
                CPOL  = uvm_reg_field::type_id::create("CPOL");
                MSTR  = uvm_reg_field::type_id::create("MSTR");
                SPTIE = uvm_reg_field::type_id::create("SPTIE");
                SPE   = uvm_reg_field::type_id::create("SPE");
                SPIE  = uvm_reg_field::type_id::create("SPIE");

                LSBFE.configure(this, 1, 0, "RW", 0, 0, 0, 1, 1);
                SSOE.configure (this, 1, 1, "RW", 0, 0, 0, 1, 1);
                CPHA.configure (this, 1, 2, "RW", 0, 1, 0, 1, 1);
                CPOL.configure (this, 1, 3, "RW", 0, 0, 0, 1, 1);
                MSTR.configure (this, 1, 4, "RW", 0, 0, 0, 1, 1);
                SPTIE.configure(this, 1, 5, "RW", 0, 0, 0, 1, 1);
                SPE.configure  (this, 1, 6, "RW", 0, 0, 0, 1, 1);
                SPIE.configure (this, 1, 7, "RW", 0, 0, 0, 1, 1);

        endfunction

endclass


//-----------------------------------------------------------------------------
// CR2 Register
//-----------------------------------------------------------------------------

class cr2_reg extends uvm_reg;

        `uvm_object_utils(cr2_reg)

        rand uvm_reg_field SPC0;
        rand uvm_reg_field SPISWAI;
        rand uvm_reg_field BIDIROE;
        rand uvm_reg_field MODFEN;

        function new(string name = "cr2_reg");
                super.new(name, 8, UVM_NO_COVERAGE);
        endfunction

        function void build();

                SPC0    = uvm_reg_field::type_id::create("SPC0");
                SPISWAI = uvm_reg_field::type_id::create("SPISWAI");
                BIDIROE = uvm_reg_field::type_id::create("BIDIROE");
                MODFEN  = uvm_reg_field::type_id::create("MODFEN");

                SPC0.configure   (this, 1, 0, "RW", 0, 0, 0, 1, 1);
                SPISWAI.configure(this, 1, 1, "RW", 0, 0, 0, 1, 1);
                BIDIROE.configure(this, 1, 3, "RW", 0, 0, 0, 1, 1);
                MODFEN.configure (this, 1, 4, "RW", 0, 0, 0, 1, 1);

        endfunction

endclass


//-----------------------------------------------------------------------------
// Baud Rate Register
//-----------------------------------------------------------------------------

class br_reg extends uvm_reg;

        `uvm_object_utils(br_reg)

        rand uvm_reg_field SPR0;
        rand uvm_reg_field SPR1;
        rand uvm_reg_field SPR2;
        rand uvm_reg_field SPPR0;
        rand uvm_reg_field SPPR1;
        rand uvm_reg_field SPPR2;

        function new(string name = "br_reg");
                super.new(name, 8, UVM_NO_COVERAGE);
        endfunction

        function void build();

                SPR0  = uvm_reg_field::type_id::create("SPR0");
                SPR1  = uvm_reg_field::type_id::create("SPR1");
                SPR2  = uvm_reg_field::type_id::create("SPR2");
                SPPR0 = uvm_reg_field::type_id::create("SPPR0");
                SPPR1 = uvm_reg_field::type_id::create("SPPR1");
                SPPR2 = uvm_reg_field::type_id::create("SPPR2");

                SPR0.configure (this, 1, 0, "RW", 0, 0, 0, 1, 1);
                SPR1.configure (this, 1, 1, "RW", 0, 0, 0, 1, 1);
                SPR2.configure (this, 1, 2, "RW", 0, 0, 0, 1, 1);
                SPPR0.configure(this, 1, 4, "RW", 0, 0, 0, 1, 1);
                SPPR1.configure(this, 1, 5, "RW", 0, 0, 0, 1, 1);
                SPPR2.configure(this, 1, 6, "RW", 0, 0, 0, 1, 1);

        endfunction

endclass


//-----------------------------------------------------------------------------
// Status Register
//-----------------------------------------------------------------------------

class sr_reg extends uvm_reg;

        `uvm_object_utils(sr_reg)

        rand uvm_reg_field SPIF;
        rand uvm_reg_field SPTEF;
        rand uvm_reg_field MODF;

        function new(string name = "sr_reg");
                super.new(name, 8, UVM_NO_COVERAGE);
        endfunction

        function void build();

                SPIF  = uvm_reg_field::type_id::create("SPIF");
                SPTEF = uvm_reg_field::type_id::create("SPTEF");
                MODF  = uvm_reg_field::type_id::create("MODF");

                MODF.configure (this, 1, 4, "RO", 0, 0, 0, 1, 1);
                SPTEF.configure(this, 1, 5, "RO", 0, 1, 0, 1, 1);
                SPIF.configure (this, 1, 7, "RO", 0, 0, 0, 1, 1);

        endfunction

endclass


//-----------------------------------------------------------------------------
// Data Register
//-----------------------------------------------------------------------------

class dr_reg extends uvm_reg;

        `uvm_object_utils(dr_reg)

        rand uvm_reg_field DATA;

        function new(string name = "dr_reg");
                super.new(name, 8, UVM_NO_COVERAGE);
        endfunction

        function void build();

                DATA = uvm_reg_field::type_id::create("DATA");
                DATA.configure(this, 8, 0, "RW", 0, 0, 0, 1, 1);

        endfunction

endclass
