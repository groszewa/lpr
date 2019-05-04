//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module rom(A,DOUT);
  parameter N = 4;
  parameter WORDS = 64;
  parameter M = 6;
  parameter CODEFILE = "rom1.rom";
  parameter CPB = 8;
  parameter
        d_A = 0,
        d_DOUT = 1;
  input [(M - 1):0] A;
  output [(N - 1):0] DOUT;
  wire [(M - 1):0] A_temp;
  reg [(N - 1):0] DOUT_temp;
  reg [(N - 1):0] mem[0:(WORDS - 1)];
  assign #(d_A) A_temp = A;
  assign #(d_DOUT) DOUT = DOUT_temp;
  initial
    $readmemb(CODEFILE,mem);
  always
    @(A_temp)
      begin
      DOUT_temp = mem[A_temp];
      end
endmodule
