//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module sregdl(CLK,D,LSBIN,MSBIN,S0,S1,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D = 0,
        d_LSBIN_r = 0,
        d_LSBIN_f = 0,
        d_MSBIN_r = 0,
        d_MSBIN_f = 0,
        d_S0_r = 0,
        d_S0_f = 0,
        d_S1_r = 0,
        d_S1_f = 0,
        d_Q = 1;
  input  CLK;
  input [(N - 1):0] D;
  input  LSBIN;
  input  MSBIN;
  input  S0;
  input  S1;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire [(N - 1):0] D_temp;
  wire  LSBIN_temp;
  wire  MSBIN_temp;
  wire  S0_temp;
  wire  S1_temp;
  wire [(N - 1):0] Q_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK|CLK;
  assign #(d_D) D_temp = D|D;
  assign #(d_LSBIN_r,d_LSBIN_f) LSBIN_temp = LSBIN|LSBIN;
  assign #(d_MSBIN_r,d_MSBIN_f) MSBIN_temp = MSBIN|MSBIN;
  assign #(d_S0_r,d_S0_f) S0_temp = S0|S0;
  assign #(d_S1_r,d_S1_f) S1_temp = S1|S1;
  assign #(d_Q) Q = Q_temp;
  sreg_generic #(N) inst1 (D_temp,CLK_temp,VDD,LSBIN_temp,MSBIN_temp,VDD,S0_temp,S1_temp,GND,GND,Q_temp);
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_LSBIN = 0,
      t_hold_MSBIN = 0,
      t_hold_D = 0,
      t_hold_S0 = 0,
      t_hold_S1 = 0,
      t_setup_LSBIN = 0,
      t_setup_MSBIN = 0,
      t_setup_D = 0,
      t_setup_S0 = 0,
      t_setup_S1 = 0;
    $hold(posedge CLK , LSBIN , t_hold_LSBIN);
    $hold(posedge CLK , MSBIN , t_hold_MSBIN);
    $hold(posedge CLK , D_tcheck , t_hold_D);
    $hold(posedge CLK , S0 , t_hold_S0);
    $hold(posedge CLK , S1 , t_hold_S1);
    $setup(LSBIN , posedge CLK , t_setup_LSBIN);
    $setup(MSBIN , posedge CLK , t_setup_MSBIN);
    $setup(D_tcheck , posedge CLK , t_setup_D);
    $setup(S0 , posedge CLK , t_setup_S0);
    $setup(S1 , posedge CLK , t_setup_S1);
  endspecify
endmodule
