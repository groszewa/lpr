//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module equal(A,B,Y);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_A = 0,
        d_B = 0,
        d_Y_r = 1,
        d_Y_f = 1;
  input [(N - 1):0] A;
  input [(N - 1):0] B;
  output  Y;
  wire [(N - 1):0] A_temp;
  wire [(N - 1):0] B_temp;
  reg  Y_temp;
  assign #(d_A) A_temp = A;
  assign #(d_B) B_temp = B;
  assign #(d_Y_r,d_Y_f) Y = Y_temp;
  always
    @(A_temp or B_temp)
      begin
      if((((A_temp==A_temp)===1'bx) || ((B_temp==B_temp)===1'bx)))
        Y_temp = 1'bx;
      else      if((A_temp == B_temp))
        Y_temp = 1'b1;
      else
        Y_temp = 1'b0;
      end
endmodule
