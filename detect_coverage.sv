
class detect_coverage extends uvm_subscriber #(detect_sequence_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(detect_coverage)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  detect_sequence_item txn;
  real cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup dut_cov;
    option.per_instance= 1;
    option.comment     = "dut_cov";
    option.name        = "dut_cov";
    option.auto_bin_max= 4;
    IN:coverpoint txn.in { 
        bins zero_0={0};
        bins one_1 ={1};
    }
    RST:coverpoint txn.rst { 
        bins rst_0 = {0};
        bins rst_1 = {1};
    }
  endgroup:dut_cov;
  //----------------------------------------------------------------------------

  //---------------------  write method ----------------------------------------
  function void write(detect_sequence_item t);
    txn=t;
    dut_cov.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=dut_cov.get_coverage();
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:detect_coverage

