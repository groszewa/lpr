//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padbi_invout(EN,DIR,BISIG,PADPIN);
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
        d_DIR_r = 0,
        d_DIR_f = 0,
        d_BISIG = 1,
        d_PADPIN = 1;
  input  EN;
  input  DIR;
  inout [M:N] BISIG;
  inout [M:N] PADPIN;
  wire  EN_temp;
  wire  DIR_temp;
  wire [M:N] BISIG_temp;
  wire [M:N] PADPIN_temp;
  wire  IC;
  wire  OC;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_DIR_r,d_DIR_f) DIR_temp = DIR;
  padpup #(M,N,PULL_TYPE) pullud (PADPIN);
  paditri #(M,N) outri (OC,BISIG,PADPIN);
  padtri #(M,N) intri (IC,PADPIN,BISIG);
  padcntr cntr1 (DIR_temp,EN_temp,IC,OC);
endmodule
