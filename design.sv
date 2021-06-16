module detect(in,clk,rst,out);
  input clk;
  input rst;
  input in;
  output reg out;
  reg [3:0] temp;
  parameter MATCH=4'b1001;
  
  always@(posedge clk or posedge rst)
    begin 
      if(rst==1)
        begin 
          temp<=0;
          out <=0;
        end
      else begin 
        temp<={temp[2:0],in};
        out <=(temp==MATCH)?1:0;
      end
    end
  
 
  
endmodule