//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module scntr_generic(CLK,CLR,D,EN,PRE,PL,SCANIN,TEST,UP,COUT,Q);
  parameter N = 8;
  input  CLK;
  input  CLR;
  input [(N - 1):0] D;
  input  EN;
  input  PRE;
  input  PL;
  input  SCANIN;
  input  TEST;
  input  UP;
  output  COUT;
  output [(N - 1):0] Q;
  reg  COUT;
  reg [(N - 1):0] Q;
  reg  couttemp;
  reg  tempx;
  reg [(N - 1):0] temp;
  always
    @(PRE or CLR or UP or EN)
      begin
      if(((CLR == 1'b0) && (PRE == 1'b1)))
        begin
        temp = 128'b0;
        Q = temp;
        if(((UP == 1'b0) && (EN == 1'b1)))
          COUT = 1'b1;
        else
          COUT = 1'b0;
        end
      else      if(((PRE == 1'b0) && (CLR == 1'b1)))
        begin
        temp = ( ~ 128'b0);
        Q = temp;
        if(((UP == 1'b1) && (EN == 1'b1)))
          COUT = 1'b1;
        else
          COUT = 1'b0;
        end
      else      if(((CLR !== 1'b1) || (PRE !== 1'b1)))
        begin
        Q = 128'bx;
        COUT = 128'b0;
        end
      end
  always
    @(posedge CLK)
      if(((PRE == 1'b1) && (CLR == 1'b1)))
        begin
        temp = 128'bx;
        if((UP == 1'b0))
          tempx = ( | Q);
        else        if((UP == 1'b1))
          tempx = ( & Q);
        else
          tempx = ( ^ Q);
        if((((tempx !== 1'b1) && (tempx !== 1'b0)) && (EN == 1'b1)))
          couttemp = tempx;
        else
          couttemp = 1'b0;
        if((TEST == 1'b0))
          begin
          if((PL == 1'b0))
            begin
            if((EN == 1'b1))
              begin
              if((UP == 1'b1))
                begin
                temp = (Q + 1'b1);
                if((( ~ temp) == 1'b0))
                  couttemp = 1'b1;
                end
              else              if((UP == 1'b0))
                begin
                temp = (Q - 1'b1);
                if((temp == 1'b0))
                  couttemp = 1'b1;
                end
              end
            else            if((EN == 1'b0))
              begin
              temp = Q;
              end
            end
          else          if((PL == 1'b1))
            temp = D;
          end
        else        if((TEST == 1'b1))
          begin
          temp = Q;
          temp = (temp << 1);
          temp[0] = SCANIN;
          if((((UP == 1'b1) && (EN == 1'b1)) && (( ~ temp) == 1'b0)))
            couttemp = 1'b1;
          else          if((((UP == 1'b0) && (EN == 1'b1)) && (temp == 1'b0)))
            couttemp = 1'b1;
          end
        Q = temp;
        COUT = couttemp;
        end
endmodule
