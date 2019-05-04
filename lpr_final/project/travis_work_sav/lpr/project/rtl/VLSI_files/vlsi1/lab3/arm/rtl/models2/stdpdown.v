//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdpdown(PDOWN);
  parameter
        d_PDOWN_r = 1,
        d_PDOWN_f = 1;
  output  PDOWN;
  wire  PDOWN_temp;
  assign #(d_PDOWN_r,d_PDOWN_f) PDOWN = PDOWN_temp;
  assign (pull0,pull1)
    PDOWN_temp = 1'b0;
endmodule
