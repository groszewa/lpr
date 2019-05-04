//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padbiuni_tri_invin_invout_p(ENINPAD,ENOUTPAD,IN0,PADPIN,Y);
  parameter M = 7;
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter OUTDRIVE = "4MA";
  parameter LEVEL_SHIFTING = 0;
  parameter SCHMITT_TRIGGER = 0;
  parameter PULL_TYPE = "None";
  parameter
        d_ENINPAD_r = 0,
        d_ENINPAD_f = 0,
        d_ENOUTPAD_r = 0,
        d_ENOUTPAD_f = 0,
        d_IN0 = 0,
        d_PADPIN = 1,
        d_Y = 1;
  input  ENINPAD;
  input  ENOUTPAD;
  input [M:N] IN0;
  inout [M:N] PADPIN;
  output [M:N] Y;
  wire  ENINPAD_temp;
  wire  ENOUTPAD_temp;
  wire [M:N] IN0_temp;
  wire [M:N] PADPIN_temp;
  wire [M:N] Y_temp;
  wire  ENINPADB;
  wire  ENOUTPADB;
  assign #(d_ENINPAD_r,d_ENINPAD_f) ENINPAD_temp = ENINPAD;
  assign #(d_ENOUTPAD_r,d_ENOUTPAD_f) ENOUTPAD_temp = ENOUTPAD;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_Y) Y = Y_temp;
  assign
    ENINPADB = ( ~ ENINPAD_temp);
  assign
    ENOUTPADB = ( ~ ENOUTPAD_temp);
  padpup #(M,N,PULL_TYPE) pullud (PADPIN);
  paditrip #(M,N,PULL_TYPE) outri (ENOUTPADB,IN0_temp,PADPIN);
  paditri #(M,N) intri (ENINPADB,PADPIN,Y_temp);
endmodule
