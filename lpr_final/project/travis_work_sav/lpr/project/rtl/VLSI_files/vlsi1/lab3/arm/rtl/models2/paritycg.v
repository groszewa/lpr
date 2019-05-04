//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module paritycg(D,PIN,ERROR,PGEN);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_D = 0,
        d_PIN_r = 0,
        d_PIN_f = 0,
        d_ERROR_r = 1,
        d_ERROR_f = 1,
        d_PGEN_r = 1,
        d_PGEN_f = 1;
  input [(N - 1):0] D;
  input  PIN;
  output  ERROR;
  output  PGEN;
  wire [(N - 1):0] D_temp;
  wire  PIN_temp;
  reg  ERROR_temp;
  reg  PGEN_temp;
  reg  temp;
  assign #(d_D) D_temp = D;
  assign #(d_PIN_r,d_PIN_f) PIN_temp = PIN;
  assign #(d_ERROR_r,d_ERROR_f) ERROR = ERROR_temp;
  assign #(d_PGEN_r,d_PGEN_f) PGEN = PGEN_temp;
  always
    @(D_temp or PIN_temp)
      begin
      temp = ( ^ D_temp);
      PGEN_temp = temp;
      ERROR_temp = (temp ^ PIN_temp);
      end
endmodule
