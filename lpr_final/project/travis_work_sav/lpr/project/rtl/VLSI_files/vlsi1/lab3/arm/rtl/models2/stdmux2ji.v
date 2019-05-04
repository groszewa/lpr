//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdmux2ji(IN0,IN1,S0,Y);
  parameter
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_IN1_r = 0,
        d_IN1_f = 0,
        d_S0_r = 0,
        d_S0_f = 0,
        d_Y_r = 1,
        d_Y_f = 1;
  input  IN0;
  input  IN1;
  input  S0;
  output  Y;
  wire  IN0_temp;
  wire  IN1_temp;
  wire  S0_temp;
  reg  Y_temp;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0|IN0;
  assign #(d_IN1_r,d_IN1_f) IN1_temp = IN1|IN1;
  assign #(d_S0_r,d_S0_f) S0_temp = S0|S0;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(IN0_temp or IN1_temp or S0_temp)
      begin
      if((S0_temp == 1'b0))
        Y_temp = IN0_temp;
      else      if((S0_temp == 1'b1))
        Y_temp = ( ~ IN1_temp);
      else
        Y_temp = 128'bx;
      end
endmodule
