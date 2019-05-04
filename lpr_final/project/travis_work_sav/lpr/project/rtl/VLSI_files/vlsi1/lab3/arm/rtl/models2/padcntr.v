//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module padcntr(DIR,EN,IC,OC);
  input  DIR;
  input  EN;
  output  IC;
  output  OC;
  reg  IC;
  reg  OC;
  always
    @(EN or DIR)
      begin
      if((EN == 1'b0))
        begin
        if((DIR == 1'b1))
          begin
          IC = 1'b1;
          OC = 1'b0;
          end
        else        if((DIR == 1'b0))
          begin
          IC = 1'b0;
          OC = 1'b1;
          end
        else
          begin
          IC = 1'bx;
          OC = 1'bx;
          end
        end
      else      if((EN == 1'b1))
        begin
        IC = 1'b0;
        OC = 1'b0;
        end
      else
        begin
        IC = 1'bx;
        OC = 1'bx;
        end
      end
endmodule
