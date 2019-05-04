//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dffs_c(CLK,CLR,D,SCANIN,TEST,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D = 0,
        d_SCANIN_r = 0,
        d_SCANIN_f = 0,
        d_TEST_r = 0,
        d_TEST_f = 0,
        d_Q = 1;
  input  CLK;
  input  CLR;
  input [(N - 1):0] D;
  input  SCANIN;
  input  TEST;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  CLR_temp;
  wire [(N - 1):0] D_temp;
  wire  SCANIN_temp;
  wire  TEST_temp;
  wire [(N - 1):0] Q_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_D) D_temp = D|D;
  assign #(d_SCANIN_r,d_SCANIN_f) SCANIN_temp = SCANIN|SCANIN;
  assign #(d_TEST_r,d_TEST_f) TEST_temp = TEST;
  assign #(d_Q) Q = Q_temp;
  dff_generic #(N) inst1 (CLK_temp,CLR_temp,D_temp,GND,VDD,SCANIN_temp,TEST_temp,Q_temp);
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_width_CLR = 0,
      t_hold_SCANIN = 0,
      t_setup_SCANIN = 0,
      t_hold_TEST = 0,
      t_setup_TEST = 0;
    $hold(posedge CLK , D_tcheck , t_hold_D);
    $setup(D_tcheck , posedge CLK , t_setup_D);
    $width(negedge CLR , t_width_CLR);
    $hold(posedge CLK , SCANIN , t_hold_SCANIN);
    $setup(SCANIN , posedge CLK , t_setup_SCANIN);
    $hold(posedge CLK , TEST , t_hold_TEST);
    $setup(TEST , posedge CLK , t_setup_TEST);
  endspecify
endmodule