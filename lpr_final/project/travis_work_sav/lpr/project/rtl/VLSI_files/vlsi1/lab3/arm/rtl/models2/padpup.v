//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padpup(PADPIN);
  parameter M = 7;
  parameter N = 0;
  parameter PULL_TYPE = "None";
  output [M:N] PADPIN;
  reg [M:N] interm;
  initial
    begin
    if((PULL_TYPE == "Up"))
      interm = ( ~ 0);
    else    if((PULL_TYPE == "None"))
      interm = 128'bz;
    else
      interm = 0;
    end
  assign (pull0,pull1)
    PADPIN = interm;
endmodule
