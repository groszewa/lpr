//
// arm_alu.v
//
// David Van Campenhout
//
// structural model of alu
//
// no ffs

`define imptype 1
`define dptype 1
`define stdcelltype 0
`undef group
`define group_alu 	"group_main"

module arm_alu( Aop, Bop, alu_s, alu_m, sel_c, 
		reverse, clearA_bar, clearB_bar,
		carryIn, oldOverflow, shiftCarry,
		aluOut, flagsOut);


  input [31:0]	Aop;
  input [31:0]	Bop;
  input		carryIn;
  input 	oldOverflow;

  input	[3:0]	alu_s;
  input		alu_m;
  input	[1:0]	sel_c; 
  input		reverse;
  input		clearA_bar;	/* all due to that #$%#@ bug in the library */
  input		clearB_bar;


  input 	shiftCarry;

  output [31:0]	aluOut;
  output [3:0]	flagsOut;


  wire		reverse_buf;
  wire	[31:0]	reverse32;

  wire		clearA_bar_buf;
  wire		clearB_bar_buf;


  wire	[31:0]	clearA_bar32;
  wire	[31:0]	clearB_bar32;

  wire	[31:0]	Aopx1;
  wire	[31:0]	Bopx1;

  wire	[31:0]	Aopx2;
  wire	[31:0]	Bopx2;
  wire		_carryIn;

  wire		ovf;
  wire 		carry_out;
  wire		zero;
//  wire [9:0]	nz;

  supply0	gnd;
  supply1	vdd;  

  assign 	reverse32={	reverse_buf, reverse_buf, reverse_buf, reverse_buf,
				reverse_buf, reverse_buf, reverse_buf, reverse_buf,
				reverse_buf, reverse_buf, reverse_buf, reverse_buf,
				reverse_buf, reverse_buf, reverse_buf, reverse_buf,
				reverse_buf, reverse_buf, reverse_buf, reverse_buf,
				reverse_buf, reverse_buf, reverse_buf, reverse_buf,
				reverse_buf, reverse_buf, reverse_buf, reverse_buf,
				reverse_buf, reverse_buf, reverse_buf, reverse_buf};


  assign	clearA_bar32 = {	
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, 
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, 
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, 
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, 
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, 
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, 
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, 
	clearA_bar_buf, clearA_bar_buf, clearA_bar_buf, clearA_bar_buf};

  assign	clearB_bar32 = {	
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, 
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, 
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, 
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, 
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, 
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, 
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, 
	clearB_bar_buf, clearB_bar_buf, clearB_bar_buf, clearB_bar_buf};

  stdbuf buf_reverse( .IN0( reverse), .Y(reverse_buf));
  stdbuf buf_clearA( .IN0( clearA_bar), .Y(clearA_bar_buf));
  stdbuf buf_clearB( .IN0( clearB_bar), .Y(clearB_bar_buf));




  stdinv inv(.IN0(carryIn), .Y(_carryIn));

  stdmux4 
	mux( .IN0(gnd), .IN1(vdd), .IN2(_carryIn), .IN3(carryIn), 
		.S0(sel_c[0]), .S1(sel_c[1]), .Y(carry_in));

  and2 #(32, `dptype, `group_alu)
	and_a( .IN0( Aop), .IN1( clearA_bar32), .Y( Aopx1));

  and2 #(32, `dptype, `group_alu)
	and_b( .IN0( Bop), .IN1( clearB_bar32), .Y( Bopx1));

  xor2 #(32, `dptype, `group_alu)
	xor_a( .IN0( Aopx1), .IN1( reverse32), .Y(Aopx2));

  xor2 #(32, `dptype, `group_alu)
	xor_b( .IN0( Bopx1), .IN1( reverse32), .Y(Bopx2));

  aluv #(32, 1, `imptype, `group_alu)
	alu( .A(Aopx2), .B(Bopx2), .C0(carry_in), .M(alu_m),
		.S0(alu_s[0]), .S1(alu_s[1]), .S2(alu_s[2]), .S3(alu_s[3]),
		.COUT(carry_out), .OVF(ovf), .F(aluOut));

  // aluOut == 0 tree  
  zero #(32, `dptype, `group_alu)
	checkzero( .IN0(aluOut), .Y(zero));

/************************************************************************
  stdnor4 norz0( aluOut[0], aluOut[1], aluOut[2], aluOut[3], nz[0]);
  stdnor4 norz1( aluOut[4], aluOut[5], aluOut[6], aluOut[7], nz[1]);
  stdnor4 norz2( aluOut[8], aluOut[9], aluOut[10], aluOut[11], nz[2]);
  stdnor4 norz3( aluOut[12], aluOut[13], aluOut[14], aluOut[15], nz[3]);
  stdnor4 norz4( aluOut[16], aluOut[17], aluOut[18], aluOut[19], nz[4]);
  stdnor4 norz5( aluOut[20], aluOut[21], aluOut[22], aluOut[23], nz[5]);
  stdnor4 norz6( aluOut[24], aluOut[25], aluOut[26], aluOut[27], nz[6]);
  stdnor4 norz7( aluOut[28], aluOut[29], aluOut[30], aluOut[31], nz[7]);
  stdnand4 nandz0( nz[0], nz[1], nz[2], nz[3], nz[8]);
  stdnand4 nandz1( nz[4], nz[5], nz[6], nz[7], nz[9]);
  stdnor2 norz8( .IN0(nz[8]), .IN1(nz[9]), .Y(zero));
************************************************************************/

  aluflags flags( .carry_in( carry_out), .ovf_in(ovf), .zero_in(zero),
		.neg_in( aluOut[31]), .oldOverflow(oldOverflow), 
		.shiftCarry(shiftCarry), .alu_m(alu_m), .flagsOut(flagsOut));

endmodule





