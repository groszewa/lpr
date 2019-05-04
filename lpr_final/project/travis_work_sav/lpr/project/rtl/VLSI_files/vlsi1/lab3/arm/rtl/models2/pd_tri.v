//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module pd_tri(INN,INP,OUT);
  input  INN;
  input  INP;
  output  OUT;
  reg  OUT;
  always
    @(INN or INP)
      begin
      if(((INN == 1'b0) && (INP == 1'b0)))
        OUT = 1'b1;
      else      if(((INN == 1'b0) && (INP == 1'b1)))
        OUT = 1'bz;
      else      if(((INN == 1'b1) && (INP == 1'b0)))
        OUT = 1'bx;
      else      if(((INN == 1'b1) && (INP == 1'b1)))
        OUT = 1'b0;
      else
        OUT = 1'bx;
      end
endmodule
