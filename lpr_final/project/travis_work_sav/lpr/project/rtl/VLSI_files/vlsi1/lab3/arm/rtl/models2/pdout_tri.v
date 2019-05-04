//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pdout_tri(INN,INP,PADPIN);
  parameter YPITCH = "4MA";
  parameter SLIM_FLAG = 0;
  parameter
        d_INN_r = 0,
        d_INN_f = 0,
        d_INP_r = 0,
        d_INP_f = 0,
        d_PADPIN_r = 1,
        d_PADPIN_f = 1;
  input  INN;
  input  INP;
  output  PADPIN;
  wire  INN_temp;
  wire  INP_temp;
  wire  PADPIN_temp;
  assign #(d_INN_r,d_INN_f) INN_temp = INN;
  assign #(d_INP_r,d_INP_f) INP_temp = INP;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN = PADPIN_temp;
  pd_tri inst1 (INN_temp,INP_temp,PADPIN_temp);
endmodule
