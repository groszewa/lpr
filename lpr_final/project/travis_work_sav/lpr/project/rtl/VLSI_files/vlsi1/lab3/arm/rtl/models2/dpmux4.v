//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpmux4(IN0,IN1,IN2,IN3,S0,S1,Y);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_IN1_r = 0,
        d_IN1_f = 0,
        d_IN2_r = 0,
        d_IN2_f = 0,
        d_IN3_r = 0,
        d_IN3_f = 0,
        d_S0_r = 0,
        d_S0_f = 0,
        d_S1_r = 0,
        d_S1_f = 0,
        d_Y_r = 1,
        d_Y_f = 1;
  input  IN0;
  input  IN1;
  input  IN2;
  input  IN3;
  input  S0;
  input  S1;
  output  Y;
  wire  IN0_temp;
  wire  IN1_temp;
  wire  IN2_temp;
  wire  IN3_temp;
  wire  S0_temp;
  wire  S1_temp;
  reg  Y_temp;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_IN1_r,d_IN1_f) IN1_temp = IN1;
  assign #(d_IN2_r,d_IN2_f) IN2_temp = IN2;
  assign #(d_IN3_r,d_IN3_f) IN3_temp = IN3;
  assign #(d_S0_r,d_S0_f) S0_temp = S0;
  assign #(d_S1_r,d_S1_f) S1_temp = S1;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(IN0_temp or IN1_temp or IN2_temp or IN3_temp or S0_temp or S1_temp)
      begin
      if(((S1_temp == 1'b0) && (S0_temp == 1'b0)))
        Y_temp = IN0_temp;
      else      if(((S1_temp == 1'b0) && (S0_temp == 1'b1)))
        Y_temp = IN1_temp;
      else      if(((S1_temp == 1'b1) && (S0_temp == 1'b0)))
        Y_temp = IN2_temp;
      else      if(((S1_temp == 1'b1) && (S0_temp == 1'b1)))
        Y_temp = IN3_temp;
      else
        Y_temp = 128'bx;
      end
endmodule
