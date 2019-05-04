//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pdout_inv(IN0,PADPIN);
  parameter YPITCH = "4MA";
  parameter SLIM_FLAG = 0;
  parameter
        d_IN0_r = 0,
        d_IN0_f = 0,
        d_PADPIN_r = 1,
        d_PADPIN_f = 1;
  input  IN0;
  output  PADPIN;
  wire  IN0_temp;
  reg  PADPIN_temp;
  assign #(d_IN0_r,d_IN0_f) IN0_temp = IN0;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN = PADPIN_temp;
  always
    @(IN0_temp)
      PADPIN_temp = ( ~ IN0_temp);
endmodule
