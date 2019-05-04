//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padbiuni_invin(EN,IN0,PADPIN,Y);
  parameter M = 7;
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter OUTDRIVE = "4MA";
  parameter LEVEL_SHIFTING = 0;
  parameter SCHMITT_TRIGGER = 0;
  parameter PULL_TYPE = "None";
  parameter
        d_EN_r = 0,
        d_EN_f = 0,
        d_IN0 = 0,
        d_PADPIN = 1,
        d_Y = 1;
  input  EN;
  input [M:N] IN0;
  inout [M:N] PADPIN;
  output [M:N] Y;
  wire  EN_temp;
  wire [M:N] IN0_temp;
  wire [M:N] PADPIN_temp;
  wire [M:N] Y_temp;
  supply1  VDD;
  wire  ENBAR;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_Y) Y = Y_temp;
  assign
    ENBAR = ( ~ EN_temp);
  padpup #(M,N,PULL_TYPE) pullud (PADPIN);
  padtri #(M,N) outri (ENBAR,IN0_temp,PADPIN);
  paditri #(M,N) intri (VDD,PADPIN,Y_temp);
endmodule
