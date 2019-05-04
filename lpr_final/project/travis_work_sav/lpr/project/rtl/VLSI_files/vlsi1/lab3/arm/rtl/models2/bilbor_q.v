//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbor_q(CLK,Q,QBAR);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_Q = 1,
        d_QBAR = 1;
  input  CLK;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  wire  CLK_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR_temp;
  supply1  VDD;
  supply0  GND;
  supply0 [(N - 1):0] GNDBUS;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_Q) Q = Q_temp;
  assign #(d_QBAR) QBAR = QBAR_temp;
  bilbo_generic #(N) inst1 (GND,VDD,CLK_temp,VDD,GNDBUS,VDD,GND,VDD,VDD,Q_temp,QBAR_temp);
endmodule
