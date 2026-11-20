`include "uvm_macros.svh"
import uvm_pkg::*;
 
module fpu_assertions
(
    input bit clk ;
   	input bit rst_n;
    input bit ena;

    input bit [7:0]ui_in;
    input bit [7:0]uio_in;
    ///////////////output
    input bit [7:0]uo_out;
    input bit [7:0]uio_out;
    input bit [7:0]uio_oe;
);
 

    // when data is stored in reg (wr_ptr =3 to 0) ready is asserted
    property ready;
        @(posedge clk) disable iff(!rst_n)
       ($past(uo_out[7:4]) == 4'd3 && uo_out[7:4] == 4'd0)|-> (uo_out[3]== 1);
    endproperty

    assert property(ready)
     else
    $error("READY CHECK FAILED");

    // next cycle of start pulse busy should assert
    property busy_assert;
       @(posedge clk) disable iff(!rst_n)
       ($rose(ui_in[2]) && uo_out[3] && !uo_out[0])|=>  ## 1 uo_out[0];
    endproperty

    assert property(busy_assert)
    else 
    $error("BUSY ASSERT CHECK FAILED"); 

   // busy and done should not assert  together  
 
property busy_done;
    @(posedge clk) disable iff(!rst_n)
    !(uo_out[0] && uo_out[1]);
     endproperty

    assert property(busy_done)
    else 
    $error("%0t :BUSY AND DONE ASSERTED AT SAME TIME",$time);


   //Done should remain high until another valid start or reset
property done_hold_check;
    @(posedge clk) disable iff(!rst_n)
    uo_out[1] |-> (uo_out[1] throughout (!$rose(ui_in[2]) || !uo_out[3] || !uo_out[0]));
endproperty
      endmodule

    assert property(done_hold_check)
    else
   $error("DONE HOLD CHECK FAILED");
    
