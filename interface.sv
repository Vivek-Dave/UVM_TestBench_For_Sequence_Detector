
interface intf(input bit clk);
    // ------------------- port declaration-------------------------------------
    logic  in;
    logic rst;
    logic out;
    //--------------------------------------------------------------------------

    //------------- clocking & modport declaration -----------------------------
 /// clocking cb @(posedge clk);
  //    default input #2 output #1step;
  //    output in,rst; //input of DUT
  //    input  out;    //output of DUT
  //  endclocking
    //--------------------------------------------------------------------------
        
endinterface

