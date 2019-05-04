//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module sreg(CLK,LSBIN,S0,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_LSBIN_r = 0,
        d_LSBIN_f = 0,
        d_S0_r = 0,
        d_S0_f = 0,
        d_Q = 1;
  input  CLK;
  input  LSBIN;
  input  S0;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  LSBIN_temp;
  wire  S0_temp;
  wire [(N - 1):0] Q_temp;
  supply0 [(N - 1):0] GNDB;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK|CLK;
  assign #(d_LSBIN_r,d_LSBIN_f) LSBIN_temp = LSBIN|LSBIN;
  assign #(d_S0_r,d_S0_f) S0_temp = S0|S0;
  assign #(d_Q) Q = Q_temp;
  sreg_generic #(N) inst1 (GNDB,CLK_temp,VDD,LSBIN_temp,GND,VDD,S0_temp,GND,GND,GND,Q_temp);
  specify
    specparam
      t_hold_LSBIN = 0,
      t_hold_S0 = 0,
      t_setup_LSBIN = 0,
      t_setup_S0 = 0;
    $hold(posedge CLK , LSBIN , t_hold_LSBIN);
    $hold(posedge CLK , S0 , t_hold_S0);
    $setup(LSBIN , posedge CLK , t_setup_LSBIN);
    $setup(S0 , posedge CLK , t_setup_S0);
  endspecify
endmodule