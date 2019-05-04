// 
// aop.v
// 
// David Van Campenhout
// 
// 
// 
 
`define dptype 1
`define stdcelltype 0
`define group_aop "group_main"

// scan chain:
//
// register	width
// ========	=====
// aop		32
// ========	=====
// total		32

/**************************************************************************

`define FORWARD_EX	2'b00
`define FORWARD_PC	2'b01
`define FORWARD_STAT	2'b10
`define FORWARD_NOT	2'b11

`define AOP_APORT	4'b0000
`define AOP_A		4'b0001
`define AOP_REGCOUNT	4'b0011
`define AOP_REGCOUNT1	4'b0111
`define AOP_4		4'b1011


**************************************************************************/

module aop( phi1, clear, test, scanin, scanout,
//		Wport, Aport, incAddress, aluOut, exc_addr,	-- changed by Jian Shen  1.11.99
		Wport, Aport, stat, mask, incAddress, mode, aluOut, exc_addr,
		regCount, regCount1, 
		forwardonA, Aop_sel, Aop);

 
  input		phi1;
  input		clear; 	// active low
  input		test;	// active high
  input		scanin;
  output		scanout;

  input [31:0]	Wport;
  input [31:0]	Aport;
  input [3:0]	stat;	
  input	[1:0]	mask;
  input [31:0]	aluOut;
  input  [2:0]	exc_addr;
  input [23:0]	incAddress;
  input [1:0]	mode;
  input [4:0]	regCount;
  input [3:0]	regCount1;

  input [1:0]	forwardonA;
  input [3:0]	Aop_sel;

  output [31:0]	Aop;

  wire [31:0] 	Aop_D;
  wire [31:0]	muxA;
  wire [4:0]	muxB;
  
  assign scanout = Aop[31];
  

  
  
  mux3 #( 32, `dptype, `group_aop)
	mux_Aop (	.IN0( Wport), 
//			.IN1( { 6'b0, incAddress[23:0], 2'b0}),	-- changed by Jian Shen 1.11.99
			.IN1( { stat, mask, incAddress[23:0], mode}),
			.IN2( muxA), 
			.S1( forwardonA[1]), .S0(forwardonA[0]), 
			.Y( Aop_D));

  mux4 #( 5, `stdcelltype, `group_aop)
	mux_B ( 	.IN0( regCount), 
			.IN1( {1'b0, regCount1}), 
			.IN2(5'b1),
			.IN3( {2'b0, exc_addr}),
			.S1( Aop_sel[3]), .S0( Aop_sel[2]), 
			.Y( muxB));

  mux3 #( 32, `dptype, `group_aop)
	mux_A ( .IN0( Aport), 
		.IN1( Aop), 
		.IN2( {25'b0, muxB, 2'b0}),
		.S1( Aop_sel[1]), .S0(Aop_sel[0]), 
		.Y(muxA));

  dffs_c #( 32, `dptype, `group_aop)
	Aop_ff ( .CLK( phi1), .CLR(clear), .D( Aop_D), .Q( Aop), 
		.SCANIN( scanin), .TEST(test));


endmodule

/*********************************************************************
  mux3 #( 32, `dptype, `group_aop)
	mux_forwardonA ( .IN0( Aport), .IN1( Wport), 
			.IN2( { 6'b0, incAddress[23:0], 2'b0}),
			.S1( forwardonA[1]), .S0(forwardonA[0]), 
			.Y( Aport_forwarded));

  mux3 #( 5, `stdcelltype, `group_aop)
	mux_regcountA ( .IN0( regCount), .IN1( {1'b0, regCount1}), .IN2(5'b1),
			.S1( Aop_special_sel[1]), .S0( Aop_special_sel[0]), 
			.Y( Aop_special));

  mux4 #( 32, `dptype, `group_aop)
	mux_A ( .IN0( Aport_forwarded), .IN1( aluOut), 
		.IN2( {25'b0, Aop_special, 2'b0}), .IN3( Aop), 
		.S1( Aop_sel[1]), .S0(Aop_sel[0]), .Y(Aop_D));

*********************************************************************/


