//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module dffst_p(CLK,D,PRE,SCANIN,TEST,Q,SCANOUT);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_CLK_r = 0,
        d_CLK_f = 0,
        d_D = 0,
        d_PRE_r = 0,
        d_PRE_f = 0,
        d_SCANIN_r = 0,
        d_SCANIN_f = 0,
        d_TEST_r = 0,
        d_TEST_f = 0,
        d_Q = 1,
        d_SCANOUT_r = 1,
        d_SCANOUT_f = 1;
  input  CLK;
  input [(N - 1):0] D;
  input  PRE;
  input  SCANIN;
  input  TEST;
  output [(N - 1):0] Q;
  output  SCANOUT;
  wire  CLK_temp;
  wire [(N - 1):0] D_temp;
  wire  PRE_temp;
  wire  SCANIN_temp;
  wire  TEST_temp;
  reg [(N - 1):0] Q_temp;
  reg  SCANOUT_temp;
  supply0  GND;
  supply1  VDD;
  wire [(N - 1):0] t;
  assign #(d_CLK_r,d_CLK_f) CLK_temp = CLK;
  assign #(d_D) D_temp = D|D;
  assign #(d_PRE_r,d_PRE_f) PRE_temp = PRE;
  assign #(d_SCANIN_r,d_SCANIN_f) SCANIN_temp = SCANIN|SCANIN;
  assign #(d_TEST_r,d_TEST_f) TEST_temp = TEST;
  assign #(d_Q) Q = Q_temp;
  assign #(d_SCANOUT_r,d_SCANOUT_f) SCANOUT = SCANOUT_temp;
  always
    @(t or D_temp or TEST_temp)
      begin
      case(TEST_temp)
      1'b0 :         begin
        Q_temp = t;
        end
      1'b1 :         begin
        Q_temp = D_temp;
        end
      default:
        Q_temp = 128'bx;
      endcase
      SCANOUT_temp = t[(N - 1)];
      end
  dff_generic #(N) inst1 (CLK_temp,VDD,D_temp,GND,PRE_temp,SCANIN_temp,TEST_temp,t);
  wire [127:0] D_tcheck = D;
  specify
    specparam
      t_hold_D = 0,
      t_setup_D = 0,
      t_width_PRE = 0,
      t_hold_SCANIN = 0,
      t_setup_SCANIN = 0,
      t_hold_TEST = 0,
      t_setup_TEST = 0;
    $hold(posedge CLK , D_tcheck , t_hold_D);
    $setup(D_tcheck , posedge CLK , t_setup_D);
    $width(negedge PRE , t_width_PRE);
    $hold(posedge CLK , SCANIN , t_hold_SCANIN);
    $setup(SCANIN , posedge CLK , t_setup_SCANIN);
    $hold(posedge CLK , TEST , t_hold_TEST);
    $setup(TEST , posedge CLK , t_setup_TEST);
  endspecify
endmodule