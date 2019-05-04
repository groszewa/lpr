//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdinvtri(EN,IN0,Y);
  parameter
        d_EN_r = 0,
        d_EN_f = 0,
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_Y_r = 1,
        d_Y_f = 1;
  input  EN;
  input  IN0;
  output  Y;
  wire  EN_temp;
  wire  IN0_temp;
  reg  Y_temp;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(IN0_temp or EN_temp)
      begin
      if((EN_temp == 1'b1))
        Y_temp = ( ~ IN0_temp);
      else      if((EN_temp == 1'b0))
        Y_temp = 128'bz;
      else
        Y_temp = 128'bx;
      end
endmodule
