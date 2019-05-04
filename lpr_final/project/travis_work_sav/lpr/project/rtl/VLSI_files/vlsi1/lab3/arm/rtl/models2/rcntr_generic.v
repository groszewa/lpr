//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module rcntr_generic(CLK,PRE,CLR,SCANIN,TEST,TESTCLK,Q,QBAR);
  parameter N = 32;
  parameter DPATH = "dpath1";
  input  CLK;
  input  PRE;
  input  CLR;
  input  SCANIN;
  input  TEST;
  input  TESTCLK;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  reg [(N - 1):0] Q;
  reg [(N - 1):0] QBAR;
  reg [(N - 1):0] temp;
  always
    @(PRE or CLR)
      begin
      if(((CLR == 1'b0) && (PRE == 1'b1)))
        begin
        Q = 128'b0;
        QBAR = ( ~ 128'b0);
        end
      else      if(((PRE == 1'b0) && (CLR == 1'b1)))
        begin
        Q = ( ~ 128'b0);
        QBAR = 128'b0;
        end
      else      if(((CLR !== 1'b1) || (PRE !== 1'b1)))
        begin
        Q = 128'bx;
        QBAR = 128'bx;
        end
      end
  always
    @(posedge TESTCLK)
      if((((PRE == 1'b1) && (CLR == 1'b1)) && (TEST == 1'b1)))
        begin
        temp = (Q << 1);
        temp[0] = SCANIN;
        Q = temp;
        QBAR = ( ~ temp);
        end
      else      if((TEST === 1'bx))
        begin
        Q = 128'bx;
        QBAR = 128'bx;
        end
  always
    @(posedge CLK)
      if((((PRE == 1'b1) && (CLR == 1'b1)) && (TEST == 1'b0)))
        begin
        temp = (Q + 1'b1);
        Q = temp;
        QBAR = ( ~ temp);
        end
      else      if((TEST === 1'bx))
        begin
        Q = 128'bx;
        QBAR = 128'bx;
        end
endmodule
