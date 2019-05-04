// 
// test.v
// 
// David Van Campenhout
// 
// address register
// 

`define dptype 1
`define stdcelltype 0
`define group_ar "test"

// scan chain:
//
// register 	width
// ======== 	=====
// ar 		26
// ======== 	=====
// total		26

// gated clocks

module test( clk, clear, test, scanin, scanout, in, excAddr, aluOut,incAddr, pcAddr, AR_select, enAR, align_alu_addr_bar, out);

  input		clk;
  input		clear;
  input		test;
  input		scanin;
  output		scanout;
  input [3:0]	in;
//  output [3;0]
  input [4:2] 	excAddr;
  input [25:0]	aluOut;
  input [25:0]	incAddr;
  input [25:0]	pcAddr;
  input [1:0]	AR_select;
  input		enAR; 
  input		align_alu_addr_bar;
  output [25:0]	out;

  wire [25:0]	alu_aligned;
  wire [25:0]	addressRegister_D;

  assign		scanout = out[25];

  wire		clk_ar;

  assign alu_aligned[25:2] = aluOut[25:2];

  stdand2 and_align0( .IN0( aluOut[0]), .IN1( align_alu_addr_bar), 
		.Y( alu_aligned[0])); 
  stdand2 and_align1( .IN0( aluOut[1]), .IN1( align_alu_addr_bar),
		.Y( alu_aligned[1])); 

  mux4	#(26, `dptype, `group_ar)
      mux_IR( .IN0( {21'b0,excAddr,2'b0}), .IN1( alu_aligned), 
		.IN2( pcAddr), .IN3( incAddr), 
		.S1( AR_select[1]), .S0( AR_select[0]), 
		.Y( addressRegister_D));

//  stdlatch latch_enAR( .D( enAR), .EN( phi2), .Q( enAR_phi2));
//  stdand2 and_clk( .IN0( enAR_phi2), .IN1( phi1), .Y( clk_ar));

  stdlatch latch_enAR( .D( enAR), .EN( phi2), .Q( enAR_phi2));
  stdoa21 oa_clk( .IN0(enAR_phi2), .IN1(test), .IN2(phi1), .Y(clk_ar));
  
  
  dffs_c	#(26, `dptype, `group_ar)
	ar_ff( .CLK( clk_ar), .CLR(clear), .TEST( test), .SCANIN( scanin),
			.D( addressRegister_D), .Q( out));


endmodule
