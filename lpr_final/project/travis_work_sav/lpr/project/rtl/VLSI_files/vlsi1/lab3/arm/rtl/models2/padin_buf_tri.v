//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padin_buf_tri(EN,PADPIN,Y);
  parameter M = 7;
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter LEVEL_SHIFTING = 0;
  parameter SCHMITT_TRIGGER = 0;
  parameter PULL_TYPE = "None";
  parameter YPITCH = "4MA";
  parameter
        d_EN_r = 0,
        d_EN_f = 0,
        d_PADPIN = 1,
        d_Y = 1;
  input  EN;
  inout [M:N] PADPIN;
  output [M:N] Y;
  wire  EN_temp;
  wire [M:N] PADPIN_temp;
  wire [M:N] Y_temp;
  wire  ENBAR;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_Y) Y = Y_temp;
  assign
    ENBAR = ( ~ EN_temp);
  padpup #(M,N,PULL_TYPE) pullud (PADPIN);
  padtri #(M,N) inbuff (ENBAR,PADPIN,Y_temp);
endmodule
