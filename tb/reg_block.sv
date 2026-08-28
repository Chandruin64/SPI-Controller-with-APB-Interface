//=============================================================================
// RAL REGISTER BLOCK
//=============================================================================

class reg_block extends uvm_reg_block;

        `uvm_object_utils(reg_block)

        cr1_reg cr1;
        cr2_reg cr2;
        br_reg  br;
        dr_reg  dr;

        uvm_reg_map map;

        function new(string name = "reg_block");
                super.new(name, build_coverage(UVM_CVR_ADDR_MAP));
        endfunction

        function void build();

                //-------------------------------------------------------------------------
                // Create and configure registers
                //-------------------------------------------------------------------------

                cr1 = cr1_reg::type_id::create("cr1");
                cr1.configure(this, null, "");
                cr1.build();
                cr1.add_hdl_path_slice("SPI_CR_1", 0, 8);

                cr2 = cr2_reg::type_id::create("cr2");
                cr2.configure(this, null, "");
                cr2.build();
                cr2.add_hdl_path_slice("SPI_CR_2", 0, 8);

                br = br_reg::type_id::create("br");
                br.configure(this, null, "");
                br.build();
                br.add_hdl_path_slice("SPI_BR", 0, 8);

                dr = dr_reg::type_id::create("dr");
                dr.configure(this, null, "");
                dr.build();
                dr.add_hdl_path_slice("SPI_DR", 0, 8);

                //-------------------------------------------------------------------------
                // Create register map
                //-------------------------------------------------------------------------

                map = create_map(
                        "map",
                        'h0,
                        4,
                        UVM_LITTLE_ENDIAN
                );

                map.add_reg(cr1, 32'h0000_0000, "RW");
                map.add_reg(cr2, 32'h0000_0004, "RW");
                map.add_reg(br,  32'h0000_0008, "RW");
                map.add_reg(dr,  32'h0000_0014, "RW");

                //-------------------------------------------------------------------------
                // HDL path
                //-------------------------------------------------------------------------

                add_hdl_path("top.dut.core.APB_INTERFACE", "RTL");

                //-------------------------------------------------------------------------
                // Lock register model
                //-------------------------------------------------------------------------

                lock_model();

        endfunction

endclass
