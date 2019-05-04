//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module scntrbt(CLK,EN,SCANIN,TEST,UP,COUT,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_EN_r = 0,
        d_EN_f = 0,
        d_SCANIN_r = 0,
        d_SCANIN_f = 0,
        d_TEST_r = 0,
        d_TEST_f = 0,
        d_UP_r = 0,
        d_UP_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_Q = 1;
  input  CLK;
  input  EN;
  input  SCANIN;
  input  TEST;
  input  UP;
  output  COUT;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  EN_temp;
  wire  SCANIN_temp;
  wire  TEST_temp;
  wire  UP_temp;
  wire  COUT_temp;
  wire [(N - 1):0] Q_temp;
  supply0 [(N - 1):0] GNDB;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_SCANIN_r,d_SCANIN_f) SCANIN_temp = SCANIN|SCANIN;
  assign #(d_TEST_r,d_TEST_f) TEST_temp = TEST|TEST;
  assign #(d_UP_r,d_UP_f) UP_temp = UP|UP;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_Q) Q = Q_temp;
  scntr_generic #(N) inst1 (CLK_temp,VDD,GNDB,EN_temp,VDD,GND,SCANIN_temp,TEST_temp,UP_temp,COUT_temp,Q_temp);
  specify
    specparam
      t_hold_EN = 0,
      t_setup_EN = 0,
      t_hold_UP = 0,
      t_setup_UP = 0;
    $hold(posedge CLK , EN , t_hold_EN);
    $setup(EN , posedge CLK , t_setup_EN);
    $hold(posedge CLK , UP , t_hold_UP);
    $setup(UP , posedge CLK , t_setup_UP);
  endspecify
endmodule
