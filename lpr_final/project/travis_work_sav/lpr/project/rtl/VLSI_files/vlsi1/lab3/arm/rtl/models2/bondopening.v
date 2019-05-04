//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bondopening(PADPIN);
  parameter
        d_PADPIN_r = 0,
        d_PADPIN_f = 0;
  input  PADPIN;
  wire  PADPIN_temp;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN_temp = PADPIN;
endmodule
