// 
// bop.v
// 
// David Van Campenhout
// 
// 
// 
 
`define dptype 1
`define stdcelltype 0
`define group_bop "group_main"
`define group_bop12 "group_main"

// scan chain:
//
// register	width
// ======== 	=====
// bop		32
// ======== 	=====
// total		32

/*********************************************************************
`define FORWARD_EX	2'b00
`define FORWARD_PC	2'b01
`define FORWARD_STAT	2'b10
`define FORWARD_NOT	2'b11


`define BOP_IMM		4'b0111
`define BOP_LDST		4'b1111
`define BOP_REGCOUNT	4'b0011

`define BOP_BPORT		4'b0000
`define BOP_SHIFTOUT	4'b0001
`define BOP_BRANCH		4'b0010
`define BOP_B			4'b0110

*********************************************************************/

module bop( phi1, clear, test, scanin, scanout, 
		Wport, Bport, stat, mask, incAddress, mode, aluFlags,
		regCount, IR, BopShifted,
		forwardonB, Bop_sel, Bop);
 
  input		phi1;
  input		clear; 
  input		test;
  input		scanin;
  output		scanout;

  input [31:0]	Wport;
  input [31:0]	Bport;
  input [3:0]	stat;	
  input [3:0]	aluFlags;
  input	[1:0]	mask;
  input [23:0]	incAddress;
  input [1:0]	mode;
  input [4:0]	regCount;
  input	[23:0]	IR;
  input [31:0]	BopShifted;

  input [1:0]	forwardonB;
  input [3:0]	Bop_sel;

  output [31:0]	Bop;

  wire [31:0]	muxA;
  wire [31:0]	muxB;
  wire [11:0]	muxC;
  wire [31:0] 	Bop_D;

  assign scanout = Bop[31];

  mux3 #( 28, `dptype, `group_bop)
	mux_Bop28 (.IN0( Wport[27:0]), 
			.IN1( { mask, incAddress[23:0], mode}),
			.IN2( muxA[27:0]), 
			.S1( forwardonB[1]), .S0(forwardonB[0]), 
			.Y( Bop_D[27:0]));

  mux4 #( 4, `stdcelltype, `group_bop)
	mux_Bop4 ( 	.IN0( Wport[31:28]), 
	       		.IN1( stat), 
	       		.IN2( aluFlags),
			.IN3( muxA[31:28]), 
	        	.S1( forwardonB[1]), .S0(forwardonB[0]), 
			.Y( Bop_D[31:28]));

  mux4 #( 32, `dptype, `group_bop)
	mux_BopA ( 	.IN0( Bport),
			.IN1( BopShifted), 
			.IN2( muxB),
			.IN3( {20'b0,muxC}),
			.S1( Bop_sel[1]), .S0( Bop_sel[0]),
			.Y( muxA));
  
  mux2 #( 32, `dptype, `group_bop)
	mux_BopB ( 	.IN0( { 6'b0, IR[23:0], 2'b0}), 
			.IN1( Bop), 
			.S0(Bop_sel[2]),
			.Y( muxB));


  mux3 #( 12, `dptype, `group_bop12)
	mux_BopC (	.IN0( {5'b0, regCount, 2'b0}),
			.IN1( {4'b0, IR[7:0]}),
			.IN2( {IR[11:0]}),
			.S0( Bop_sel[2]),
			.S1( Bop_sel[3]),
			.Y( muxC));

  dffs_c #( 32, `dptype, `group_bop)
	Bop_ff ( 	.CLK( phi1), .CLR( clear), .SCANIN( scanin), .TEST(test),
			.D( Bop_D), .Q( Bop));


endmodule





  
/*************************************************************************
  mux3 #( 32, `dptype, `group_bop)
	mux_forwardonB ( .IN0( Bport), .IN1( Wport), 
			.IN2( { stat, mask, incAddress[23:0], mode}),
			.S1( forwardonB[1]), .S0(forwardonB[0]), 
			.Y( Bport_forwarded));
*************************************************************************/

/*************************************************************************
  mux3 #( 28, `dptype, `group_bop)
	mux_forwardonB ( .IN0( Bport[27:0]), .IN1( Wport[27:0]), 
			.IN2( { mask, incAddress[23:0], mode}),
			.S1( forwardonB[1]), .S0(forwardonB[0]), 
			.Y( Bport_forwarded[27:0]));

  mux4 #( 4, `dptype, `group_bop)
	mux_forwardonBtop4 ( .IN0( Bport[31:28]), .IN1( Wport[31:28]), 
			.IN2( stat), .IN3( aluFlags),
			.S1( forwardonBtop4[1]), .S0(forwardonBtop4[0]), 
			.Y( Bport_forwarded[31:28]));

  mux3 #( 12, `dptype, `group_bop12)
	mux_special ( .IN0( IR[11:0]), .IN1( {4'b0, IR[7:0]}), 
			.IN2( {5'b0, regCount, 2'b0}),
			.S1( Bop_sel[3]), .S0( Bop_sel[2]), 
			.Y( Bop_special));

  mux4 #( 32, `dptype, `group_bop)
	mux_B ( .IN0( Bport_forwarded), .IN1( { 6'b0, IR[23:0], 2'b0}), 
		.IN2( {20'b0, Bop_special}), .IN3( Bop), 
		.S1( Bop_sel[1]), .S0(Bop_sel[0]), .Y(Bop0));

  mux2 #( 32, `dptype, `group_bop)
	mux_BS ( .IN0( Bop0), .IN1( BopShifted) ,
		.Y( Bop_D), .S0( Bop_sel == ~4'b0));

*************************************************************************/






