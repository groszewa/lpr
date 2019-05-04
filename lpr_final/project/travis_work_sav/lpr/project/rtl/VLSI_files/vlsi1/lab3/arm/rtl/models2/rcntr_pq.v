//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module rcntr_pq(CLK,PRE,Q,QBAR);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q = 1,
        d_QBAR = 1;
  input  CLK;
  input  PRE;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  wire  CLK_temp;
  wire  PRE_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_Q) Q = Q_temp;
  assign #(d_QBAR) QBAR = QBAR_temp;
  rcntr_generic #(N) inst1 (CLK_temp,PRE_temp,VDD,GND,GND,GND,Q_temp,QBAR_temp);
endmodule
