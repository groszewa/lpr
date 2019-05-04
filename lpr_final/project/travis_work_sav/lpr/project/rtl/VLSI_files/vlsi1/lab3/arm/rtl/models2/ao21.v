//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module ao21(IN0,IN1,IN2,Y);
  parameter N = 8;
  parameter DPFLAG = 0;
  parameter GROUP = "std";
  parameter
        d_IN0 = 0,
        d_IN1 = 0,
        d_IN2 = 0,
        d_Y = 1;
  input [(N - 1):0] IN0;
  input [(N - 1):0] IN1;
  input [(N - 1):0] IN2;
  output [(N - 1):0] Y;
  wire [(N - 1):0] IN0_temp;
  wire [(N - 1):0] IN1_temp;
  wire [(N - 1):0] IN2_temp;
  reg [(N - 1):0] Y_temp;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_IN1) IN1_temp = IN1;
  assign #(d_IN2) IN2_temp = IN2;
  assign #(d_Y) Y = Y_temp;
  initial
    begin
    if((DPFLAG == 1))
      $display("(WARNING) The instance %m of type ao21 can't be implemented as a data-path cell");
    end
  always
    @(IN0_temp or IN1_temp or IN2_temp)
      begin
      Y_temp = ((IN0_temp & IN1_temp) | IN2_temp);
      end
endmodule
