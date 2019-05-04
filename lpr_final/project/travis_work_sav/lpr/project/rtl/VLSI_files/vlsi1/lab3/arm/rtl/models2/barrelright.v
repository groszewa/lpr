//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module barrelright(IN0,S,Y);
  parameter N = 8;
  parameter M = 3;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_IN0 = 0,
        d_S = 0,
        d_Y = 1;
  input [(N - 1):0] IN0;
  input [(M - 1):0] S;
  output [(N - 1):0] Y;
  wire [(N - 1):0] IN0_temp;
  wire [(M - 1):0] S_temp;
  reg [(N - 1):0] Y_temp;
  assign #(d_IN0) IN0_temp = IN0|IN0;
  assign #(d_S) S_temp = S;
  assign #(d_Y) Y = Y_temp;
  always
    @(IN0_temp or S_temp)
      begin
      Y_temp = (IN0_temp >> S_temp);
      end
endmodule