//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module hsmult2addpiped_cp(A,B,C,CLK,CLR,PRE,PROD);
  parameter AA = 6;
  parameter BB = 6;
  parameter CC = 12;
  parameter P = 12;
  parameter
        d_A = 0,
        d_B = 0,
        d_C = 0,
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_PROD = 1;
  input [(AA - 1):0] A;
  input [(BB - 1):0] B;
  input [(CC - 1):0] C;
  input  CLK;
  input  CLR;
  input  PRE;
  output [(P - 1):0] PROD;
  wire [(AA - 1):0] A_temp;
  wire [(BB - 1):0] B_temp;
  wire [(CC - 1):0] C_temp;
  wire  CLK_temp;
  wire  CLR_temp;
  wire  PRE_temp;
  wire [(P - 1):0] PROD_temp;
  assign #(d_A) A_temp = A;
  assign #(d_B) B_temp = B;
  assign #(d_C) C_temp = C;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_PROD) PROD = PROD_temp;
  multpipe2_generic #(AA,BB,CC,P) inst1 (A_temp,B_temp,C_temp,CLK_temp,CLR_temp,PRE_temp,PROD_temp);
  wire [127:0] A_tcheck = A;
  wire [127:0] B_tcheck = B;
  wire [127:0] C_tcheck = C;
  specify
    specparam
      t_setup_a = 0,
      t_hold_a = 0,
      t_setup_b = 0,
      t_hold_b = 0,
      acc_setup_time = 0,
      acc_hold_time = 0,
      t_width_clr = 0,
      t_width_pre = 0;
    $setup(A_tcheck , posedge CLK , t_setup_a);
    $hold(posedge CLK , A_tcheck , t_hold_a);
    $setup(B_tcheck , posedge CLK , t_setup_b);
    $hold(posedge CLK , B_tcheck , t_hold_b);
    $setup(C_tcheck , posedge CLK , acc_setup_time);
    $hold(posedge CLK , C_tcheck , acc_hold_time);
    $width(negedge CLR , t_width_clr);
    $width(negedge PRE , t_width_pre);
  endspecify
endmodule
