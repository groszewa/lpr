//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpboothenc(B0,B1,B2,MINUS,ONEX,TWOX);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_B0_r = 0,
        d_B0_f = 0,
        d_B1_r = 0,
        d_B1_f = 0,
        d_B2_r = 0,
        d_B2_f = 0,
        d_MINUS_r = 1,
        d_MINUS_f = 1,
        d_ONEX_r = 1,
        d_ONEX_f = 1,
        d_TWOX_r = 1,
        d_TWOX_f = 1;
  input  B0;
  input  B1;
  input  B2;
  output  MINUS;
  output  ONEX;
  output  TWOX;
  wire  B0_temp;
  wire  B1_temp;
  wire  B2_temp;
  reg  MINUS_temp;
  reg  ONEX_temp;
  reg  TWOX_temp;
  assign #(d_B0_r,d_B0_f) B0_temp = B0;
  assign #(d_B1_r,d_B1_f) B1_temp = B1;
  assign #(d_B2_r,d_B2_f) B2_temp = B2;
  assign #(d_MINUS_r,d_MINUS_f) MINUS = MINUS_temp;
  assign #(d_ONEX_r,d_ONEX_f) ONEX = ONEX_temp;
  assign #(d_TWOX_r,d_TWOX_f) TWOX = TWOX_temp;
  always
    @(B0_temp or B1_temp or B2_temp)
      begin
      MINUS_temp = B2_temp;
      ONEX_temp = (B1_temp ^ B0_temp);
      TWOX_temp = ((( ~ B2_temp) & (B1_temp & B0_temp)) | (B2_temp & ( ~ (B1_temp | B0_temp))));
      end
endmodule
