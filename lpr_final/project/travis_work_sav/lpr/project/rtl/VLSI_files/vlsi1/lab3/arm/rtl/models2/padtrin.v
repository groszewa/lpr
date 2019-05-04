//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padtrin(ENABLE,IBUS,OBUS);
  parameter M = 7;
  parameter N = 0;
  parameter PULL_TYPE = "None";
  input  ENABLE;
  input [M:N] IBUS;
  output [M:N] OBUS;
  reg [M:N] OBUS;
  integer U;
  integer L;
  integer i;
  initial
    begin
    L = N;
    U = M;
    if((N > M))
      begin
      L = M;
      U = N;
      end
    end
  always
    @(ENABLE or IBUS)
      begin
      if((ENABLE == 1'b1))
        begin
        for(i = L;(i <= U);i = (i + 1))
          begin
          if((IBUS[i] == 1'b0))
            OBUS[i] = 1'b0;
          else          if((IBUS[i] == 1'b1))
            OBUS[i] = 1'bz;
          else
            begin
            if((PULL_TYPE !== "Down"))
              OBUS[i] = 1'bx;
            end
          end
        end
      else      if((ENABLE == 1'b0))
        OBUS = 128'hz;
      else
        OBUS = 128'hx;
      end
endmodule
