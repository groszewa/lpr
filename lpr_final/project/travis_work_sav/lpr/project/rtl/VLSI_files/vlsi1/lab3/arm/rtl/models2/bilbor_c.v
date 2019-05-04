//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbor_c(CLK,CLR,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_Q = 1;
  input  CLK;
  input  CLR;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  CLR_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR;
  supply1  VDD;
  supply0  GND;
  supply0 [(N - 1):0] GNDBUS;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_Q) Q = Q_temp;
  bilbo_generic #(N) inst1 (GND,VDD,CLK_temp,CLR_temp,GNDBUS,VDD,GND,VDD,VDD,Q_temp,QBAR);
  specify
    specparam
      t_width_CLR = 0;
    $width(negedge CLR , t_width_CLR);
  endspecify
endmodule
