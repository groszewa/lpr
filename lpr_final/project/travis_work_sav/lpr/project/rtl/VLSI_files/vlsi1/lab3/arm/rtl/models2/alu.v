//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module alu(A,B,C0,M,S0,S1,S2,S3,COUT,F);
  parameter N = 8;
  parameter FAST = 0;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_A = 0,
        d_B = 0,
        d_C0_r = 0,
        d_C0_f = 0,
        d_M_r = 0,
        d_M_f = 0,
        d_S0_r = 0,
        d_S0_f = 0,
        d_S1_r = 0,
        d_S1_f = 0,
        d_S2_r = 0,
        d_S2_f = 0,
        d_S3_r = 0,
        d_S3_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_F = 1;
  input [(N - 1):0] A;
  input [(N - 1):0] B;
  input  C0;
  input  M;
  input  S0;
  input  S1;
  input  S2;
  input  S3;
  output  COUT;
  output [(N - 1):0] F;
  wire [(N - 1):0] A_temp;
  wire [(N - 1):0] B_temp;
  wire  C0_temp;
  wire  M_temp;
  wire  S0_temp;
  wire  S1_temp;
  wire  S2_temp;
  wire  S3_temp;
  wire  COUT_temp;
  wire [(N - 1):0] F_temp;
  reg [3:0] s;
  wire  overflow;
  assign #(d_A) A_temp = A|A;
  assign #(d_B) B_temp = B|B;
  assign #(d_C0_r,d_C0_f) C0_temp = C0;
  assign #(d_M_r,d_M_f) M_temp = M;
  assign #(d_S0_r,d_S0_f) S0_temp = S0;
  assign #(d_S1_r,d_S1_f) S1_temp = S1;
  assign #(d_S2_r,d_S2_f) S2_temp = S2;
  assign #(d_S3_r,d_S3_f) S3_temp = S3;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_F) F = F_temp;
  initial
    begin
    if((DPFLAG == 0))
      $display("(WARNING) The instance %m of type alu can't be implemented as a standard cell.");
    end
  always
    @(S0_temp or S1_temp or S2_temp or S3_temp)
      begin
      s[3] = S3_temp;
      s[2] = S2_temp;
      s[1] = S1_temp;
      s[0] = S0_temp;
      end
  alu_generic #(N) inst1 (A_temp,B_temp,C0_temp,M_temp,s,COUT_temp,F_temp,overflow);
endmodule
