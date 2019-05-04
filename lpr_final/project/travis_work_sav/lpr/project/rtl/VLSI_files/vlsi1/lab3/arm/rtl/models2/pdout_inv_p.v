//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pdout_inv_p(INP,PADPIN);
  parameter YPITCH = "4MA";
  parameter SLIM_FLAG = 0;
  parameter
        d_INP_r = 0,
        d_INP_f = 0,
        d_PADPIN_r = 1,
        d_PADPIN_f = 1;
  input  INP;
  output  PADPIN;
  wire  INP_temp;
  wire  PADPIN_temp;
  supply1  VDD;
  assign #(d_INP_r,d_INP_f) INP_temp = INP;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN = PADPIN_temp;
  paditrip #(0,0) inst1 (VDD,INP_temp,PADPIN_temp);
endmodule
