//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dff_c(CLK,CLR,D,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D = 0,
        d_Q = 1;
  input  CLK;
  input  CLR;
  input [(N - 1):0] D;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  CLR_temp;
  wire [(N - 1):0] D_temp;
  wire [(N - 1):0] Q_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_D) D_temp = D|D;
  assign #(d_Q) Q = Q_temp;
  dff_generic #(N) inst1 (CLK_temp,CLR_temp,D_temp,GND,VDD,VDD,GND,Q_temp);
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_width_CLR = 0;
    $hold(posedge CLK , D_tcheck , t_hold_D);
    $setup(D_tcheck , posedge CLK , t_setup_D);
    $width(negedge CLR , t_width_CLR);
  endspecify
endmodule
