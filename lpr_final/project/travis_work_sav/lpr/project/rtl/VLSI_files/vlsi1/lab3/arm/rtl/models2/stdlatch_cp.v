//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdlatch_cp(CLR,D,EN,PRE,Q);
  parameter
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_D_r = 0,
        d_D_f = 0,
        d_EN_r = 0,
        d_EN_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_Q_r = 1,
        d_Q_f = 1;
  input  CLR;
  input  D;
  input  EN;
  input  PRE;
  output  Q;
  wire  CLR_temp;
  wire  D_temp;
  wire  EN_temp;
  wire  PRE_temp;
  reg  Q_temp;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR|CLR;
  assign #(d_D_r,d_D_f) D_temp = D|D;
  assign #(d_EN_r,d_EN_f) EN_temp = EN|EN;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE|PRE;
  assign #(d_Q_r,d_Q_f) Q = Q_temp;
  always
    @(CLR_temp or PRE_temp or EN_temp or D_temp)
      begin
      if(((CLR_temp == 1'b0) && (PRE_temp == 1'b1)))
        Q_temp = 1'b0;
      else      if(((PRE_temp == 1'b0) && (CLR_temp == 1'b1)))
        Q_temp = 1'b1;
      else      if(((CLR_temp !== 1'b1) || (PRE_temp !== 1'b1)))
        Q_temp = 1'bx;
      else      if((EN_temp == 1'b1))
        Q_temp = D_temp;
      else      if((EN_temp !== 1'b0))
        Q_temp = 1'bx;
      end
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0;
    $hold(negedge EN , D , t_hold_D);
    $setup(D , negedge EN , t_setup_D);
  endspecify
endmodule
