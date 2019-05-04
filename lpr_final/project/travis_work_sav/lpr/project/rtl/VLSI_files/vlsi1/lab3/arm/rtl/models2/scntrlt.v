//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module scntrlt(CLK,D,EN,PL,SCANIN,TEST,COUT,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D = 0,
        d_EN_r = 0,
        d_EN_f = 0,
        d_PL_r = 0,
        d_PL_f = 0,
        d_SCANIN_r = 0,
        d_SCANIN_f = 0,
        d_TEST_r = 0,
        d_TEST_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_Q = 1;
  input  CLK;
  input [(N - 1):0] D;
  input  EN;
  input  PL;
  input  SCANIN;
  input  TEST;
  output  COUT;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire [(N - 1):0] D_temp;
  wire  EN_temp;
  wire  PL_temp;
  wire  SCANIN_temp;
  wire  TEST_temp;
  wire  COUT_temp;
  wire [(N - 1):0] Q_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_D) D_temp = D|D;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_PL_r,d_PL_f) PL_temp = PL;
  assign #(d_SCANIN_r,d_SCANIN_f) SCANIN_temp = SCANIN|SCANIN;
  assign #(d_TEST_r,d_TEST_f) TEST_temp = TEST|TEST;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_Q) Q = Q_temp;
  scntr_generic #(N) inst1 (CLK_temp,VDD,D_temp,EN_temp,VDD,PL_temp,SCANIN_temp,TEST_temp,VDD,COUT_temp,Q_temp);
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_EN = 0,
      t_setup_EN = 0,
      t_hold_D = 0,
      t_setup_D = 0,
      t_hold_PL = 0,
      t_setup_PL = 0;
    $hold(posedge CLK , EN , t_hold_EN);
    $setup(EN , posedge CLK , t_setup_EN);
    $hold(posedge CLK , D_tcheck , t_hold_D);
    $setup(D_tcheck , posedge CLK , t_setup_D);
    $hold(posedge CLK , PL , t_hold_PL);
    $setup(PL , posedge CLK , t_setup_PL);
  endspecify
endmodule
