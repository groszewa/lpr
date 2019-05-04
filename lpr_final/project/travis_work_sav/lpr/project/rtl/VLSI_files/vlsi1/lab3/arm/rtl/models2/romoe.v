//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module romoe(A,OE,DOUT);
  parameter N = 4;
  parameter WORDS = 64;
  parameter M = 6;
  parameter CODEFILE = "rom1.rom";
  parameter CPB = 8;
  parameter
        d_A = 0,
        d_OE_r = 0,
        d_OE_f = 0,
        d_DOUT = 1;
  input [(M - 1):0] A;
  input  OE;
  output [(N - 1):0] DOUT;
  wire [(M - 1):0] A_temp;
  wire  OE_temp;
  reg [(N - 1):0] DOUT_temp;
  reg [(N - 1):0] mem[0:(WORDS - 1)];
  assign #(d_A) A_temp = A;
  assign #(d_OE_r,d_OE_f) OE_temp = OE;
  assign #(d_DOUT) DOUT = DOUT_temp;
  initial
    $readmemb(CODEFILE,mem);
  always
    @(A_temp or OE_temp)
      begin
      if((OE_temp == 1'b0))
        DOUT_temp = mem[A_temp];
      else      if((OE_temp == 1'b1))
        DOUT_temp = 128'bz;
      else
        DOUT_temp = 128'bx;
      end
endmodule
