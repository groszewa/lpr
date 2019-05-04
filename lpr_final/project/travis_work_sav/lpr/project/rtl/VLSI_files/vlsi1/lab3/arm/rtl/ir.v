// 
// ir.v
// 
// David Van Campenhout
// 
// instruction queue
// 

`define dptype 1
`define stdcelltype 0
`define group_ir "group_ir"

// scan chain:
//
// register	width
// ======== 	=====
// IR1		32
// IR2		32
// IRcurr		32
// ======== 	=====
// total		96

// gated clocks

module ir( phi1, phi2, clear, test, scanin, scanout,
		dataBus, enIR1, enIR2, enIRcurr, selIR2,
		IR, IRcurr);

  input 	phi1;
  input	phi2; 
  input	clear;
  input 	test;
  input 	scanin;
  output	scanout;
  


  input [31:0] 	dataBus;
  input 	enIR1;
  input 	enIR2;
  input 	enIRcurr;
  input 	selIR2;

  output [31:0] IR;
  output [31:0] IRcurr;

  wire [31:0]	IR1;
  wire [31:0]	IR2;
  
  wire 		enIR1_phi2;
  wire 		enIR2_phi2;
  wire		enIRcurr_phi2;
  wire 		clk_IR1;
  wire 		clk_IR2;
  wire		clk_IRcurr;

  assign  	scanout =	IRcurr[31];
  
  stdlatch latch_enIR1( .D( enIR1), .Q( enIR1_phi2), .EN( phi2));
//  stdand2	and_enIR1( .IN0( enIR1_phi2), .IN1( phi1), .Y( clk_IR1));
  stdoa21	oa_enIR1( .IN0( enIR1_phi2), .IN1( test), .IN2( phi1), .Y( clk_IR1));

  dffs_c #(32, `dptype, `group_ir)
      IR1_ff( .CLK( clk_IR1), .CLR(clear), .D(dataBus), 
	        .SCANIN(scanin), .TEST(test),
		.Q(IR1));

  stdlatch latch_enIR2( .D( enIR2), .Q( enIR2_phi2), .EN( phi2));
//  stdand2	and_enIR2( .IN0( enIR2_phi2), .IN1( phi1), .Y( clk_IR2));
  stdoa21	oa_enIR2( .IN0( enIR2_phi2), .IN1( test), .IN2( phi1), .Y( clk_IR2));

  dffs_c #(32, `dptype, `group_ir)
      IR2_ff( .CLK(clk_IR2), .CLR( clear), .D(IR1), 
		.SCANIN( IR1[31]), .TEST(test),
		.Q(IR2));

  mux2 #(32, `dptype, `group_ir)
      mux_IR( .IN0( IR1), .IN1( IR2), .S0( selIR2), .Y(IR));

  stdlatch latch_enIRcurr( .D( enIRcurr), .Q( enIRcurr_phi2), .EN( phi2));
//  stdand2	and_enIRcurr( .IN0( enIRcurr_phi2), .IN1( phi1), .Y( clk_IRcurr));
  stdoa21	oa_enIRcurr( .IN0( enIRcurr_phi2), .IN1( test), .IN2( phi1), 
  					.Y( clk_IRcurr));
  
  dffs_c #(32, `dptype, `group_ir)
      IRcurr_ff( .CLK( clk_IRcurr), .CLR(clear), .D(IR), 
		.SCANIN( IR2[31]), .TEST(test),
		.Q(IRcurr));

endmodule
