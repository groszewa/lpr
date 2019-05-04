//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padout_inv(IN0,PADPIN);
  parameter M = 7;
  parameter N = 0;
  parameter SLIM_FLAG = 0;
  parameter OUTDRIVE = "4MA";
  parameter
        d_IN0 = 0,
        d_PADPIN = 1;
  input [M:N] IN0;
  output [M:N] PADPIN;
  wire [M:N] IN0_temp;
  reg [M:N] PADPIN_temp;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_PADPIN) PADPIN = PADPIN_temp;
  always
    @(IN0_temp)
      PADPIN_temp = ( ~ IN0_temp);
endmodule
