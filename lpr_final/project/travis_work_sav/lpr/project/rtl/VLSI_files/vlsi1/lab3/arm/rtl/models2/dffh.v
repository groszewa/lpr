//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dffh(CLK,D,HOLD,Q);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D = 0,
        d_HOLD_r = 0,
        d_HOLD_f = 0,
        d_Q = 1;
  input  CLK;
  input [(N - 1):0] D;
  input  HOLD;
  output [(N - 1):0] Q;
  wire  CLK_temp;
  wire [(N - 1):0] D_temp;
  wire  HOLD_temp;
  wire [(N - 1):0] Q_temp;
  supply0  GND;
  supply1  VDD;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_D) D_temp = D|D;
  assign #(d_HOLD_r,d_HOLD_f) HOLD_temp = HOLD;
  assign #(d_Q) Q = Q_temp;
  dff_generic #(N) inst1 (CLK_temp,VDD,D_temp,HOLD_temp,VDD,VDD,GND,Q_temp);
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_hold_HOLD = 0,
      t_setup_HOLD = 0;
    $hold(posedge CLK , D_tcheck , t_hold_D);
    $setup(D_tcheck , posedge CLK , t_setup_D);
    $hold(posedge CLK , HOLD , t_hold_HOLD);
    $setup(HOLD , posedge CLK , t_setup_HOLD);
  endspecify
endmodule
