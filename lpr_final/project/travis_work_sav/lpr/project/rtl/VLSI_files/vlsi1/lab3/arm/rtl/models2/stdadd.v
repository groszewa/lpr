//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdadd(A,B,CIN,COUT,SUM);
  parameter
        d_A_r = 0,
        d_A_f = 0,
        d_B_r = 0,
        d_B_f = 0,
        d_CIN_r = 0,
        d_CIN_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_SUM_r = 1,
        d_SUM_f = 1;
  input  A;
  input  B;
  input  CIN;
  output  COUT;
  output  SUM;
  wire  A_temp;
  wire  B_temp;
  wire  CIN_temp;
  reg  COUT_temp;
  reg  SUM_temp;
  reg [1:0] t;
  assign #(d_A_r,d_A_f) A_temp = A;
  assign #(d_B_r,d_B_f) B_temp = B;
  assign #(d_CIN_r,d_CIN_f) CIN_temp = CIN;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_SUM_r,d_SUM_f) SUM = SUM_temp;
  always
    @(A_temp or B_temp or CIN_temp)
      begin
      t = (({1'b0,A_temp} + B_temp) + CIN_temp);
      COUT_temp = t[1];
      SUM_temp = t[0];
      end
endmodule
