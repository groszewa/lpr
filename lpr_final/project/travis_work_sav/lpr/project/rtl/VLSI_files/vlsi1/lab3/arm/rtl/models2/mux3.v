//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module mux3(IN0,IN1,IN2,S0,S1,Y);
  parameter N = 32;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_IN0 = 0,
        d_IN1 = 0,
        d_IN2 = 0,
        d_S0_r = 0,
        d_S0_f = 0,
        d_S1_r = 0,
        d_S1_f = 0,
        d_Y = 1;
  input [(N - 1):0] IN0;
  input [(N - 1):0] IN1;
  input [(N - 1):0] IN2;
  input  S0;
  input  S1;
  output [(N - 1):0] Y;
  wire [(N - 1):0] IN0_temp;
  wire [(N - 1):0] IN1_temp;
  wire [(N - 1):0] IN2_temp;
  wire  S0_temp;
  wire  S1_temp;
  reg [(N - 1):0] Y_temp;
  assign #(d_IN0) IN0_temp = IN0|IN0;
  assign #(d_IN1) IN1_temp = IN1|IN1;
  assign #(d_IN2) IN2_temp = IN2|IN2;
  assign #(d_S0_r,d_S0_f) S0_temp = S0;
  assign #(d_S1_r,d_S1_f) S1_temp = S1;
  assign #(d_Y) Y = Y_temp;
  always
    @(IN0_temp or IN1_temp or IN2_temp or S0_temp or S1_temp)
      begin
      if(((S1_temp == 1'b0) && (S0_temp == 1'b0)))
        Y_temp = IN0_temp;
      else      if(((S1_temp == 1'b0) && (S0_temp == 1'b1)))
        Y_temp = IN1_temp;
      else      if((S1_temp == 1'b1))
        Y_temp = IN2_temp;
      else
        Y_temp = 128'bx;
      end
endmodule
