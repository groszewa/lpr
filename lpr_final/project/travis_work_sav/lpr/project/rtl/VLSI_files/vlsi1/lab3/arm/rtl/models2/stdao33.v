//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdao33(IN0,IN1,IN2,IN3,IN4,IN5,Y);
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
        d_Y_r = 1,
        d_Y_f = 1;
  input  IN0;
  input  IN1;
  input  IN2;
  input  IN3;
  input  IN4;
  input  IN5;
  output  Y;
  wire  IN0_temp;
  wire  IN1_temp;
  wire  IN2_temp;
  wire  IN3_temp;
  wire  IN4_temp;
  wire  IN5_temp;
  reg  Y_temp;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_IN1_r,d_IN1_f) IN1_temp = IN1;
  assign #(d_IN2_r,d_IN2_f) IN2_temp = IN2;
  assign #(d_IN3_r,d_IN3_f) IN3_temp = IN3;
  assign #(d_IN4_r,d_IN4_f) IN4_temp = IN4;
  assign #(d_IN5_r,d_IN5_f) IN5_temp = IN5;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(IN0_temp or IN1_temp or IN2_temp or IN3_temp or IN4_temp or IN5_temp)
      begin
      Y_temp = (((IN0_temp & IN1_temp) & IN2_temp) | ((IN3_temp & IN4_temp) & IN5_temp));
      end
endmodule
