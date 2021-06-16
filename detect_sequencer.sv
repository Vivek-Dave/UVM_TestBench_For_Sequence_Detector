class detect_sequencer extends uvm_sequencer#(detect_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(detect_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="detect_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:detect_sequencer

