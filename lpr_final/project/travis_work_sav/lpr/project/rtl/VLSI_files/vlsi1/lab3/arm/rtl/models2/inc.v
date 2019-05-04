//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module inc(EN,IN0,TC,TCBAR,Y);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_EN_r = 0,
        d_EN_f = 0,
        d_IN0 = 0,
        d_TC_r = 1,
        d_TC_f = 1,
        d_TCBAR_r = 1,
        d_TCBAR_f = 1,
        d_Y = 1;
  input  EN;
  input [(N - 1):0] IN0;
  output  TC;
  output  TCBAR;
  output [(N - 1):0] Y;
  wire  EN_temp;
  wire [(N - 1):0] IN0_temp;
  reg  TC_temp;
  reg  TCBAR_temp;
  reg [(N - 1):0] Y_temp;
  reg [N:0] SUM;
  assign #(d_EN_r,d_EN_f) EN_temp = EN;
  assign #(d_IN0) IN0_temp = IN0|IN0;
  assign #(d_TC_r,d_TC_f) TC = TC_temp;
  assign #(d_TCBAR_r,d_TCBAR_f) TCBAR = TCBAR_temp;
  assign #(d_Y) Y = Y_temp;
  always
    @(EN_temp or IN0_temp)
      begin
      if((EN_temp == 1'b0))
        begin
        Y_temp = IN0_temp;
        TC_temp = 1'b0;
        TCBAR_temp = 1'b1;
        end
      else      if((EN_temp == 1'b1))
        begin
        SUM = ({1'b0,IN0_temp} + 1'b1);
        TC_temp = SUM[N];
        TCBAR_temp = ( ~ SUM[N]);
        Y_temp = SUM[(N - 1):0];
        end
      else
        begin
        TC_temp = 128'bx;
        TCBAR_temp = 128'bx;
        Y_temp = 128'bx;
        end
      end
endmodule
