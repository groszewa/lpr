//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pdin(PADPIN,Y);
  parameter YPITCH = "4MA";
  parameter SLIM_FLAG = 0;
  parameter PULL_TYPE = "NONE";
  parameter
        d_PADPIN_r = 0,
        d_PADPIN_f = 0,
        d_Y_r = 1,
        d_Y_f = 1;
  input  PADPIN;
  output  Y;
  wire  PADPIN_temp;
  reg  Y_temp;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN_temp = PADPIN;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(PADPIN_temp)
      Y_temp = PADPIN_temp;
endmodule
