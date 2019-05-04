//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module decoder(SEL,Y);
  parameter N = 8;
  parameter M = 6;
  parameter CODEFILE = "dec.pla";
  parameter
        d_SEL = 0,
        d_Y = 1;
  input [(N - 1):0] SEL;
  output [(M - 1):0] Y;
  wire [(N - 1):0] SEL_temp;
  reg [(M - 1):0] Y_temp;
  reg [(N - 1):0] mem[0:(M - 1)];
  reg [(N - 1):0] TS;
  reg [(N - 1):0] temp;
  reg  match;
  integer j;
  integer i;
  assign #(d_SEL) SEL_temp = SEL;
  assign #(d_Y) Y = Y_temp;
  initial
    begin
    $readmemb(CODEFILE,mem);
    end
  always
    @(SEL_temp)
      begin
      match = 1'b1;
      for(i = 0;(i < N);i = (i + 1))
        TS[i] = SEL_temp[((N - i) - 1)];
      for(i = 0;(i < M);i = (i + 1))
        begin
        if((mem[i] === TS))
          Y_temp[i] = 1'b1;
        else        if(((( ^ mem[i]) === 1'bx) || (( ^ TS) === 1'bx)))
          begin
          temp = mem[i];
          for(j = 0;((j < N) && match);j = (j + 1))
            if(((temp[j] !== TS[j]) && (temp[j] !== 1'bx)))
              match = 1'b0;
          Y_temp[i] = match;
          end
        else
          Y_temp[i] = 1'b0;
        end
      end
endmodule
