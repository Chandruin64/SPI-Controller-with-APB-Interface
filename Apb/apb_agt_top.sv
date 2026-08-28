class apb_agt_top extends uvm_component;

  `uvm_component_utils(apb_agt_top)

  apb_agent agent;

  extern function new(
    string name = "apb_agt_top",
    uvm_component parent
  );
  extern function void build_phase(uvm_phase phase);

endclass


function apb_agt_top::new(
  string name = "apb_agt_top",
  uvm_component parent
);
  super.new(name, parent);
endfunction


function void apb_agt_top::build_phase(uvm_phase phase);

  super.build_phase(phase);

  agent = apb_agent::type_id::create("apb_agent", this);

endfunction
