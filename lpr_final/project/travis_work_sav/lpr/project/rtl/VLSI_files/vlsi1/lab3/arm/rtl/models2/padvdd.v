//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padvdd(PADPIN);
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter PTYPE = "REGULAR";
  parameter YPITCH = "12ma";
  parameter
        d_PADPIN_r = 1,
        d_PADPIN_f = 1;
  output  PADPIN;
  reg  PADPIN_temp;
  supply1  VDD;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN = PADPIN_temp;
  initial
    PADPIN_temp = 1'b1;
endmodule
