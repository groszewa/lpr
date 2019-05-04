//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module parityco(D,PIN,ERROR);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_D = 0,
        d_PIN_r = 0,
        d_PIN_f = 0,
        d_ERROR_r = 1,
        d_ERROR_f = 1;
  input [(N - 1):0] D;
  input  PIN;
  output  ERROR;
  wire [(N - 1):0] D_temp;
  wire  PIN_temp;
  reg  ERROR_temp;
  assign #(d_D) D_temp = D;
  assign #(d_PIN_r,d_PIN_f) PIN_temp = PIN;
  assign #(d_ERROR_r,d_ERROR_f) ERROR = ERROR_temp;
  always
    @(D_temp or PIN_temp)
      begin
      ERROR_temp = (( ~ ( ^ D_temp)) ^ PIN_temp);
      end
endmodule
