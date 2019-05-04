/****************************************/
/*					*/
/*	Filename: bm_tb.v		*/
/*	Function: tests booth multiplier*/
/*	Last Edit: 3/18/2018		*/
/*	Owner: Travis Lenz		*/
/*					*/
/****************************************/
`timescale 1 ns / 100 ps

module bm_4b_tb (
a,
b,
c,
rst,
clk
);

bm_4b(
.a(a),
.b(b),
.c(c),
.rst(rst),
.clk(clk)
);

input [3:0] a, b;
input rst, clk;
output [3:0] c;

endmodule 

/*
do {C:/Users/Travis Lenz/Documents/School/EE 382M-23 Low Power Design/Project Related/ModelSim-BoothMult/bm_4b_wave.do}
force -repeat 20ns clk 0 0, 1 10ns
force rst 1 0, 0 20 ns
force a 4'h7 0 ns
force b 4'h2 0 ns
run 200 ns
*/