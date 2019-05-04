//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padanalog(PADPIN,TOCORE);
  parameter M = 7;
  parameter N = 0;
  parameter PTYPE = "PLAIN";
  parameter YPITCH = "4MA";
  parameter SLIM_FLAG = 0;
  parameter
        d_PADPIN = 0,
        d_TOCORE = 1;
  input [M:N] PADPIN;
  output [M:N] TOCORE;
  wire [M:N] PADPIN_temp;
  reg [M:N] TOCORE_temp;
  assign #(d_PADPIN) PADPIN_temp = PADPIN;
  assign #(d_TOCORE) TOCORE = TOCORE_temp;
  always
    @(PADPIN_temp)
      TOCORE_temp = PADPIN_temp;
endmodule
