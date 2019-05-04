//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module lou(A,B,S0,S1,S2,S3,Y);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_A = 0,
        d_B = 0,
        d_S0_r = 0,
        d_S0_f = 0,
        d_S1_r = 0,
        d_S1_f = 0,
        d_S2_r = 0,
        d_S2_f = 0,
        d_S3_r = 0,
        d_S3_f = 0,
        d_Y = 1;
  input [(N - 1):0] A;
  input [(N - 1):0] B;
  input  S0;
  input  S1;
  input  S2;
  input  S3;
  output [(N - 1):0] Y;
  wire [(N - 1):0] A_temp;
  wire [(N - 1):0] B_temp;
  wire  S0_temp;
  wire  S1_temp;
  wire  S2_temp;
  wire  S3_temp;
  reg [(N - 1):0] Y_temp;
  reg [3:0] s;
  assign #(d_A) A_temp = A|A;
  assign #(d_B) B_temp = B|B;
  assign #(d_S0_r,d_S0_f) S0_temp = S0;
  assign #(d_S1_r,d_S1_f) S1_temp = S1;
  assign #(d_S2_r,d_S2_f) S2_temp = S2;
  assign #(d_S3_r,d_S3_f) S3_temp = S3;
  assign #(d_Y) Y = Y_temp;
  initial
    begin
    if((DPFLAG == 0))
      $display("(WARNING) The instance %m of type lou can't be implemented as a standard cell.");
    end
  always
    @(A_temp or B_temp or S0_temp or S1_temp or S2_temp or S3_temp)
      begin
      s[3] = S3_temp;
      s[2] = S2_temp;
      s[1] = S1_temp;
      s[0] = S0_temp;
      case(s)
      4'd0 :         Y_temp = ( ~ 128'b0);
      4'd1 :         Y_temp = (( ~ A_temp) | B_temp);
      4'd2 :         Y_temp = ( ~ (A_temp & B_temp));
      4'd3 :         Y_temp = ( ~ A_temp);
      4'd4 :         Y_temp = (A_temp | ( ~ B_temp));
      4'd5 :         Y_temp = ( ~ (A_temp ^ B_temp));
      4'd6 :         Y_temp = ( ~ B_temp);
      4'd7 :         Y_temp = ( ~ (A_temp | B_temp));
      4'd8 :         Y_temp = (A_temp | B_temp);
      4'd9 :         Y_temp = B_temp;
      4'd10 :         Y_temp = (A_temp ^ B_temp);
      4'd11 :         Y_temp = (( ~ A_temp) & B_temp);
      4'd12 :         Y_temp = A_temp;
      4'd13 :         Y_temp = (A_temp & B_temp);
      4'd14 :         Y_temp = (A_temp & ( ~ B_temp));
      4'd15 :         Y_temp = 128'b0;
      default:
        Y_temp = 128'bx;
      endcase
      end
endmodule
