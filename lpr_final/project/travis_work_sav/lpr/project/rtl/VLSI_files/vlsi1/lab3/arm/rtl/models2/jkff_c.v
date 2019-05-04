//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module jkff_c(CLK,CLR,J,K,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_J = 0,
        d_K = 0,
        d_Q = 1;
  input  CLK;
  input  CLR;
  input [(N - 1):0] J;
  input [(N - 1):0] K;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire  CLR_temp;
  wire [(N - 1):0] J_temp;
  wire [(N - 1):0] K_temp;
  wire [(N - 1):0] Q_temp;
  wire [(N - 1):0] QBAR;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_J) J_temp = J;
  assign #(d_K) K_temp = K;
  assign #(d_Q) Q = Q_temp;
  jkff_generic #(N) inst1 (CLK_temp,CLR_temp,J_temp,K_temp,VDD,GND,GND,Q_temp,QBAR);
  wire [127:0] J_tcheck = J;
  wire [127:0] K_tcheck = K;
  specify
    specparam
      t_hold_J = 0,
      t_setup_J = 0,
      t_hold_K = 0,
      t_setup_K = 0,
      t_width_CLR = 0;
    $hold(posedge CLK , J_tcheck , t_hold_J);
    $setup(J_tcheck , posedge CLK , t_setup_J);
    $hold(posedge CLK , K_tcheck , t_hold_K);
    $setup(K_tcheck , posedge CLK , t_setup_K);
    $width(negedge CLR , t_width_CLR);
  endspecify
endmodule
