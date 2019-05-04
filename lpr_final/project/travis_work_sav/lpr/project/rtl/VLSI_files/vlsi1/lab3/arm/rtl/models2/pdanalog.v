//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pdanalog(PADPIN,COREPORT);
  parameter PTYPE = "PLAIN";
  parameter YPITCH = "12MA";
  parameter SLIM_FLAG = 0;
  parameter
        d_PADPIN_r = 0,
        d_PADPIN_f = 0,
        d_COREPORT_r = 1,
        d_COREPORT_f = 1;
  input  PADPIN;
  output  COREPORT;
  wire  PADPIN_temp;
  reg  COREPORT_temp;
  assign #(d_PADPIN_r,d_PADPIN_f) PADPIN_temp = PADPIN;
  assign #(d_COREPORT_r,d_COREPORT_f) COREPORT = COREPORT_temp;
  always
    @(PADPIN_temp)
      COREPORT_temp = PADPIN_temp;
endmodule
