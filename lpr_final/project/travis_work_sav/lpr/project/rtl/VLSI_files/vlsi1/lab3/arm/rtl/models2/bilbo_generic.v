//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module bilbo_generic(C1,C2,CLK,CLR,D,PRE,SDI,SCAN,SEL,Q,QBAR);
  parameter N = 8;
  input  C1;
  input  C2;
  input  CLK;
  input  CLR;
  input [(N - 1):0] D;
  input  PRE;
  input  SDI;
  input  SCAN;
  input  SEL;
  output [(N - 1):0] Q;
  output [(N - 1):0] QBAR;
  reg [(N - 1):0] Q;
  reg [(N - 1):0] QBAR;
  reg [(N - 1):0] temp;
  reg [(N - 1):0] DIN;
  reg  S;
  reg [1:0] C1and2;
  initial
    begin
    if(((N < 2) | (N > 32)))
      $display("(ERROR): bilbo: %m  has %d bits. (min = 2, max= 32) ",N);
    end
  always
    @(C1 or C2 or SDI or D or CLK)
      begin
      case(N)
      2 :         S = (Q[0] ^ Q[(N - 1)]);
      3 :         S = (Q[1] ^ Q[(N - 1)]);
      4 :         S = (Q[2] ^ Q[(N - 1)]);
      5 :         S = (Q[2] ^ Q[(N - 1)]);
      6 :         S = (Q[4] ^ Q[(N - 1)]);
      7 :         S = (Q[5] ^ Q[(N - 1)]);
      8 :         S = ((Q[6] ^ Q[(N - 1)]) ^ (Q[2] ^ Q[1]));
      9 :         S = (Q[4] ^ Q[(N - 1)]);
      10 :         S = (Q[6] ^ Q[(N - 1)]);
      11 :         S = (Q[8] ^ Q[(N - 1)]);
      12 :         S = ((Q[8] ^ Q[(N - 1)]) ^ (Q[7] ^ Q[4]));
      13 :         S = ((Q[11] ^ Q[(N - 1)]) ^ (Q[9] ^ Q[8]));
      14 :         S = ((Q[12] ^ Q[(N - 1)]) ^ (Q[2] ^ Q[1]));
      15 :         S = (Q[13] ^ Q[(N - 1)]);
      16 :         S = ((Q[13] ^ Q[(N - 1)]) ^ (Q[12] ^ Q[10]));
      17 :         S = (Q[13] ^ Q[(N - 1)]);
      18 :         S = (Q[10] ^ Q[(N - 1)]);
      19 :         S = ((Q[17] ^ Q[(N - 1)]) ^ (Q[13] ^ Q[12]));
      20 :         S = (Q[16] ^ Q[(N - 1)]);
      21 :         S = (Q[18] ^ Q[(N - 1)]);
      22 :         S = (Q[20] ^ Q[(N - 1)]);
      23 :         S = (Q[17] ^ Q[(N - 1)]);
      24 :         S = ((Q[22] ^ Q[(N - 1)]) ^ (Q[20] ^ Q[19]));
      25 :         S = (Q[21] ^ Q[(N - 1)]);
      26 :         S = ((Q[24] ^ Q[(N - 1)]) ^ (Q[18] ^ Q[17]));
      27 :         S = ((Q[25] ^ Q[(N - 1)]) ^ (Q[19] ^ Q[18]));
      28 :         S = (Q[24] ^ Q[(N - 1)]);
      29 :         S = (Q[26] ^ Q[(N - 1)]);
      30 :         S = ((Q[28] ^ Q[(N - 1)]) ^ (Q[14] ^ Q[13]));
      31 :         S = (Q[27] ^ Q[(N - 1)]);
      32 :         S = ((Q[30] ^ Q[(N - 1)]) ^ (Q[4] ^ Q[3]));
      default:
        begin
        end
      endcase
      C1and2 = {C1,C2};
      case(C1and2)
      2'b00 :         begin
        DIN = 128'b0;
        end
      2'b01 :         begin
        DIN = (Q << 1);
        if((SCAN == 1'b1))
          DIN[0] = S;
        else
          DIN[0] = SDI;
        end
      2'b10 :         begin
        DIN = D;
        end
      2'b11 :         begin
        if((SEL == 1'b1))
          DIN = ({Q[(N - 2):0],S} ^ D[(N - 1):0]);
        else
          DIN = ({Q[(N - 2):0],SDI} ^ D[(N - 1):0]);
        end
      endcase
      end
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
    @(posedge CLK)
      begin
      if(((PRE == 1'b1) && (CLR == 1'b1)))
        begin
        Q = DIN;
        QBAR = ( ~ DIN);
        end
      end
endmodule
