//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padout_inv_tri_p(EN,IN0,PADPIN);
  parameter M = 7;
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter OUTDRIVE = "4MA";
  parameter
        d_EN_r = 0,
        d_EN_f = 0,
        d_IN0 = 0,
        d_PADPIN = 1;
  input  EN;
  input [M:N] IN0;
  output [M:N] PADPIN;
  wire  EN_temp;
  wire [M:N] IN0_temp;
  wire [M:N] PADPIN_temp;
  wire  ENBAR;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_PADPIN) PADPIN = PADPIN_temp;
  assign
    ENBAR = ( ~ EN_temp);
  paditrip #(M,N,"None") outtri (ENBAR,IN0_temp,PADPIN_temp);
endmodule
