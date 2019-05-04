//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module scntrdt_cp(CLK,CLR,EN,PRE,SCANIN,TEST,COUT,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_EN_r = 0,
        d_EN_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_SCANIN_r = 0,
        d_SCANIN_f = 0,
        d_TEST_r = 0,
        d_TEST_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_Q = 1;
  input  CLK;
  input  CLR;
  input  EN;
  input  PRE;
  input  SCANIN;
  input  TEST;
  output  COUT;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  CLR_temp;
  wire  EN_temp;
  wire  PRE_temp;
  wire  SCANIN_temp;
  wire  TEST_temp;
  wire  COUT_temp;
  wire [(N - 1):0] Q_temp;
  supply0 [(N - 1):0] GNDB;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_SCANIN_r,d_SCANIN_f) SCANIN_temp = SCANIN|SCANIN;
  assign #(d_TEST_r,d_TEST_f) TEST_temp = TEST|TEST;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_Q) Q = Q_temp;
  scntr_generic #(N) inst1 (CLK_temp,CLR_temp,GNDB,EN_temp,PRE_temp,GND,SCANIN_temp,TEST_temp,GND,COUT_temp,Q_temp);
  specify
    specparam
      t_width_CLR = 0,
      t_width_PRE = 0,
      t_hold_EN = 0,
      t_setup_EN = 0;
    $width(negedge CLR , t_width_CLR);
    $width(negedge PRE , t_width_PRE);
    $hold(posedge CLK , EN , t_hold_EN);
    $setup(EN , posedge CLK , t_setup_EN);
  endspecify
endmodule
