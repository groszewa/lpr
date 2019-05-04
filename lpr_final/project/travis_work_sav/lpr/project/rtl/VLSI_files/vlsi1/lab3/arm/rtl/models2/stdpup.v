//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module stdpup(PUP);
  parameter
        d_PUP_r = 1,
        d_PUP_f = 1;
  output  PUP;
  wire  PUP_temp;
  assign #(d_PUP_r,d_PUP_f) PUP = PUP_temp;
  assign (pull0,pull1)
    PUP_temp = 1'b1;
endmodule
