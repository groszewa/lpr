//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module multpipe2_generic(A,B,C,CLK,CLR,PRE,PROD);
  parameter AA = 6;
  parameter BB = 6;
  parameter CC = 12;
  parameter P = 12;
  input [(AA - 1):0] A;
  input [(BB - 1):0] B;
  input [(CC - 1):0] C;
  input  CLK;
  input  CLR;
  input  PRE;
  output [(P - 1):0] PROD;
  reg [(P - 1):0] PROD;
  reg [(P - 1):0] pp;
  reg [(P - 1):0] pipe;
  reg [(P - 1):0] megp;
  reg [(AA - 1):0] mega;
  reg [(BB - 1):0] megb;
  reg  sign;
  reg [((P - CC) - 1):0] VDDBUS;
  reg [((P - CC) - 1):0] GNDBUS;
  reg [(P - 1):0] C2;
  initial
    begin
    VDDBUS = ( ~ 128'b0);
    GNDBUS = 128'b0;
    end
  always
    @(CLR or PRE)
      begin
      if(((CLR == 1'b0) && (PRE == 1'b1)))
        PROD = 128'b0;
      else      if(((PRE == 1'b0) && (CLR == 1'b1)))
        PROD = ( ~ 128'b0);
      else      if(((CLR !== 1'b1) || (PRE !== 1'b1)))
        PROD = 128'bx;
      end
  always
    @(posedge CLK)
      begin
      if(((CLR == 1'b1) && (PRE == 1'b1)))
        begin
        PROD = pipe;
        if((A[(AA - 1)] == 1'b1))
          mega = (( ~ A) + 1'd1);
        else
          mega = A;
        if((B[(BB - 1)] == 1'b1))
          megb = (( ~ B) + 1'd1);
        else
          megb = B;
        megp = (mega * megb);
        sign = (A[(AA - 1)] ^ B[(BB - 1)]);
        if((sign == 1'b0))
          pp = megp;
        else
          pp = (( ~ megp) + 1'd1);
        if((C[(CC - 1)] == 1'b1))
          C2 = {VDDBUS,C};
        else
          C2 = {GNDBUS,C};
        if((CC > 0))
          pipe = (pp + C2);
        else
          pipe = pp;
        end
      end
endmodule
