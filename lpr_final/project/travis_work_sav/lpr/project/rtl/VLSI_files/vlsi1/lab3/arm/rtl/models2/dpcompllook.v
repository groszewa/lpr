//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpcompllook(CIN,CINBAR,COMP,IN0,LOOK2,LOOK3,LOOK4,COUT,COUTBAR,Y);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_CIN_r = 0,
        d_CIN_f = 0,
        d_CINBAR_r = 0,
        d_CINBAR_f = 0,
        d_COMP_r = 0,
        d_COMP_f = 0,
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_LOOK2_r = 0,
        d_LOOK2_f = 0,
        d_LOOK3_r = 0,
        d_LOOK3_f = 0,
        d_LOOK4_r = 0,
        d_LOOK4_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_COUTBAR_r = 1,
        d_COUTBAR_f = 1,
        d_Y_r = 1,
        d_Y_f = 1;
  input  CIN;
  input  CINBAR;
  input  COMP;
  input  IN0;
  input  LOOK2;
  input  LOOK3;
  input  LOOK4;
  output  COUT;
  output  COUTBAR;
  output  Y;
  wire  CIN_temp;
  wire  CINBAR_temp;
  wire  COMP_temp;
  wire  IN0_temp;
  wire  LOOK2_temp;
  wire  LOOK3_temp;
  wire  LOOK4_temp;
  reg  COUT_temp;
  reg  COUTBAR_temp;
  reg  Y_temp;
  reg  temp;
  assign #(d_CIN_r,d_CIN_f) CIN_temp = CIN;
  assign #(d_CINBAR_r,d_CINBAR_f) CINBAR_temp = CINBAR;
  assign #(d_COMP_r,d_COMP_f) COMP_temp = COMP;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_LOOK2_r,d_LOOK2_f) LOOK2_temp = LOOK2;
  assign #(d_LOOK3_r,d_LOOK3_f) LOOK3_temp = LOOK3;
  assign #(d_LOOK4_r,d_LOOK4_f) LOOK4_temp = LOOK4;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_COUTBAR_r,d_COUTBAR_f) COUTBAR = COUTBAR_temp;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(CIN_temp or CINBAR_temp or COMP_temp or IN0_temp or LOOK2_temp or LOOK3_temp or LOOK4_temp)
      begin
      if((CIN_temp == 1'b0))
        Y_temp = IN0_temp;
      else      if((CIN_temp == 1'b1))
        Y_temp = ( ~ IN0_temp);
      else
        Y_temp = 128'bx;
      temp = ( ~ ((((LOOK2_temp & LOOK3_temp) & LOOK4_temp) & ( ~ IN0_temp)) | COMP_temp));
      COUT_temp = temp;
      COUTBAR_temp = ( ~ temp);
      end
endmodule
