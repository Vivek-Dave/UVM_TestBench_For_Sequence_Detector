
class detect_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(detect_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="detect_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  detect_sequence_item  txn;
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(detect_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    detect_sequence_item txn=detect_sequence_item::type_id::create("txn");
    forever
    begin
      sample_dut(txn); 
      ap_mon.write(txn);
    end
  endtask
  //----------------------------------------------------------------------------

  task sample_dut(output detect_sequence_item txn);
    detect_sequence_item t = detect_sequence_item::type_id::create("t");
    @(posedge vif.clk);
    #1;
    t.in  = vif.in;
    t.rst = vif.rst;
    t.out = vif.out;
    txn   = t;
  endtask

endclass:detect_monitor

