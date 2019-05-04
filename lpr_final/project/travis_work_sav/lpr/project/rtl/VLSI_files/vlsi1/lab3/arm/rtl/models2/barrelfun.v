//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module barrelfun(A,B,S,Y);
  parameter N = 8;
  parameter M = 3;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_A = 0,
        d_B = 0,
        d_S = 0,
        d_Y = 1;
  input [(N - 1):0] A;
  input [(N - 1):0] B;
  input [(M - 1):0] S;
  output [(N - 1):0] Y;
  wire [(N - 1):0] A_temp;
  wire [(N - 1):0] B_temp;
  wire [(M - 1):0] S_temp;
  reg [(N - 1):0] Y_temp;
  reg [((2 * N) - 1):0] temp;
  reg [((2 * N) - 1):0] temp0;
  reg [((2 * N) - 1):0] temp1;
  reg [((2 * N) - 1):0] temp2;
  assign #(d_A) A_temp = A|A;
  assign #(d_B) B_temp = B|B;
  assign #(d_S) S_temp = S;
  assign #(d_Y) Y = Y_temp;
  always
    @(A_temp or B_temp or S_temp)
      begin
      temp = {A_temp,B_temp};
      temp0 = (temp << S_temp);
      temp1 = (temp >> ((2 * N) - S_temp));
      if((S_temp > 0))
        temp2 = (temp0 | temp1);
      else
        temp2 = temp;
      Y_temp = temp2[((2 * N) - 1):N];
      end
endmodule
