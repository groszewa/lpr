//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module addbw(A,B,CIN,COUT,SUM);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_A = 0,
        d_B = 0,
        d_CIN = 0,
        d_COUT = 1,
        d_SUM = 1;
  input [(N - 1):0] A;
  input [(N - 1):0] B;
  input [(N - 1):0] CIN;
  output [(N - 1):0] COUT;
  output [(N - 1):0] SUM;
  wire [(N - 1):0] A_temp;
  wire [(N - 1):0] B_temp;
  wire [(N - 1):0] CIN_temp;
  reg [(N - 1):0] COUT_temp;
  reg [(N - 1):0] SUM_temp;
  assign #(d_A) A_temp = A;
  assign #(d_B) B_temp = B;
  assign #(d_CIN) CIN_temp = CIN;
  assign #(d_COUT) COUT = COUT_temp;
  assign #(d_SUM) SUM = SUM_temp;
  always
    @(A_temp or B_temp or CIN_temp)
      begin
      SUM_temp = (((((A_temp & B_temp) & CIN_temp) | ((( ~ A_temp) & ( ~ B_temp)) & CIN_temp)) | ((A_temp & ( ~ B_temp)) & ( ~ CIN_temp))) | ((( ~ A_temp) & B_temp) & ( ~ CIN_temp)));
      COUT_temp = (((A_temp & B_temp) | (A_temp & CIN_temp)) | (B_temp & CIN_temp));
      end
endmodule
