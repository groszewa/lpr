//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module tribuf(EN,IN0,Y);
  parameter N = 32;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_EN_r = 0,
        d_EN_f = 0,
        d_IN0 = 0,
        d_Y = 1;
  input  EN;
  input [(N - 1):0] IN0;
  output [(N - 1):0] Y;
  wire  EN_temp;
  wire [(N - 1):0] IN0_temp;
  reg [(N - 1):0] Y_temp;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_IN0) IN0_temp = IN0|IN0;
  assign #(d_Y) Y = Y_temp;
  always
    @(IN0_temp or EN_temp)
      begin
      if((EN_temp == 1'b0))
        Y_temp = IN0_temp;
      else      if((EN_temp == 1'b1))
        Y_temp = 128'bz;
      else
        Y_temp = 128'bx;
      end
endmodule
