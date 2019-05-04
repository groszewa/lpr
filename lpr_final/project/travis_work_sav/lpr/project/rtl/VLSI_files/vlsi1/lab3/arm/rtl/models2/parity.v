//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module parity(D,PGEN);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_D = 0,
        d_PGEN_r = 1,
        d_PGEN_f = 1;
  input [(N - 1):0] D;
  output  PGEN;
  wire [(N - 1):0] D_temp;
  reg  PGEN_temp;
  assign #(d_D) D_temp = D;
  assign #(d_PGEN_r,d_PGEN_f) PGEN = PGEN_temp;
  always
    @(D_temp)
      begin
      PGEN_temp = ( ^ D_temp);
      end
endmodule
