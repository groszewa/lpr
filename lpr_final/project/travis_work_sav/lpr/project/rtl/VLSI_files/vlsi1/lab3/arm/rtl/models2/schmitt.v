//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module schmitt(IN0,Y);
  parameter
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_Y_r = 1,
        d_Y_f = 1;
  input  IN0;
  output  Y;
  wire  IN0_temp;
  reg  Y_temp;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(IN0_temp)
      Y_temp = IN0_temp;
endmodule
