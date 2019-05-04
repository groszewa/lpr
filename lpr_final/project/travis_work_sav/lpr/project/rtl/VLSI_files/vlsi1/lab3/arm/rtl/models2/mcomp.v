//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module mcomp(A,B,AGB,BGA);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_A = 0,
        d_B = 0,
        d_AGB_r = 1,
        d_AGB_f = 1,
        d_BGA_r = 1,
        d_BGA_f = 1;
  input [(N - 1):0] A;
  input [(N - 1):0] B;
  output  AGB;
  output  BGA;
  wire [(N - 1):0] A_temp;
  wire [(N - 1):0] B_temp;
  reg  AGB_temp;
  reg  BGA_temp;
  assign #(d_A) A_temp = A;
  assign #(d_B) B_temp = B;
  assign #(d_AGB_r,d_AGB_f) AGB = AGB_temp;
  assign #(d_BGA_r,d_BGA_f) BGA = BGA_temp;
  always
    @(A_temp or B_temp)
      begin
      if((((A_temp==A_temp)===1'bx) || ((B_temp==B_temp)===1'bx)))
        begin
        AGB_temp = 1'bx;
        BGA_temp = 1'bx;
        end
      else      if((A_temp > B_temp))
        begin
        AGB_temp = 1'b1;
        BGA_temp = 1'b0;
        end
      else      if((B_temp > A_temp))
        begin
        BGA_temp = 1'b1;
        AGB_temp = 1'b0;
        end
      else
        begin
        BGA_temp = 1'b0;
        AGB_temp = 1'b0;
        end
      end
endmodule
