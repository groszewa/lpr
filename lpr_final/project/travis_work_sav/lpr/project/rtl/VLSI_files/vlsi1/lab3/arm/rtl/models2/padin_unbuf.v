//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padin_unbuf(PADPIN,Y);
  parameter M = 7;
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter YPITCH = "4MA";
  parameter
        d_PADPIN = 0,
        d_Y = 1;
  input [M:N] PADPIN;
  output [M:N] Y;
  wire [M:N] PADPIN_temp;
  reg [M:N] Y_temp;
  assign #(d_PADPIN) PADPIN_temp = PADPIN;
  assign #(d_Y) Y = Y_temp;
  always
    @(PADPIN_temp)
      Y_temp = PADPIN_temp;
endmodule
