//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdaddh(A,B,COUT,SUM);
  parameter
        d_A_r = 0,
        d_A_f = 0,
        d_B_r = 0,
        d_B_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_SUM_r = 1,
        d_SUM_f = 1;
  input  A;
  input  B;
  output  COUT;
  output  SUM;
  wire  A_temp;
  wire  B_temp;
  reg  COUT_temp;
  reg  SUM_temp;
  assign #(d_A_r,d_A_f) A_temp = A;
  assign #(d_B_r,d_B_f) B_temp = B;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_SUM_r,d_SUM_f) SUM = SUM_temp;
  always
    @(A_temp or B_temp)
      begin
      COUT_temp = (A_temp & B_temp);
      SUM_temp = (A_temp ^ B_temp);
      end
endmodule
