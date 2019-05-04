//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module rcntrt_cp(CLK,CLR,PRE,SCANIN,TEST,TESTCLK,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_SCANIN_r = 0,
        d_SCANIN_f = 0,
        d_TEST_r = 0,
        d_TEST_f = 0,
        d_TESTCLK_r = 0,
        d_TESTCLK_f = 0,
        d_Q = 1;
  input  CLK;
  input  CLR;
  input  PRE;
  input  SCANIN;
  input  TEST;
  input  TESTCLK;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  CLR_temp;
  wire  PRE_temp;
  wire  SCANIN_temp;
  wire  TEST_temp;
  wire  TESTCLK_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_SCANIN_r,d_SCANIN_f) SCANIN_temp = SCANIN|SCANIN;
  assign #(d_TEST_r,d_TEST_f) TEST_temp = TEST|TEST;
  assign #(d_TESTCLK_r,d_TESTCLK_f) TESTCLK_temp = TESTCLK|TESTCLK;
  assign #(d_Q) Q = Q_temp;
  rcntr_generic #(N) inst1 (CLK_temp,PRE_temp,CLR_temp,SCANIN_temp,TEST_temp,TESTCLK_temp,Q_temp,QBAR);
endmodule
