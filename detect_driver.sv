
class detect_driver extends uvm_driver #(detect_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(detect_driver)
  //----------------------------------------------------------------------------

  uvm_analysis_port #(detect_sequence_item) drv2sb;

  //----------------------------------------------------------------------------
  function new(string name="detect_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
    drv2sb=new("drv2sb",this);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    detect_sequence_item txn=detect_sequence_item::type_id::create("txn");
    initilize(); // initilize dut at time 0
    forever begin
      seq_item_port.get_next_item(txn);
      drive_item(txn);
      drv2sb.write(txn);
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task initilize();
    vif.in  = 0;
    vif.rst = 0;
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task drive_item(detect_sequence_item txn);
    @(posedge vif.clk);
    vif.in  = txn.in;
    vif.rst = txn.rst;
  endtask
  //----------------------------------------------------------------------------
endclass:detect_driver

