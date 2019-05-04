//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module hsmultadd(A,B,C,PROD);
  parameter AA = 6;
  parameter BB = 6;
  parameter CC = 12;
  parameter P = 12;
  parameter
        d_A = 0,
        d_B = 0,
        d_C = 0,
        d_PROD = 1;
  input [(AA - 1):0] A;
  input [(BB - 1):0] B;
  input [(CC - 1):0] C;
  output [(P - 1):0] PROD;
  wire [(AA - 1):0] A_temp;
  wire [(BB - 1):0] B_temp;
  wire [(CC - 1):0] C_temp;
  wire [(P - 1):0] PROD_temp;
  assign #(d_A) A_temp = A;
  assign #(d_B) B_temp = B;
  assign #(d_C) C_temp = C;
  assign #(d_PROD) PROD = PROD_temp;
  mult_generic #(AA,BB,CC,P) inst1 (A_temp,B_temp,C_temp,PROD_temp);
endmodule
