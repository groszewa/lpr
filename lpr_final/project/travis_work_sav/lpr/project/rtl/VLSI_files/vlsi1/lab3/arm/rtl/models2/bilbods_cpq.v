//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbods_cpq(C1,CLK,CLR,D,PRE,SDI,Q,QBAR);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_C1_r = 0,
        d_C1_f = 0,
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_SDI_r = 0,
        d_SDI_f = 0,
        d_Q = 1,
        d_QBAR = 1;
  input  C1;
  input  CLK;
  input  CLR;
  input [(N - 1):0] D;
  input  PRE;
  input  SDI;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  wire  C1_temp;
  wire  CLK_temp;
  wire  CLR_temp;
  wire [(N - 1):0] D_temp;
  wire  PRE_temp;
  wire  SDI_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR_temp;
  supply1  VDD;
  supply0  GND;
  assign #(d_C1_r,d_C1_f) C1_temp = C1|C1;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK|CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR|CLR;
  assign #(d_D) D_temp = D|D;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE|PRE;
  assign #(d_SDI_r,d_SDI_f) SDI_temp = SDI|SDI;
  assign #(d_Q) Q = Q_temp;
  assign #(d_QBAR) QBAR = QBAR_temp;
  bilbo_generic #(N) inst1 (VDD,VDD,CLK_temp,CLR_temp,D_temp,PRE_temp,SDI_temp,VDD,C1_temp,Q_temp,QBAR_temp);
  specify
    specparam
      t_width_CLR = 0,
      t_width_PRE = 0,
      t_hold_SDI = 0,
      t_setup_SDI = 0;
    $width(negedge CLR , t_width_CLR);
    $width(negedge PRE , t_width_PRE);
    $hold(posedge CLK , SDI , t_hold_SDI);
    $setup(SDI , posedge CLK , t_setup_SDI);
  endspecify
endmodule
