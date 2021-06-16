
class detect_agent extends uvm_agent;

  //----------------------------------------------------------------------------
  `uvm_component_utils(detect_agent)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="detect_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //----------------- class handles --------------------------------------------
  detect_sequencer sequencer_h;
  detect_driver    driver_h;
  detect_monitor   monitor_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver_h    = detect_driver::type_id::create("driver_h",this);
    sequencer_h = detect_sequencer::type_id::create("sequencer_h",this);
    monitor_h   = detect_monitor::type_id::create("monitor_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------- connect phase --------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
  endfunction
  //----------------------------------------------------------------------------

endclass:detect_agent

