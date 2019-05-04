//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpmcomp(A,B,XIN,YIN,AGB,BGA);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_A_r = 0,
        d_A_f = 0,
        d_B_r = 0,
        d_B_f = 0,
        d_XIN_r = 0,
        d_XIN_f = 0,
        d_YIN_r = 0,
        d_YIN_f = 0,
        d_AGB_r = 1,
        d_AGB_f = 1,
        d_BGA_r = 1,
        d_BGA_f = 1;
  input  A;
  input  B;
  input  XIN;
  input  YIN;
  output  AGB;
  output  BGA;
  wire  A_temp;
  wire  B_temp;
  wire  XIN_temp;
  wire  YIN_temp;
  reg  AGB_temp;
  reg  BGA_temp;
  assign #(d_A_r,d_A_f) A_temp = A;
  assign #(d_B_r,d_B_f) B_temp = B;
  assign #(d_XIN_r,d_XIN_f) XIN_temp = XIN;
  assign #(d_YIN_r,d_YIN_f) YIN_temp = YIN;
  assign #(d_AGB_r,d_AGB_f) AGB = AGB_temp;
  assign #(d_BGA_r,d_BGA_f) BGA = BGA_temp;
  always
    @(XIN_temp or YIN_temp or A_temp or B_temp)
      begin
      AGB_temp = ( ~ (( ~ XIN_temp) & ( ~ ((A_temp & ( ~ B_temp)) & ( ~ YIN_temp)))));
      BGA_temp = ( ~ (( ~ YIN_temp) & ( ~ ((B_temp & ( ~ A_temp)) & ( ~ XIN_temp)))));
      end
endmodule
