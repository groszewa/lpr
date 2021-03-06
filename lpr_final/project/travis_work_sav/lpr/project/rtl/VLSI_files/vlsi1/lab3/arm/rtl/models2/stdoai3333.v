//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdoai3333(IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7,IN8,IN9,IN10,IN11,Y);
  parameter
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_IN1_r = 0,
        d_IN1_f = 0,
        d_IN2_r = 0,
        d_IN2_f = 0,
        d_IN3_r = 0,
        d_IN3_f = 0,
        d_IN4_r = 0,
        d_IN4_f = 0,
        d_IN5_r = 0,
        d_IN5_f = 0,
        d_IN6_r = 0,
        d_IN6_f = 0,
        d_IN7_r = 0,
        d_IN7_f = 0,
        d_IN8_r = 0,
        d_IN8_f = 0,
        d_IN9_r = 0,
        d_IN9_f = 0,
        d_IN10_r = 0,
        d_IN10_f = 0,
        d_IN11_r = 0,
        d_IN11_f = 0,
        d_Y_r = 1,
        d_Y_f = 1;
  input  IN0;
  input  IN1;
  input  IN2;
  input  IN3;
  input  IN4;
  input  IN5;
  input  IN6;
  input  IN7;
  input  IN8;
  input  IN9;
  input  IN10;
  input  IN11;
  output  Y;
  wire  IN0_temp;
  wire  IN1_temp;
  wire  IN2_temp;
  wire  IN3_temp;
  wire  IN4_temp;
  wire  IN5_temp;
  wire  IN6_temp;
  wire  IN7_temp;
  wire  IN8_temp;
  wire  IN9_temp;
  wire  IN10_temp;
  wire  IN11_temp;
  reg  Y_temp;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_IN1_r,d_IN1_f) IN1_temp = IN1;
  assign #(d_IN2_r,d_IN2_f) IN2_temp = IN2;
  assign #(d_IN3_r,d_IN3_f) IN3_temp = IN3;
  assign #(d_IN4_r,d_IN4_f) IN4_temp = IN4;
  assign #(d_IN5_r,d_IN5_f) IN5_temp = IN5;
  assign #(d_IN6_r,d_IN6_f) IN6_temp = IN6;
  assign #(d_IN7_r,d_IN7_f) IN7_temp = IN7;
  assign #(d_IN8_r,d_IN8_f) IN8_temp = IN8;
  assign #(d_IN9_r,d_IN9_f) IN9_temp = IN9;
  assign #(d_IN10_r,d_IN10_f) IN10_temp = IN10;
  assign #(d_IN11_r,d_IN11_f) IN11_temp = IN11;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(IN0_temp or IN1_temp or IN2_temp or IN3_temp or IN4_temp or IN5_temp or IN6_temp or IN7_temp or IN8_temp or IN9_temp or IN10_temp or IN11_temp)
      begin
      Y_temp = ( ~ (((((IN0_temp | IN1_temp) | IN2_temp) & ((IN3_temp | IN4_temp) | IN5_temp)) & ((IN6_temp | IN7_temp) | IN8_temp)) & ((IN9_temp | IN10_temp) | IN11_temp)));
      end
endmodule
