//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dpincdec(CIN,CINBAR,IN0,UP,UPBAR,COUT,COUTBAR,Y);
  parameter BIT = 0;
  parameter COLINST = "0";
  parameter GROUP = "dpath1";
  parameter
        d_CIN_r = 0,
        d_CIN_f = 0,
        d_CINBAR_r = 0,
        d_CINBAR_f = 0,
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_UP_r = 0,
        d_UP_f = 0,
        d_UPBAR_r = 0,
        d_UPBAR_f = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_COUTBAR_r = 1,
        d_COUTBAR_f = 1,
        d_Y_r = 1,
        d_Y_f = 1;
  input  CIN;
  input  CINBAR;
  input  IN0;
  input  UP;
  input  UPBAR;
  output  COUT;
  output  COUTBAR;
  output  Y;
  wire  CIN_temp;
  wire  CINBAR_temp;
  wire  IN0_temp;
  wire  UP_temp;
  wire  UPBAR_temp;
  reg  COUT_temp;
  reg  COUTBAR_temp;
  reg  Y_temp;
  assign #(d_CIN_r,d_CIN_f) CIN_temp = CIN;
  assign #(d_CINBAR_r,d_CINBAR_f) CINBAR_temp = CINBAR;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_UP_r,d_UP_f) UP_temp = UP;
  assign #(d_UPBAR_r,d_UPBAR_f) UPBAR_temp = UPBAR;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_COUTBAR_r,d_COUTBAR_f) COUTBAR = COUTBAR_temp;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(IN0_temp or CIN_temp or CINBAR_temp or UP_temp or UPBAR_temp)
      begin
      if((UP_temp == 1'b1))
        begin
        COUT_temp = ( ~ (CINBAR_temp | ( ~ IN0_temp)));
        COUTBAR_temp = ( ~ (CIN_temp & IN0_temp));
        end
      else      if((UP_temp == 1'b0))
        begin
        COUT_temp = ( ~ (CINBAR_temp | IN0_temp));
        COUTBAR_temp = ( ~ (CIN_temp & ( ~ IN0_temp)));
        end
      else
        begin
        COUT_temp = 1'bx;
        COUTBAR_temp = 1'bx;
        end
      Y_temp = (CIN_temp ^ IN0_temp);
      end
endmodule
