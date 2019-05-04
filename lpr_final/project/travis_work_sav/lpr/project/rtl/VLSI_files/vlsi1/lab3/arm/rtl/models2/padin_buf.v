//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padin_buf(PADPIN,Y);
  parameter M = 7;
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter LEVEL_SHIFTING = 0;
  parameter SCHMITT_TRIGGER = 0;
  parameter PULL_TYPE = "None";
  parameter YPITCH = "4MA";
  parameter
        d_PADPIN = 1,
        d_Y = 1;
  inout [M:N] PADPIN;
  output [M:N] Y;
  wire [M:N] PADPIN_temp;
  wire [M:N] Y_temp;
  supply1  VDD;
  assign #(d_Y) Y = Y_temp;
  padpup #(M,N,PULL_TYPE) pullud (PADPIN);
  padtri #(M,N) inbuff (VDD,PADPIN,Y_temp);
endmodule
