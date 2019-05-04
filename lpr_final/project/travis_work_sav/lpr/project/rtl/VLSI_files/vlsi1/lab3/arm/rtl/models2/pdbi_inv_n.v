//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pdbi_inv_n(INN,PADPIN,Y);
  parameter YPITCH = "4MA";
  parameter SLIM_FLAG = 0;
  parameter
        d_INN_r = 0,
        d_INN_f = 0,
        d_PADPIN_r = 1,
        d_PADPIN_f = 1,
        d_Y_r = 1,
        d_Y_f = 1;
  input  INN;
  inout  PADPIN;
  inout  Y;
  wire  INN_temp;
  wire  PADPIN_temp;
  wire  Y_temp;
  supply1  VDD;
  assign #(d_INN_r,d_INN_f) INN_temp = INN;
  pd_wire inst2 (PADPIN,Y);
  paditrin #(0,0) inst1 (VDD,INN_temp,PADPIN);
endmodule
