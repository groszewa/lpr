//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module sreg_generic(D,CLK,CLR,LSBIN,MSBIN,PRE,S0,S1,SCANIN,TEST,Q);
  parameter N = 8;
  input [(N - 1):0] D;
  input  CLK;
  input  CLR;
  input  LSBIN;
  input  MSBIN;
  input  PRE;
  input  S0;
  input  S1;
  input  SCANIN;
  input  TEST;
  output [(N - 1):0] Q;
  reg [(N - 1):0] Q;
  reg [(N - 1):0] temp;
  always
    @(PRE or CLR)
      begin
      if(((CLR == 1'b0) && (PRE == 1'b1)))
        begin
        Q = 128'b0;
        end
      else      if(((PRE == 1'b0) && (CLR == 1'b1)))
        begin
        Q = ( ~ 128'b0);
        end
      else      if(((CLR !== 1'b1) || (PRE !== 1'b1)))
        begin
        Q = 128'bx;
        end
      end
  always
    @(posedge CLK)
      if(((PRE == 1'b1) && (CLR == 1'b1)))
        begin
        temp = Q;
        if((TEST == 1'b0))
          begin
          case({S1,S0})
          2'b00 :             begin
            temp = (temp << 1);
            temp[0] = LSBIN;
            end
          2'b11 :             begin
            temp = (temp >> 1);
            temp[(N - 1)] = MSBIN;
            end
          2'b01 :             temp = temp;
          2'b10 :             temp = D;
          default:
            temp = 128'bx;
          endcase
          end
        else        if((TEST == 1'b1))
          begin
          temp = (temp << 1);
          temp[0] = SCANIN;
          end
        else
          temp = 128'bx;
        Q = temp;
        end
endmodule
