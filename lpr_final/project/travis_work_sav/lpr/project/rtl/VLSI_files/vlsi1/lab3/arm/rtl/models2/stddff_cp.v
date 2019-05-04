//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stddff_cp(CLK,CLR,D,PRE,Q);
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D_r = 0,
        d_D_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q_r = 1,
        d_Q_f = 1;
  input  CLK;
  input  CLR;
  input  D;
  input  PRE;
  output  Q;
  wire  CLK_temp;
  wire  CLR_temp;
  wire  D_temp;
  wire  PRE_temp;
  wire  Q_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK|CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR|CLR;
  assign #(d_D_r,d_D_f) D_temp = D|D;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE|PRE;
  assign #(d_Q_r,d_Q_f) Q = Q_temp;
  dff_leaf_generic inst1 (CLK_temp,CLR_temp,D_temp,PRE_temp,Q_temp);
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_width_PRE = 0,
      t_width_CLR = 0;
    $hold(posedge CLK , D , t_hold_D);
    $setup(D , posedge CLK , t_setup_D);
    $width(negedge PRE , t_width_PRE);
    $width(negedge CLR , t_width_CLR);
  endspecify
endmodule
