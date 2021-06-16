
/***************************************************
** class name  : detect_sequence
** description : gives valid input to dut
***************************************************/
class detect_sequence extends uvm_sequence#(detect_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(detect_sequence)            
  //----------------------------------------------------------------------------

  detect_sequence_item txn;
  int unsigned LOOP = 20;

  //----------------------------------------------------------------------------
  function new(string name="detect_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    txn=detect_sequence_item::type_id::create("txn");
    for(int i=0;i<LOOP;i++) begin
      if(i<LOOP/2) begin 
    	start_item(txn);
      	txn.randomize()with{txn.in==1;};
    	txn.rst=0;
    	finish_item(txn);
      end
      else begin 
    	start_item(txn);
        txn.randomize()with{txn.in==0;};
    	txn.rst=0;
    	finish_item(txn);
      end
    end
  endtask:body
  //----------------------------------------------------------------------------
 // task one(detect_sequence_item txn);
 //   start_item(txn);
 //   txn.randomize()with(txn.in==1;);
 //   txn.rst=0;
 //   finish_item(txn);
 // endtask

 // task zero(detect_sequence_item txn);
 //   start_item(txn);
 //   txn.randomize()with(txn.in==0;);
 //   txn.rst=0;
 //   finish_item(txn);
  //endtask
endclass:detect_sequence

/***************************************************
** class name  : reset_sequence
** description : reset dut
***************************************************/
class reset_sequence extends detect_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(reset_sequence)      
  //----------------------------------------------------------------------------
  
  detect_sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="reset_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=detect_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.in=0;
    txn.rst=1;
    finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : random_sequence
** description : generate random input
***************************************************/
class random_sequence extends detect_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(random_sequence)      
  //----------------------------------------------------------------------------
  
  detect_sequence_item txn;
  int LOOP = 30;
  
  //----------------------------------------------------------------------------
  function new(string name="random_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(LOOP) begin 
      txn=detect_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize();
      txn.rst=0;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass