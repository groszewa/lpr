//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbok_c(C1,C2,CLK,CLR,D,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_C1_r = 0,
        d_C1_f = 0,
        d_C2_r = 0,
        d_C2_f = 0,
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D = 0,
        d_Q = 1;
  input  C1;
  input  C2;
  input  CLK;
  input  CLR;
  input [(N - 1):0] D;
  output [(N - 1):0] Q;
  wire  C1_temp;
  wire  C2_temp;
  wire  CLK_temp;
  wire  CLR_temp;
  wire [(N - 1):0] D_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR;
  supply1  VDD;
  supply0  GND;
  assign #(d_C1_r,d_C1_f) C1_temp = C1;
  assign #(d_C2_r,d_C2_f) C2_temp = C2;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_D) D_temp = D|D;
  assign #(d_Q) Q = Q_temp;
  bilbo_generic #(N) inst1 (C1_temp,C2_temp,CLK_temp,CLR_temp,D_temp,VDD,GND,VDD,VDD,Q_temp,QBAR);
  specify
    specparam
      t_width_CLR = 0;
    $width(negedge CLR , t_width_CLR);
  endspecify
endmodule
