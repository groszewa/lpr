//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpboothmuxi(A,AM1,MINUS,ONEX,TWOX,PP);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_A_r = 0,
        d_A_f = 0,
        d_AM1_r = 0,
        d_AM1_f = 0,
        d_MINUS_r = 0,
        d_MINUS_f = 0,
        d_ONEX_r = 0,
        d_ONEX_f = 0,
        d_TWOX_r = 0,
        d_TWOX_f = 0,
        d_PP_r = 1,
        d_PP_f = 1;
  input  A;
  input  AM1;
  input  MINUS;
  input  ONEX;
  input  TWOX;
  output  PP;
  wire  A_temp;
  wire  AM1_temp;
  wire  MINUS_temp;
  wire  ONEX_temp;
  wire  TWOX_temp;
  reg  PP_temp;
  assign #(d_A_r,d_A_f) A_temp = A;
  assign #(d_AM1_r,d_AM1_f) AM1_temp = AM1;
  assign #(d_MINUS_r,d_MINUS_f) MINUS_temp = MINUS;
  assign #(d_ONEX_r,d_ONEX_f) ONEX_temp = ONEX;
  assign #(d_TWOX_r,d_TWOX_f) TWOX_temp = TWOX;
  assign #(d_PP_r,d_PP_f) PP = PP_temp;
  always
    @(A_temp or AM1_temp or MINUS_temp or ONEX_temp or TWOX_temp)
      begin
      if(((TWOX_temp == 1'b0) && (ONEX_temp == 1'b0)))
        PP_temp = ( ~ MINUS_temp);
      else      if(((TWOX_temp == 1'b0) && (ONEX_temp == 1'b1)))
        PP_temp = ( ~ (MINUS_temp ^ A_temp));
      else      if(((TWOX_temp == 1'b1) && (ONEX_temp == 1'b0)))
        PP_temp = ( ~ (MINUS_temp ^ AM1_temp));
      else
        PP_temp = 128'bx;
      end
endmodule
