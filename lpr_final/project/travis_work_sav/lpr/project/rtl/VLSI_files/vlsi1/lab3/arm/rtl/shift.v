// 
// shift.v
// 
// David Van Campenhout
// 
// control for shifter
// 


`define group_shift6 "group_shift6"
`define group_shift "group_shift"

`define dptype 1
`define stdcelltype 0


`define LSL	3'b000
`define LSR	3'b001
`define ASR	3'b010
`define ROR	3'b011
`define RRX	3'b111

// scan chain:
//
// register	width
// ========	=====
// Aport6		1
// Aport7		1
// type_0		1
// type_1		1
// type_2		1
// left_amount 6
// imm_amnt	1
// ========	=====
// total		12

module 
shift( 	phi1, clear, test, scanin, scanout,
		IR, imm_op, imm_amnt, carry_in, 
		in, Aport, out, carry_out );

  input 		phi1;
  input		test;
  input		clear;
  input		scanin; 
  output		scanout;
  input	[11:5]	IR;
  input		imm_op;	// immediate operand: don't consider IR[7] 
  input		imm_amnt;// select immediate shift amount, not reg specified

  input		carry_in;
  input	[31:0]	in;
  input	[7:0]	Aport;

  output [31:0]	out;
  output	carry_out;
  
  wire 	[1:0]	type_D;
  wire 	[2:0]	type;
  wire 	[2:0]	type_bar;
  wire		rrx;
  wire		right;
  wire		asr;
  wire		sel_cnst;

  wire	[5:0]	left_amount_D;
  wire	[5:0]	left_amount;
  wire	[5:0]	right_amount;
  wire 	[5:0]	amount;
  wire 	[5:0]	amount_buf;
  wire	[30:0]	cnst31;

  wire	[31:0]	inb;
  
  wire		in0, in31;
  wire		IR7_and, IR7_xor;
  wire		nor_low, nor_high, zero_amnt;
  wire		gte32;
  wire		mux_amount_s1;
  wire		cnst, cnst_unbuf;
  wire		imm_amnt_Q;
  wire		imm_amnt_QBAR;
  wire		Aport6_Q;
  wire		Aport7_Q;

  wire  [4:0]	shift1;		// shiftAmount -1 

  wire 	[10:0]	nR;	// nodes for carry selection in case of <<
  wire 	[10:0]	nS1;	// nodes for carry selection in case of >>

  supply0	vss, VSS, Vss;
  supply1 	vdd, VDD, Vdd;  
  
  
  assign scanout = imm_amnt_Q;  

  assign	in0 = in[0]; 
  assign	in31 = in[31];

  assign cnst31 = {cnst,cnst,cnst,cnst,cnst,cnst,cnst,cnst,
			cnst,cnst,cnst,cnst,cnst,cnst,cnst,cnst,
			cnst,cnst,cnst,cnst,cnst,cnst,cnst,cnst,
			cnst,cnst,cnst,cnst,cnst,cnst,cnst};

  stdmux2 scan_mux_ff_Aport6(	.IN0( Aport[6]), .IN1(scanin), 
  						.S0(test), .Y(Aport6_in));
  stddff_c ff_Aport6( .CLK( phi1), .CLR(clear), .D( Aport6_in), .Q( Aport6_Q));
  
  stdmux2 scan_mux_ff_Aport7(	.IN0( Aport[7]), .IN1(Aport6_Q), 
  						.S0(test), .Y(Aport7_in));
  stddff_c ff_Aport7( .CLK( phi1), .CLR(clear), .D( Aport7_in), .Q( Aport7_Q));
    
  stdao222 ao_gte32(	.IN0( Aport6_Q), .IN1( imm_amnt_QBAR),
			.IN2( Aport7_Q), .IN3( imm_amnt_QBAR),
			.IN4( left_amount[5]), .IN5( left_amount[5]),
			.Y( gte32));
/******************************************************************************
  assign gte32 = ( Bport[7] | Bport[6] ) & ~imm_amnt_Q
		| left_amount[5];
******************************************************************************/

  stdor2 or_type0( .IN0( IR[5]), .IN1( imm_op), .Y( type_D[0]));
  stdor2 or_type1( .IN0( IR[6]), .IN1( imm_op), .Y( type_D[1]));    
  
  stdmux2 scan_mux_ff_type0( 	.IN0( type_D[0]), .IN1( Aport7_Q), 
  						.S0(test), .Y(type_D0_in));
  stddff_cq ff_type0( 	.CLK( phi1), .CLR(clear), 
					.D( type_D0_in), .Q( type[0]), .QBAR( type_bar[0]));
					
  stdmux2 scan_mux_ff_type1(	.IN0( type_D[1]), .IN1( type[0] ), 
  						.S0(test), .Y(type_D1_in));
  stddff_cq ff_type1( 	.CLK( phi1), .CLR(clear), 
					.D( type_D1_in), .Q( type[1]), .QBAR( type_bar[1]));
			
  stdmux2 scan_mux_ff_type2(	.IN0( rrx), .IN1( type[1]), 
  						.S0(test), .Y(rrx_in));
  stddff_cq ff_type2( 	.CLK( phi1), .CLR(clear), 
					.D( rrx_in), .Q( type[2]), .QBAR( type_bar[2]));

  stdnor3 nor3_low( .IN0( IR[7]), .IN1(IR[8]), .IN2(IR[9]), 
			.Y( nor_low));
  stdnor3 nor3_high( .IN0( imm_op), .IN1( IR[11]), .IN2( IR[10]), 
			.Y( nor_high));
  stdand2 and2_zero_amnt( .IN0( nor_low), .IN1( nor_high), 
			.Y( zero_amnt));
  stdinv inv_imm_op( .IN0( imm_op), .Y( imm_op_bar));

  stdand2 and_IR7( .IN0( IR[7]), .IN1( imm_op_bar), .Y( IR7_and));
  stdxor2 xor_IR7( .IN0( IR7_and), .IN1( rrx), .Y( IR7_xor));

  stdand4 and_rrx( .IN0( zero_amnt), .IN1( IR[6]),
		   	.IN2( IR[5]), .IN3( imm_amnt),
			.Y( rrx));
  stdand3 and_asr( .IN0(type_bar[0]), .IN1(type[1]), .IN2(type_bar[2]), .Y(asr));

  stdor2 or_right( .IN0( type[0]), .IN1( type[1]), .Y( right));

  stdnand2 nand_sel_cnst (.IN0( type[0]), .IN1( type[1]), .Y( sel_cnst));


  mux2 #( 6, `dptype, `group_shift6)
	mux_left_amount ( .IN0( Aport[5:0]),  
			.IN1( {1'b0,  IR[11:8], IR7_xor}),
			.S0( imm_amnt),
			.Y( left_amount_D));
  
  dffs_c #( 6, `dptype, `group_shift6)
	amount_ff ( .CLK( phi1), .CLR( clear), .TEST(test), .SCANIN( type[2]),
				.D( left_amount_D), .Q( left_amount));

  compl #(6, `dptype, `group_shift6)
	complement( 	.COMP(vss), 
			.IN0( left_amount[5:0]),
			//.COUT(),
			//.COUTBAR(),
			.Y( right_amount[5:0]));

/*********************
  stdor3 or_gte32( .IN0( Bport[7]), .IN1( Bport[6]), .IN2( Bport[5]), 
			.Y( gte32));
  dffs #( 6, `dptype, `group_shift6)
	amount_ff ( .CLK( phi1), .D( {1'b0,  IR[11:8], IR7_xor}), 
		.Q( imm_amount), .SCANIN( scanin), .TEST(test));
  mux2 #( 6, `dptype, `group_shift6)
	mux_left_amount ( .IN1( imm_amount), .IN0( Bport[5:0]), 
			.S0( imm_amnt_Q),
			.Y( left_amount));
*********************/


  stdand2 and_mux_amount_s1( .IN0( gte32), .IN1( sel_cnst), 
				.Y( mux_amount_s1)); // not for a rotate

  mux3 #( 6, `dptype, `group_shift6)
	mux_amount ( .IN0( left_amount), .IN1( right_amount), 
			.IN2( 6'd32),
			.S1( mux_amount_s1), .S0( right), 
			.Y( amount));

  stdand2 and_cnst( .IN0( in[31]), .IN1( asr), .Y( cnst_unbuf));
  stdbuf  buf_cnst( .IN0( cnst_unbuf), .Y( cnst));

  mux2 #( 31, `dptype, `group_shift)
	mux_inb ( .IN0( in[31:1]), .IN1( cnst31 ), 
			.S0( sel_cnst), .Y( inb[31:1]));

  stdmux3 mux_inb0 ( .IN0( in[0]), .IN1( cnst ), .IN2( carry_in),
			.S0( sel_cnst), .S1( type[2]), .Y( inb[0]));

  buff #( 6, `dptype, `group_shift6) 
	buff_amount( .IN0( amount), .Y( amount_buf));

  barrelfun #(32, 6, `dptype, `group_shift)
	barrel( .A(in),
		.B(inb),
		.S(amount_buf),
		.Y(out));

  incbar #(5, `stdcelltype, `group_shift6)
	decrement(	.EN(vdd),	
			.IN0(left_amount[4:0]),
			//.TC(), .TCBAR(),
			.Y(shift1));

  stdmux4 muxS1_0( .IN0(in[0]), .IN1(in[1]), .IN2(in[2]), .IN3(in[3]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[0]));
  stdmux4 muxS1_1( .IN0(in[4]), .IN1(in[5]), .IN2(in[6]), .IN3(in[7]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[1]));
  stdmux4 muxS1_2( .IN0(in[8]), .IN1(in[9]), .IN2(in[10]), .IN3(in[11]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[2]));
  stdmux4 muxS1_3( .IN0(in[12]), .IN1(in[13]), .IN2(in[14]), .IN3(in[15]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[3]));
  stdmux4 muxS1_4( .IN0(in[16]), .IN1(in[17]), .IN2(in[18]), .IN3(in[19]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[4]));
  stdmux4 muxS1_5( .IN0(in[20]), .IN1(in[21]), .IN2(in[22]), .IN3(in[23]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[5]));
  stdmux4 muxS1_6( .IN0(in[24]), .IN1(in[25]), .IN2(in[26]), .IN3(in[27]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[6]));
  stdmux4 muxS1_7( .IN0(in[28]), .IN1(in[29]), .IN2(in[30]), .IN3(in[31]), 
			.S0(shift1[0]), .S1(shift1[1]), .Y(nS1[7]));
  stdmux4 muxS1_8( .IN0(nS1[0]), .IN1(nS1[1]), .IN2(nS1[2]), .IN3(nS1[3]), 
			.S0(shift1[2]), .S1(shift1[3]), .Y(nS1[8]));
  stdmux4 muxS1_9( .IN0(nS1[4]), .IN1(nS1[5]), .IN2(nS1[6]), .IN3(nS1[7]), 
			.S0(shift1[2]), .S1(shift1[3]), .Y(nS1[9]));
  stdmux2 muxS1_10( .IN0(nS1[8]), .IN1(nS1[9]), .S0(shift1[4]), .Y(nS1[10]));
    
// muxes for carry in case of a shift left

  stdmux4 muxR_0( .IN0(in[0]), .IN1(in[1]), .IN2(in[2]), .IN3(in[3]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[0]));
  stdmux4 muxR_1( .IN0(in[4]), .IN1(in[5]), .IN2(in[6]), .IN3(in[7]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[1]));
  stdmux4 muxR_2( .IN0(in[8]), .IN1(in[9]), .IN2(in[10]), .IN3(in[11]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[2]));
  stdmux4 muxR_3( .IN0(in[12]), .IN1(in[13]), .IN2(in[14]), .IN3(in[15]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[3]));
  stdmux4 muxR_4( .IN0(in[16]), .IN1(in[17]), .IN2(in[18]), .IN3(in[19]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[4]));
  stdmux4 muxR_5( .IN0(in[20]), .IN1(in[21]), .IN2(in[22]), .IN3(in[23]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[5]));
  stdmux4 muxR_6( .IN0(in[24]), .IN1(in[25]), .IN2(in[26]), .IN3(in[27]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[6]));
  stdmux4 muxR_7( .IN0(in[28]), .IN1(in[29]), .IN2(in[30]), .IN3(in[31]), 
			.S0(right_amount[0]), .S1(right_amount[1]), .Y(nR[7]));
  stdmux4 muxR_8( .IN0(nR[0]), .IN1(nR[1]), .IN2(nR[2]), .IN3(nR[3]), 
			.S0(right_amount[2]), .S1(right_amount[3]), .Y(nR[8]));
  stdmux4 muxR_9( .IN0(nR[4]), .IN1(nR[5]), .IN2(nR[6]), .IN3(nR[7]), 
			.S0(right_amount[2]), .S1(right_amount[3]), .Y(nR[9]));
  stdmux2 muxR_10( .IN0(nR[8]), .IN1(nR[9]), .S0(right_amount[4]), .Y(nR[10]));
  
  stdmux2 scan_mux_ff_imm_amnt(	.IN0( imm_amnt), .IN1( left_amount[5]), 
  							.S0(test), .Y(imm_amnt_in));  
  stddff_cq ff_imm_amnt( .CLK( phi1), .CLR(clear), 
					.D( imm_amnt_in), .Q( imm_amnt_Q), 
					.QBAR( imm_amnt_QBAR));
 
  shift_carry shift_carry( 	.clk( phi1), 
				.clear( clear),
				.test( test),
				.shiftType( type), 
				.Aport( {Aport7_Q, Aport6_Q, left_amount}), 
				.imm_amnt( imm_amnt_Q), 
				.gte32( gte32), 
				.in31( in31), 
				.in0( in0), 
				.carry_in( carry_in), 
				.carryR( nR[10]), 
				.carryS( nS1[10]), 
				.carry_out( carry_out));


endmodule
