//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module jkfft_q(CLK,J,K,SCANIN,TEST,Q,QBAR);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_J = 0,
        d_K = 0,
        d_SCANIN_r = 0,
        d_SCANIN_f = 0,
        d_TEST_r = 0,
        d_TEST_f = 0,
        d_Q = 1,
        d_QBAR = 1;
  input  CLK;
  input [(N - 1):0] J;
  input [(N - 1):0] K;
  input  SCANIN;
  input  TEST;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  wire  CLK_temp;
  wire [(N - 1):0] J_temp;
  wire [(N - 1):0] K_temp;
  wire  SCANIN_temp;
  wire  TEST_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR_temp;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK|CLK;
  assign #(d_J) J_temp = J;
  assign #(d_K) K_temp = K;
  assign #(d_SCANIN_r,d_SCANIN_f) SCANIN_temp = SCANIN|SCANIN;
  assign #(d_TEST_r,d_TEST_f) TEST_temp = TEST|TEST;
  assign #(d_Q) Q = Q_temp;
  assign #(d_QBAR) QBAR = QBAR_temp;
  jkff_generic #(N) inst1 (CLK_temp,VDD,J_temp,K_temp,VDD,SCANIN_temp,TEST_temp,Q_temp,QBAR_temp);
  wire [127:0] J_tcheck = J;
  wire [127:0] K_tcheck = K;
  specify
    specparam
      t_hold_J = 0,
      t_setup_J = 0,
      t_hold_K = 0,
      t_setup_K = 0,
      t_hold_SCANIN = 0,
      t_setup_SCANIN = 0;
    $hold(posedge CLK , J_tcheck , t_hold_J);
    $setup(J_tcheck , posedge CLK , t_setup_J);
    $hold(posedge CLK , K_tcheck , t_hold_K);
    $setup(K_tcheck , posedge CLK , t_setup_K);
    $hold(posedge CLK , SCANIN , t_hold_SCANIN);
    $setup(SCANIN , posedge CLK , t_setup_SCANIN);
  endspecify
endmodule
