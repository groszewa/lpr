//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module hsmult2piped_c(A,B,CLK,CLR,PROD);
  parameter AA = 6;
  parameter BB = 6;
  parameter P = 12;
  parameter
        d_A = 0,
        d_B = 0,
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_CLR_r = 0,
        d_CLR_f = 0,
        d_PROD = 1;
  input [(AA - 1):0] A;
  input [(BB - 1):0] B;
  input  CLK;
  input  CLR;
  output [(P - 1):0] PROD;
  wire [(AA - 1):0] A_temp;
  wire [(BB - 1):0] B_temp;
  wire  CLK_temp;
  wire  CLR_temp;
  wire [(P - 1):0] PROD_temp;
  supply0 [0:0] GND;
  supply1  VDD;
  assign #(d_A) A_temp = A;
  assign #(d_B) B_temp = B;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_CLR_r,d_CLR_f) CLR_temp = CLR;
  assign #(d_PROD) PROD = PROD_temp;
  multpipe2_generic #(AA,BB,1,P) inst1 (A_temp,B_temp,GND,CLK_temp,CLR_temp,VDD,PROD_temp);
  wire [127:0] A_tcheck = A;
  wire [127:0] B_tcheck = B;
  specify
    specparam
      t_setup_a = 0,
      t_hold_a = 0,
      t_setup_b = 0,
      t_hold_b = 0,
      t_width_clr = 0;
    $setup(A_tcheck , posedge CLK , t_setup_a);
    $hold(posedge CLK , A_tcheck , t_hold_a);
    $setup(B_tcheck , posedge CLK , t_setup_b);
    $hold(posedge CLK , B_tcheck , t_hold_b);
    $width(negedge CLR , t_width_clr);
  endspecify
endmodule
