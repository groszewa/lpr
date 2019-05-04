`timescale 1 ns / 100 ps



module counter #(
    //Top level block parameters
    parameter WIDTH = 4
) (
	out,
	clk,
    en,
	rst
);

   

//Output ports
output reg [WIDTH-1:0] out;

//Input ports
input clk;
input rst;
input en;
   



always @(posedge clk) begin
  if (rst) begin
    out <= 0;
  end else if (en) begin
    out <= out + 1;
  end
end
endmodule //lfsr_10bit


