//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbok_pq(C1,C2,CLK,D,PRE,Q,QBAR);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_C1_r = 0,
        d_C1_f = 0,
        d_C2_r = 0,
        d_C2_f = 0,
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q = 1,
        d_QBAR = 1;
  input  C1;
  input  C2;
  input  CLK;
  input [(N - 1):0] D;
  input  PRE;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  wire  C1_temp;
  wire  C2_temp;
  wire  CLK_temp;
  wire [(N - 1):0] D_temp;
  wire  PRE_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR_temp;
  supply1  VDD;
  supply0  GND;
  assign #(d_C1_r,d_C1_f) C1_temp = C1;
  assign #(d_C2_r,d_C2_f) C2_temp = C2;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_D) D_temp = D|D;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_Q) Q = Q_temp;
  assign #(d_QBAR) QBAR = QBAR_temp;
  bilbo_generic #(N) inst1 (C1_temp,C2_temp,CLK_temp,VDD,D_temp,PRE_temp,GND,VDD,VDD,Q_temp,QBAR_temp);
  specify
    specparam
      t_width_PRE = 0;
    $width(negedge PRE , t_width_PRE);
  endspecify
endmodule
