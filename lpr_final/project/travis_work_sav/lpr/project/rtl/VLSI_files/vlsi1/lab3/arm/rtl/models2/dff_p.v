//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dff_p(CLK,D,PRE,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q = 1;
  input  CLK;
  input [(N - 1):0] D;
  input  PRE;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire [(N - 1):0] D_temp;
  wire  PRE_temp;
  wire [(N - 1):0] Q_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_D) D_temp = D|D;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_Q) Q = Q_temp;
  dff_generic #(N) inst1 (CLK_temp,VDD,D_temp,GND,PRE_temp,VDD,GND,Q_temp);
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_width_PRE = 0;
    $hold(posedge CLK , D_tcheck , t_hold_D);
    $setup(D_tcheck , posedge CLK , t_setup_D);
    $width(negedge PRE , t_width_PRE);
  endspecify
endmodule
