class apb_monitor extends uvm_monitor;

  `uvm_component_utils(apb_monitor)

  uvm_analysis_port #(apb_xtn) monitor_port;

  virtual apb_intf.APB_MON_MP vif;
  apb_agent_config cfg;

  extern function new(
    string name = "apb_monitor",
    uvm_component parent
  );
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task collect();
  extern function void report_phase(uvm_phase phase);

endclass


function apb_monitor::new(
  string name = "apb_monitor",
  uvm_component parent
);
  super.new(name, parent);
  monitor_port = new("monitor_port", this);
endfunction


function void apb_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db #(apb_agent_config)::get(
        this, "*", "apb_agent_config", cfg))
    `uvm_fatal("APB_AGENT_CONFIG", "Failed to get APB agent configuration")
endfunction


function void apb_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = cfg.vif;
endfunction


task apb_monitor::run_phase(uvm_phase phase);

  forever
    collect();

endtask


task apb_monitor::collect();

  apb_xtn xtn;
  xtn = apb_xtn::type_id::create("xtn");

  // Capture a completed APB transfer.
  wait (vif.apb_mon_cb.PENABLE && vif.apb_mon_cb.PREADY);

  xtn.PRESETn = vif.apb_mon_cb.PRESETn;
  xtn.PWRITE  = vif.apb_mon_cb.PWRITE;
  xtn.PADDR   = vif.apb_mon_cb.PADDR;
  xtn.PSEL    = vif.apb_mon_cb.PSEL;
  xtn.PENABLE = vif.apb_mon_cb.PENABLE;

  if (vif.apb_mon_cb.PWRITE)
    xtn.PWDATA = vif.apb_mon_cb.PWDATA;

  xtn.PRDATA  = vif.apb_mon_cb.PRDATA;
  xtn.PREADY  = vif.apb_mon_cb.PREADY;
  xtn.PSLVERR = vif.apb_mon_cb.PSLVERR;

  `uvm_info(
    get_full_name(),
    $sformatf("Data collected from APB monitor:\n%s", xtn.sprint()),
    UVM_LOW
  )

  monitor_port.write(xtn);
  cfg.apb_mon_rcvd_data_count++;

  @(vif.apb_mon_cb);

endtask


function void apb_monitor::report_phase(uvm_phase phase);

  `uvm_info(
    get_full_name(),
    $sformatf(
      "APB MONITOR: Number of transactions received: %0d",
      cfg.apb_mon_rcvd_data_count
    ),
    UVM_LOW
  )

endfunction
