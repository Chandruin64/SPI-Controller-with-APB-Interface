class apb_xtn extends uvm_sequence_item;

  `uvm_object_utils(apb_xtn)

  rand bit       PRESETn;
  rand bit       PWRITE;
       bit       PSEL;
       bit       PENABLE;
  rand bit [2:0] PADDR;
  rand bit [7:0] PWDATA;
       bit [7:0] PRDATA;
       bit       PREADY;
       bit       PSLVERR;

  function new(string name = "apb_xtn");
    super.new(name);
  endfunction

  // Restrict addresses based on read/write operation.
  constraint c1 {
    if (PWRITE)
      PADDR inside {[0:2], 5};
    else
      PADDR inside {[0:3], 5};
  }

  // Bias reset towards the inactive state.
  constraint c2 {
    PRESETn dist {0 := 1, 1 := 99};
  }

  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("PRESETn", PRESETn, 1, UVM_BIN);
    printer.print_field("PWRITE",  PWRITE,  1, UVM_BIN);
    printer.print_field("PSEL",    PSEL,    1, UVM_BIN);
    printer.print_field("PENABLE", PENABLE, 1, UVM_BIN);
    printer.print_field("PADDR",   PADDR,   3, UVM_BIN);
    printer.print_field("PWDATA",  PWDATA,  8, UVM_BIN);
    printer.print_field("PRDATA",  PRDATA,  8, UVM_BIN);
    printer.print_field("PREADY",  PREADY,  1, UVM_BIN);
    printer.print_field("PSLVERR", PSLVERR, 1, UVM_BIN);
  endfunction

endclass
