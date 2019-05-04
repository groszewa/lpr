//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbors_c(C1,CLK,CLR,SDI,Q);
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
        d_SDI_r = 0,
        d_SDI_f = 0,
        d_Q = 1;
  input  C1;
  input  CLK;
  input  CLR;
  input  SDI;
  output [(N - 1):0] Q;
  wire  C1_temp;
  wire  CLK_temp;
  wire  CLR_temp;
  wire  SDI_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR;
  supply1  VDD;
  supply0  GND;
  supply0 [(N - 1):0] GNDBUS;
  assign #(d_C1_r,d_C1_f) C1_temp = C1|C1;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK|CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR|CLR;
  assign #(d_SDI_r,d_SDI_f) SDI_temp = SDI|SDI;
  assign #(d_Q) Q = Q_temp;
  bilbo_generic #(N) inst1 (GND,VDD,CLK_temp,CLR_temp,GNDBUS,VDD,SDI_temp,C1_temp,VDD,Q_temp,QBAR);
  specify
    specparam
      t_width_CLR = 0,
      t_hold_SDI = 0,
      t_setup_SDI = 0;
    $width(negedge CLR , t_width_CLR);
    $hold(posedge CLK , SDI , t_hold_SDI);
    $setup(SDI , posedge CLK , t_setup_SDI);
  endspecify
endmodule
