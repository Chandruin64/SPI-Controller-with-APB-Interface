class apb_driver extends uvm_driver #(apb_xtn);

  `uvm_component_utils(apb_driver)

  virtual apb_intf.APB_DRV_MP vif;
  apb_agent_config cfg;

  extern function new(
    string name = "apb_driver",
    uvm_component parent
  );
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task drive(apb_xtn xtn);
  extern function void report_phase(uvm_phase phase);

endclass


function apb_driver::new(
  string name = "apb_driver",
  uvm_component parent
);
  super.new(name, parent);
endfunction


function void apb_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db #(apb_agent_config)::get(
        this, "*", "apb_agent_config", cfg))
    `uvm_fatal("APB_AGENT_CONFIG", "Failed to get APB agent configuration")
endfunction


function void apb_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = cfg.vif;
endfunction


task apb_driver::run_phase(uvm_phase phase);

  // Apply reset before starting APB transactions.
  @(vif.apb_drv_cb);
  vif.apb_drv_cb.PRESETn <= 1'b0;

  repeat (3)
    @(vif.apb_drv_cb);

  vif.apb_drv_cb.PRESETn <= 1'b1;

  forever begin
    seq_item_port.get_next_item(req);
    drive(req);
    seq_item_port.item_done();
  end

endtask


task apb_driver::drive(apb_xtn xtn);

  // APB Setup phase.
  @(vif.apb_drv_cb);
  vif.apb_drv_cb.PRESETn <= xtn.PRESETn;
  vif.apb_drv_cb.PSEL    <= 1'b1;
  vif.apb_drv_cb.PENABLE <= 1'b0;
  vif.apb_drv_cb.PADDR   <= xtn.PADDR;
  vif.apb_drv_cb.PWRITE  <= xtn.PWRITE;

  if (xtn.PWRITE)
    vif.apb_drv_cb.PWDATA <= xtn.PWDATA;

  // APB Access phase.
  @(vif.apb_drv_cb);
  vif.apb_drv_cb.PENABLE <= 1'b1;

  wait (vif.apb_drv_cb.PREADY);

  if (!xtn.PWRITE)
    xtn.PRDATA = vif.apb_drv_cb.PRDATA;

  // End the APB transfer.
  vif.apb_drv_cb.PSEL    <= 1'b0;
  vif.apb_drv_cb.PENABLE <= 1'b0;

  `uvm_info(
    get_full_name(),
    $sformatf("Data sent from APB driver:\n%s", xtn.sprint()),
    UVM_LOW
  )

  cfg.apb_drv_send_data_count++;

endtask


function void apb_driver::report_phase(uvm_phase phase);

  `uvm_info(
    get_full_name(),
    $sformatf(
      "APB DRIVER: Number of transactions sent: %0d",
      cfg.apb_drv_send_data_count
    ),
    UVM_LOW
  )

endfunction
