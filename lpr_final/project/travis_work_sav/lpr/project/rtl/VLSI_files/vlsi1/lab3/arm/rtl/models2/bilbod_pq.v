//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbod_pq(CLK,D,PRE,Q,QBAR);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q = 1,
        d_QBAR = 1;
  input  CLK;
  input [(N - 1):0] D;
  input  PRE;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  wire  CLK_temp;
  wire [(N - 1):0] D_temp;
  wire  PRE_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR_temp;
  supply1  VDD;
  supply0  GND;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_D) D_temp = D|D;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_Q) Q = Q_temp;
  assign #(d_QBAR) QBAR = QBAR_temp;
  bilbo_generic #(N) inst1 (VDD,VDD,CLK_temp,VDD,D_temp,PRE_temp,GND,VDD,VDD,Q_temp,QBAR_temp);
  specify
    specparam
      t_width_PRE = 0;
    $width(negedge PRE , t_width_PRE);
  endspecify
endmodule
