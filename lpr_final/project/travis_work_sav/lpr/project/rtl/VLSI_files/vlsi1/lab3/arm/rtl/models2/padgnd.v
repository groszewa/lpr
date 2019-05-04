//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padgnd(PADPIN);
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter PTYPE = "REGULAR";
  parameter YPITCH = "12MA";
  parameter
        d_PADPIN_r = 1,
        d_PADPIN_f = 1;
  output  PADPIN;
  reg  PADPIN_temp;
  supply0  GND;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN = PADPIN_temp;
  initial
    PADPIN_temp = 1'b0;
endmodule
