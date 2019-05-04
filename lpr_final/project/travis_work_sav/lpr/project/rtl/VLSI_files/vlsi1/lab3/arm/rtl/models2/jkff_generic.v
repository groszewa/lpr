//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module jkff_generic(CLK,CLR,J,K,PRE,SCANIN,TEST,Q,QBAR);
  parameter N = 8;
  input  CLK;
  input  CLR;
  input [(N - 1):0] J;
  input [(N - 1):0] K;
  input  PRE;
  input  SCANIN;
  input  TEST;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  reg [(N - 1):0] Q;
  reg [(N - 1):0] QBAR;
  reg [(N - 1):0] temp;
  integer i;
  always
    @(PRE or CLR)
      begin
      if(((CLR == 1'b0) && (PRE == 1'b1)))
        begin
        temp = 128'b0;
        Q = temp;
        QBAR = ( ~ temp);
        end
      else      if(((PRE == 1'b0) && (CLR == 1'b1)))
        begin
        temp = ( ~ 128'b0);
        Q = temp;
        QBAR = ( ~ temp);
        end
      else      if(((CLR !== 1'b1) || (PRE !== 1'b1)))
        begin
        Q = 128'bx;
        QBAR = 128'bx;
        end
      end
  always
    @(posedge CLK)
      if(((PRE == 1'b1) && (CLR == 1'b1)))
        begin
        temp = 128'bx;
        if((TEST == 1'b0))
          temp = ((( ~ K) & (J | Q)) | (J & ( ~ Q)));
        else        if((TEST == 1'b1))
          begin
          temp = Q;
          temp = (temp << 1);
          temp[0] = SCANIN;
          end
        Q = temp;
        QBAR = ( ~ temp);
        end
endmodule
