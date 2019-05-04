//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module compl(COMP,IN0,COUT,COUTBAR,Y);
  parameter N = 8;
  parameter DPFLAG = 1;
  parameter GROUP = "dpath1";
  parameter
        d_COMP_r = 0,
        d_COMP_f = 0,
        d_IN0 = 0,
        d_COUT_r = 1,
        d_COUT_f = 1,
        d_COUTBAR_r = 1,
        d_COUTBAR_f = 1,
        d_Y = 1;
  input  COMP;
  input [(N - 1):0] IN0;
  output  COUT;
  output  COUTBAR;
  output [(N - 1):0] Y;
  wire  COMP_temp;
  wire [(N - 1):0] IN0_temp;
  reg  COUT_temp;
  reg  COUTBAR_temp;
  reg [(N - 1):0] Y_temp;
  reg  temp;
  assign #(d_COMP_r,d_COMP_f) COMP_temp = COMP;
  assign #(d_IN0) IN0_temp = IN0|IN0;
  assign #(d_COUT_r,d_COUT_f) COUT = COUT_temp;
  assign #(d_COUTBAR_r,d_COUTBAR_f) COUTBAR = COUTBAR_temp;
  assign #(d_Y) Y = Y_temp;
  always
    @(IN0_temp or COMP_temp)
      begin
      if((COMP_temp == 1'b1))
        begin
        Y_temp = IN0_temp;
        COUT_temp = 1'b0;
        COUTBAR_temp = 1'b1;
        end
      else      if((COMP_temp == 1'b0))
        begin
        Y_temp = ( - IN0_temp);
        temp = ( | IN0_temp);
        if((temp == 1'b0))
          begin
          COUT_temp = 1'b0;
          COUTBAR_temp = 1'b1;
          end
        else        if((temp == 1'b1))
          begin
          COUT_temp = 1'b1;
          COUTBAR_temp = 1'b0;
          end
        else
          begin
          COUT_temp = 1'bx;
          COUTBAR_temp = 1'bx;
          end
        end
      else
        begin
        if((( | IN0_temp) == 1'b0))
          begin
          COUT_temp = 1'b0;
          COUTBAR_temp = 1'b1;
          end
        else
          begin
          COUT_temp = 1'bx;
          COUTBAR_temp = 1'bx;
          end
        Y_temp = 128'bx;
        end
      end
endmodule
