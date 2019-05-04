//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdrslatch_nor(R,S,Q,QBAR);
  parameter
        d_R_r = 0,
        d_R_f = 0,
        d_S_r = 0,
        d_S_f = 0,
        d_Q_r = 1,
        d_Q_f = 1,
        d_QBAR_r = 1,
        d_QBAR_f = 1;
  input  R;
  input  S;
  output  Q;
  output  QBAR;
  wire  R_temp;
  wire  S_temp;
  reg  Q_temp;
  reg  QBAR_temp;
  assign #(d_R_r,d_R_f) R_temp = R;
  assign #(d_S_r,d_S_f) S_temp = S;
  assign #(d_Q_r,d_Q_f) Q = Q_temp;
  assign #(d_QBAR_r,d_QBAR_f) QBAR = QBAR_temp;
  always
    @(S_temp or Q_temp)
      begin
      QBAR_temp = (S_temp | ( ~ Q_temp));
      end
  always
    @(R_temp or QBAR_temp)
      begin
      Q_temp = (R_temp | ( ~ QBAR_temp));
      end
endmodule
