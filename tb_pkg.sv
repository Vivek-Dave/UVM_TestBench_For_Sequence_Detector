
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "detect_sequence_item.sv"        // transaction class
 `include "detect_sequence.sv"             // sequence class
 `include "detect_sequencer.sv"            // sequencer class
 `include "detect_driver.sv"               // driver class
 `include "detect_monitor.sv"              // monitor class
 `include "detect_agent.sv"                // agent class  
 `include "detect_coverage.sv"             // coverage class
 `include "detect_scoreboard.sv"           // scoreboard class
 `include "detect_env.sv"                  // environment class

 `include "detect_test.sv"                         // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


