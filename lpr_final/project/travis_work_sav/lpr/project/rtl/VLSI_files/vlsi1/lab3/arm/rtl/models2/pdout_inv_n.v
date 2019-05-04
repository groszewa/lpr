//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pdout_inv_n(INN,PADPIN);
  parameter YPITCH = "4MA";
  parameter SLIM_FLAG = 0;
  parameter
        d_INN_r = 0,
        d_INN_f = 0,
        d_PADPIN_r = 1,
        d_PADPIN_f = 1;
  input  INN;
  output  PADPIN;
  wire  INN_temp;
  wire  PADPIN_temp;
  supply1  VDD;
  assign #(d_INN_r,d_INN_f) INN_temp = INN;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN = PADPIN_temp;
  paditrin #(0,0) inst1 (VDD,INN_temp,PADPIN_temp);
endmodule
