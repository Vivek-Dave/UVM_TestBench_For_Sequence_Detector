
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class detect_scoreboard extends uvm_scoreboard;
  //----------------------------------------------------------------------------
  `uvm_component_utils(detect_scoreboard)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_analysis_imp_drv #(detect_sequence_item, detect_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(detect_sequence_item, detect_scoreboard) aport_mon;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_tlm_fifo #(detect_sequence_item) expfifo;
  uvm_tlm_fifo #(detect_sequence_item) outfifo;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  logic t_in;
  logic t_out,temp_out;
  logic t_rst;
  logic [3:0] comp,temp;
  logic [3:0] val=4'b1001;
  int unsigned count=0;
  bit q[$]={0,0};

  function new(string name="detect_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------  
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
  endfunction
  //----------------------------------------------------------------------------
  int i;
  //----------------------------------------------------------------------------
  function void write_drv(detect_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    //write scoreboard code here
    t_in = tr.in;
    t_rst = tr.rst;
    temp_out = t_out;

    if(t_rst == 1) begin  
      	comp  = 0;
        t_out = 0;
        count = 0;
        q     = {0,0};
        i     = 1;
    end
    else begin 
    	comp  = {comp[2:0],t_in};
    	t_out = (val==comp)?1:0;
    end
    q.push_back(t_out);
    tr.out = q[i-1];
    i++;
    void'(expfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_mon(detect_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
	detect_sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
      if (out_tr.out===exp_tr.out && count>1) begin
            PASS();
        `uvm_info ("\n [ PASS ",out_tr.convert2string() , UVM_MEDIUM)
		end
      
      else if (out_tr.out!==exp_tr.out && count>1) begin
	   	  ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
		end
      count++;
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction
  //----------------------------------------------------------------------------

endclass

