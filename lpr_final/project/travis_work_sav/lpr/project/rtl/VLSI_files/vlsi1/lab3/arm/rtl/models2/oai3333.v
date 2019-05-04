//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module oai3333(IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7,IN8,IN9,IN10,IN11,Y);
  parameter N = 8;
  parameter DPFLAG = 0;
  parameter GROUP = "std";
  parameter
        d_IN0 = 0,
        d_IN1 = 0,
        d_IN2 = 0,
        d_IN3 = 0,
        d_IN4 = 0,
        d_IN5 = 0,
        d_IN6 = 0,
        d_IN7 = 0,
        d_IN8 = 0,
        d_IN9 = 0,
        d_IN10 = 0,
        d_IN11 = 0,
        d_Y = 1;
  input [(N - 1):0] IN0;
  input [(N - 1):0] IN1;
  input [(N - 1):0] IN2;
  input [(N - 1):0] IN3;
  input [(N - 1):0] IN4;
  input [(N - 1):0] IN5;
  input [(N - 1):0] IN6;
  input [(N - 1):0] IN7;
  input [(N - 1):0] IN8;
  input [(N - 1):0] IN9;
  input [(N - 1):0] IN10;
  input [(N - 1):0] IN11;
  output [(N - 1):0] Y;
  wire [(N - 1):0] IN0_temp;
  wire [(N - 1):0] IN1_temp;
  wire [(N - 1):0] IN2_temp;
  wire [(N - 1):0] IN3_temp;
  wire [(N - 1):0] IN4_temp;
  wire [(N - 1):0] IN5_temp;
  wire [(N - 1):0] IN6_temp;
  wire [(N - 1):0] IN7_temp;
  wire [(N - 1):0] IN8_temp;
  wire [(N - 1):0] IN9_temp;
  wire [(N - 1):0] IN10_temp;
  wire [(N - 1):0] IN11_temp;
  reg [(N - 1):0] Y_temp;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_IN1) IN1_temp = IN1;
  assign #(d_IN2) IN2_temp = IN2;
  assign #(d_IN3) IN3_temp = IN3;
  assign #(d_IN4) IN4_temp = IN4;
  assign #(d_IN5) IN5_temp = IN5;
  assign #(d_IN6) IN6_temp = IN6;
  assign #(d_IN7) IN7_temp = IN7;
  assign #(d_IN8) IN8_temp = IN8;
  assign #(d_IN9) IN9_temp = IN9;
  assign #(d_IN10) IN10_temp = IN10;
  assign #(d_IN11) IN11_temp = IN11;
  assign #(d_Y) Y = Y_temp;
  initial
    begin
    if((DPFLAG == 1))
      $display("(WARNING) The instance %m of type oai3333 can't be implemented as a data-path cell");
    end
  always
    @(IN0_temp or IN1_temp or IN2_temp or IN3_temp or IN4_temp or IN5_temp or IN6_temp or IN7_temp or IN8_temp or IN9_temp or IN10_temp or IN11_temp)
      begin
      Y_temp = ( ~ (((((IN0_temp | IN1_temp) | IN2_temp) & ((IN3_temp | IN4_temp) | IN5_temp)) & ((IN6_temp | IN7_temp) | IN8_temp)) & ((IN9_temp | IN10_temp) | IN11_temp)));
      end
endmodule
