//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module latch_cp(CLR,D,EN,PRE,Q);
  parameter N = 32;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D = 0,
        d_EN_r = 0,
        d_EN_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q = 1;
  input  CLR;
  input [(N - 1):0] D;
  input  EN;
  input  PRE;
  output [(N - 1):0] Q;
  wire  CLR_temp;
  wire [(N - 1):0] D_temp;
  wire  EN_temp;
  wire  PRE_temp;
  reg [(N - 1):0] Q_temp;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_D) D_temp = D;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_Q) Q = Q_temp;
  always
    @(CLR_temp or PRE_temp or EN_temp or D_temp)
      begin
      if(((CLR_temp == 1'b0) && (PRE_temp == 1'b1)))
        Q_temp = 128'b0;
      else      if(((PRE_temp == 1'b0) && (CLR_temp == 1'b1)))
        Q_temp = ( ~ 128'b0);
      else      if(((CLR_temp !== 1'b1) || (PRE_temp !== 1'b1)))
        Q_temp = 128'bx;
      else      if((EN_temp == 1'b1))
        Q_temp = D_temp;
      else      if((EN_temp !== 1'b0))
        Q_temp = 128'bx;
      end
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0;
    $hold(negedge EN , D_tcheck , t_hold_D);
    $setup(D_tcheck , negedge EN , t_setup_D);
  endspecify
endmodule
