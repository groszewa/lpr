//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpdff_pq(CLK,D,PRE,Q,QBAR);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D_r = 0,
        d_D_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q_r = 1,
        d_Q_f = 1,
        d_QBAR_r = 1,
        d_QBAR_f = 1;
  input  CLK;
  input  D;
  input  PRE;
  output  Q;
  output  QBAR;
  wire  CLK_temp;
  wire  D_temp;
  wire  PRE_temp;
  wire  Q_temp;
  reg  QBAR_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_D_r,d_D_f) D_temp = D;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_Q_r,d_Q_f) Q = Q_temp;
  assign #(d_QBAR_r,d_QBAR_f) QBAR = QBAR_temp;
  always
    @(Q_temp)
      QBAR_temp = ( ~ Q_temp);
  dff_leaf_generic inst1 (CLK_temp,VDD,D_temp,PRE_temp,Q_temp);
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_width_PRE = 0;
    $hold(posedge CLK , D , t_hold_D);
    $setup(D , posedge CLK , t_setup_D);
    $width(negedge PRE , t_width_PRE);
  endspecify
endmodule
