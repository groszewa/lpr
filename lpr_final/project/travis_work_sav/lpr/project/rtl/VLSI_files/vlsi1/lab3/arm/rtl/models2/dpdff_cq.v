//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpdff_cq(CLK,CLR,D,Q,QBAR);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D_r = 0,
        d_D_f = 0,
        d_Q_r = 1,
        d_Q_f = 1,
        d_QBAR_r = 1,
        d_QBAR_f = 1;
  input  CLK;
  input  CLR;
  input  D;
  output  Q;
  output  QBAR;
  wire  CLK_temp;
  wire  CLR_temp;
  wire  D_temp;
  wire  Q_temp;
  reg  QBAR_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_D_r,d_D_f) D_temp = D;
  assign #(d_Q_r,d_Q_f) Q = Q_temp;
  assign #(d_QBAR_r,d_QBAR_f) QBAR = QBAR_temp;
  always
    @(Q_temp)
      QBAR_temp = ( ~ Q_temp);
  dff_leaf_generic inst1 (CLK_temp,CLR_temp,D_temp,VDD,Q_temp);
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_width_CLR = 0;
    $hold(posedge CLK , D , t_hold_D);
    $setup(D , posedge CLK , t_setup_D);
    $width(negedge CLR , t_width_CLR);
  endspecify
endmodule
