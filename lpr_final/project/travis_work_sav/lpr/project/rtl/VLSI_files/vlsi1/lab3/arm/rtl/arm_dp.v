//
// ARMdp.v
//
// David Van Campenhout
//
// ARM datapath
//

`define	dptype 		1
`define stdcelltype	0
`define group_main	"group_main"
`define group_pc	"group_pc"
`define group_sha	"group_sha"
`define group_getreg "group_count"
`define group_stat		"group_stat"	// -- added by Jian Shen 1.12.99

// scan chain:
//
// register	width
// ======== 	=====
// ir		96
// ar		26
// aop		32
// bop		32
// shift		12
// getreg		16
// din		32
// dout		32
// ======== 	=====
// total		278

// condition flags

`define CF_N		3
`define CF_Z		2
`define CF_C		1
`define CF_V		0




module arm_dp( 
phi1, phi2, clear, test, scanin, scanout,
addressBus, dataBus, 
IR, IRcurr, mode, mask, skip, 
swi, undef_instr, data_abort, prefetch_abort, fiq, irq,
init_reglist, init_with_IRc, xReg_D, 
regListEmpty,
enIRcurr, enIR1, enIR2, selIR2, MASKw, MODEw, enMODE, enMASK, 
rA, rB, Aop_sel, Bop_sel,
AR_select, align_alu_addr_bar, enAR, enW, writeStatus, enINC, 
memoryRead, memoryWrite, memoryWord_Byte,
evalCondition, sDin, ldstrByte,
imm_op, imm_amnt, aluOperation, wA);

  input 		phi1;
  input		phi2;
  input		clear;
  input 		test;
  input		scanin;
  output		scanout;  

  output [25:0]	addressBus;
  inout [31:0]	dataBus;

// inputs from control

  input		swi;		// exceptions
  input		undef_instr;  
  input		fiq;
  input		irq;
  input		prefetch_abort;
  input		data_abort;

  input		enIRcurr;
  input		enIR1;
  input		enIR2;
  input		selIR2;
  input[1:0]	MASKw;
  input[1:0]	MODEw;
  input		enMODE;		// enable MODE write port of register file
  input		enMASK;		// enable MASK write port of register file
  input [5:0]	rA;			// address of register to be read on A port
  input [5:0]	rB;			// address of register to be read on B port
  input [3:0]	Aop_sel;		// selects input to Aope
  input [3:0]	Bop_sel;		// selects input to Bope
  input		imm_amnt;
  input		imm_op;
  input [4:0]	aluOperation;

  input [1:0]	AR_select;
  input		align_alu_addr_bar;
  input		enAR;
  input		enW;			// enable normal write port of register file
  input		writeStatus;	// enable COND write port of register file
  input		enINC;		// enable INC write port of register file
//  input	 [15:0] regList;
  input		init_reglist;	// initialize reglist
  input		init_with_IRc;
  input		memoryRead;
  input		memoryWrite;
  input		memoryWord_Byte;

  input 		ldstrByte;	// load/store byte

  input		evalCondition;
  input		sDin;		// 1: select data IN
  						// 0: select aluOut   on Wport
  input [5:0]	wA;			// address of register to be written

// outputs to control

  output [31:0]	IR;		// output of mux which selects 
						// either IR1 or IR2
  output [31:0] IRcurr;
  output [1:0]	mode;
  output [1:0] 	mask;
  output	skip;

  output [5:0]	xReg_D;		// extracted register from register list
  output 	regListEmpty;

  wire		Ifetch;
  assign		Ifetch = enIR1;

  wire		Ifetch_bar;

  wire [25:0]	addressRegister;

  wire [31:0]	IR;
  wire [31:0]	IR1;			// instruction register 1
  wire [31:0]	IR2;			// instruction register 2
  wire [31:0]	IRcurr;		// instruction in execution

  wire [31:0]	dataIn;		// data in register

  wire [31:0]	IR1_D;
  wire [31:0]	IR2_D;
  wire [31:0]	IRcurr_D;

  wire [31:0]	dataOut;

  wire [31:0]	Aop;			// A operand
  wire [31:0]	Aop_D;
  wire [31:0]	Bop;			// B operand before shifting
  wire [31:0]	Bop_D;
  wire [31:0]	barrelOut;

  wire [7:0]	shiftAmount;	
  wire [7:0]	shiftAmount_D;	

  wire [3:0]	cond;		// condition field of IR
  wire [3:0]	cond_D;

  wire [15:0]	init_list;
  wire		regListEmpty;
  wire [4:0]	regCount;
  wire [3:0]	regCount1;


  wire [3:0] 	stat_Q;		// datapath status bits of psr delayed by 1/2 cycle --added by Jian Shen 1.12.99
  wire [3:0] 	dpStat;		// datapath status bits of psr
  wire [1:0]	mode;		// mode part of processor status reg
  wire [1:0]	mask;		// interrupt mask part of ..
  wire [25:0]	pcAddr;		// pc address part of register word aligned

  wire [1:0]	forwardonA_unbuf;// select for forwarding muxes
  wire [1:0]	forwardonB_unbuf;
  wire [1:0]	forwardonA;
  wire [1:0]	forwardonB;

// regfile ports

  wire [31:0]	Wport;		// general write port
  wire [31:0]	Wport_unbuf;
  wire [25:0]	incAddress;	// incremented address (output of incrementer)
  wire [31:0]	Aport;		// read port A
  wire [31:0]	Bport;		// read port B
  

  wire		qFull;
  wire		qFull_D;

  wire 		skip;		
  wire		skip_unbuf;	// output of skip detection module
  wire [31:0]	BopShifted;	// shifted B operand
  wire		shiftCarryOut;	// carry out of shifter

  wire [3:0]	aluFlagsOut;	// aluFlagsOut
  wire [31:0]	aluOut;		//

  wire [1:0]	byte;		// if loadByte shift lsByte over byte << 3

  wire [25:0]	excAddr;

  wire	[3:0]	Aop_sel_buf;
  wire	[3:0]	Bop_sel_buf;
  wire [1:0]	AR_select_buf;


  wire	[3:0]	alu_s;
  wire		alu_m;
  wire	[1:0]	sel_c; 
  wire		reverse;
  wire		clearA_bar;	/* all due to that #$%#@ bug in the library */
  wire		clearB_bar;
  
  wire	_scanout;  
  wire 	ir_scanout;
  wire	ar_scanout;
  wire 	aop_scanout;
  wire	bop_scanout;
  wire	shift_scanout;
  wire	getreg_scanout;
  wire	din_scanout;
  wire	dout_scanout;

  assign 	_scanout = scanin;
  assign 	scanout = dout_scanout;
  
  
  supply1	vdd, VDD, Vdd;
  supply0	vss, VSS, Vss;

  assign	excAddr = 26'b0;// later to be expanded to other exc vectors

  assign	addressBus = addressRegister;  

  wire [2:0]	exc_addr;


  mux2 #(32, `dptype, `group_main)
	mux_Wport( .IN0(aluOut), .IN1(dataIn), .S0(sDin), .Y(Wport_unbuf));

  buff #(32, `dptype, `group_main)
	buf_Wport( .IN0(Wport_unbuf), .Y(Wport));

  inc #(24, `dptype, `group_pc)
	aINC( .EN(vdd), .IN0( addressRegister[25:2]), 
		// .TC(), .TCBAR(),
		.Y( incAddress[25:2]));

  assign incAddress[1:0] = addressRegister[1:0];

  regfile regfile(	.phi1(phi1),
			.phi2(phi2),
			.clear(clear),
			.test(test),
//			.test(1'b0),
//			.scanin(),
//			.scanout(),
			.rA(rA),
			.rB(rB),
			.wA(wA),
			.W(Wport),
			.INCin(incAddress),
			.MODEin(MODEw),
			.MASKin(MASKw),
			.CONDin(aluFlagsOut),
			.enW(enW),
			.enINC(enINC),
			.enMODE(enMODE),
			.enMASK(enMASK),
			.enCOND(writeStatus),
			.A(Aport),
			.B(Bport),
			.PCaddr(pcAddr),
			.MODEout(mode),
			.MASKout(mask),
			.CONDout(dpStat));

  latch_c   #(4, `dptype, `group_stat)			// -- added by Jian Shen 1.12.99
    stat( .EN(phi1), .D(dpStat), .Q(stat_Q), .CLR(clear));// -- added by Jian Shen 1.12.99
//  dff_c #(4, `stdcelltype, `group_stat)		// -- added by Jian Shen 1.12.99
//    statQ( .CLK(phi1), .D(dpStat), .Q(stat_Q), .CLR(clear));  // -- added by Jian Shen 1.12.99

  detect_skip detect_skip(.stat(stat_Q),	// -- changed by Jian Shen 1.12.99
			.cond(IRcurr[31:28]), 
			.evalCondition(evalCondition), 
			.skip(skip_unbuf) );

  stdbuf buf_skip( .IN0( skip_unbuf), .Y( skip));
  
  shift barrelShift(	.phi1( phi1), 
			.clear( clear),
			.test( test), 
			.scanin( bop_scanout), 
			.scanout( shift_scanout), 		
			.IR( IR[11:5]), 
			.imm_op( imm_op), 
			.imm_amnt( imm_amnt), 
			.carry_in( dpStat[ `CF_C]), 
			.in( Bop), 
			.Aport( Aport[7:0]), 
			.out( BopShifted), 
			.carry_out(shiftCarryOut));

  mapaluops map(.clk( phi1),
		.clear( clear),
		.opin(aluOperation), 
		.alu_s(alu_s), .alu_m(alu_m), .sel_c(sel_c), 
		.reverse(reverse), 
		.clearA_bar(clearA_bar),
		.clearB_bar(clearB_bar));

  arm_alu alu( 	.Aop( Aop),
		.Bop( Bop), 
		.alu_s( alu_s), 
		.alu_m( alu_m), 
		.sel_c( sel_c), 
		.reverse( reverse), 
		.clearA_bar( clearA_bar), 
		.clearB_bar( clearB_bar),
		.carryIn(dpStat[ `CF_C]),
 		.shiftCarry( shiftCarryOut),
		.oldOverflow( dpStat[`CF_V]), 
		.aluOut( aluOut), 
		.flagsOut( aluFlagsOut));

  forward forward( 	.rA(rA), 
			.rB(rB), 
			.wA(wA), 
			.enW(enW), 
			.enINC(enINC), 
			.writeStatus(writeStatus),
			.Aop_sel( Aop_sel_buf),
			.Bop_sel( Bop_sel_buf),
			.forwardonA(forwardonA_unbuf), 
			.forwardonB(forwardonB_unbuf));

  stdbuf buf_forwardonA0( .IN0( forwardonA_unbuf[0]), .Y( forwardonA[0]));
  stdbuf buf_forwardonA1( .IN0( forwardonA_unbuf[1]), .Y( forwardonA[1]));
  stdbuf buf_forwardonB0( .IN0( forwardonB_unbuf[0]), .Y( forwardonB[0]));
  stdbuf buf_forwardonB1( .IN0( forwardonB_unbuf[1]), .Y( forwardonB[1]));


  exc exc( 	.mask( mask), 
			.undef_instr( undef_instr), 
			.swi( swi), 
			.prefetch_abort( prefetch_abort), 
			.data_abort( data_abort), 
			.irq( irq), 
			.fiq( fiq), 
			.address( exc_addr));

  count count(	.in(init_list),
			.cnt(regCount),
			.cnt1(regCount1));

  mux2 #(16, `dptype, `group_getreg)
	mux_init_list( .IN0(IR[15:0]), .IN1(IRcurr[15:0]), 
		.S0(init_with_IRc), .Y(init_list));  

  getreg getreg(	.clk(phi1),
			.clear(clear),
			.test(test), 
//			.test(1'b0), 
			.scanin( shift_scanout),
			.scanout( getreg_scanout),
			.init(init_reglist), 
       		.initlist( init_list), 
       		.mode( mode), 
			.xreg( xReg_D), 
			.zero(regListEmpty));

  dout 	dataOut_mod( 	.clk(phi1),
  			.clear(clear),
			.test( test),
//			.test(1'b0),
			.scanin( din_scanout),
			.scanout( dout_scanout),
			.in(Bport),
			.byte(ldstrByte), 
			.enable(memoryWrite), 
			.dataBus(dataBus));

  stdinv inv_Iftetch(	.IN0( Ifetch), .Y(Ifetch_bar));

//  stdinv inv_ldstByte( 	.IN0( memoryWord_Byte), .Y( ldstrByte));

  stddff dff_byte0(	.D( addressBus[0]), .Q( byte[0]), .CLK(phi1));
  stddff dff_byte1(	.D( addressBus[1]), .Q( byte[1]), .CLK(phi1));

  din dataIn_mod(	.clk(phi1), 
			.clear( clear),
			.test(test), 
//			.test(1'b0), 
			.scanin( getreg_scanout),
			.scanout( din_scanout),
			.enable(Ifetch_bar),
			.dataBus(dataBus), 
			.byte(byte), 
			.ldstrByte(ldstrByte), 
			.out(dataIn));

  stdbuf buf_AR_select0( .IN0( AR_select[0]), .Y( AR_select_buf[0]));
  stdbuf buf_AR_select1( .IN0( AR_select[1]), .Y( AR_select_buf[1]));


  ar ar( .phi1( phi1), 
	.phi2( phi2), 
	.clear( clear),
	.test( test),
//	.test(1'b0),
	.scanin( ir_scanout),
	.scanout( ar_scanout),
	.excAddr( exc_addr), 
	.aluOut( aluOut[25:0]), 
	.pcAddr( pcAddr), 
	.incAddr( incAddress),	
	.AR_select(AR_select_buf), 
	.enAR(enAR), 
	.align_alu_addr_bar(align_alu_addr_bar), 
	.out( addressRegister));

  ir Ireg( .phi1(phi1), 
	.phi2(phi2), 
	.clear( clear),
	.test(test), 
//	.test(1'b0), 
	.scanin( _scanout), 
	.scanout( ir_scanout),
	.dataBus(dataBus), 
	.enIR1(enIR1), 
	.enIR2(enIR2), 
	.enIRcurr(enIRcurr), 
	.selIR2(selIR2),		
	.IR(IR), 
	.IRcurr(IRcurr));

  aop aop_reg( .phi1(phi1), 
		.clear( clear),
		.test(test), 
		.scanin( ar_scanout), 
		.scanout(aop_scanout), 
		.Wport(Wport), 
		.Aport(Aport), 
		.stat(dpStat), 			// -- added by Jian Shen  1.11.99
		.mask(mask), 			// -- added by Jian Shen  1.11.99
		.incAddress(incAddress[25:2]), 
		.mode(mode), 			// -- added by Jian Shen  1.11.99
		.aluOut(aluOut),	
		.regCount(regCount), 
		.regCount1(regCount1), 	
		.exc_addr(exc_addr),
		.forwardonA(forwardonA), 
		.Aop_sel(Aop_sel_buf), 
		.Aop(Aop));

  stdbuf buf_Aop_sel0( .IN0( Aop_sel[0]), .Y( Aop_sel_buf[0]));
  stdbuf buf_Aop_sel1( .IN0( Aop_sel[1]), .Y( Aop_sel_buf[1]));
  stdbuf buf_Aop_sel2( .IN0( Aop_sel[2]), .Y( Aop_sel_buf[2]));
  stdbuf buf_Aop_sel3( .IN0( Aop_sel[3]), .Y( Aop_sel_buf[3]));


  bop bop_reg( .phi1(phi1), 
		.clear( clear),
		.test(test), 
		.scanin( aop_scanout), 
		.scanout( bop_scanout), 
		.Wport(Wport), 
		.Bport(Bport), 
		.stat(dpStat),
		.mask(mask),
		.incAddress(incAddress[25:2]),
		.mode(mode),
		.aluFlags(aluFlagsOut),
		.regCount(regCount), 
		.IR(IR[23:0]),		
		.BopShifted( BopShifted),
		.forwardonB(forwardonB), 
		.Bop_sel(Bop_sel_buf), 
		.Bop(Bop) );

  stdbuf buf_Bop_sel0( .IN0( Bop_sel[0]), .Y( Bop_sel_buf[0]));
  stdbuf buf_Bop_sel1( .IN0( Bop_sel[1]), .Y( Bop_sel_buf[1]));
  stdbuf buf_Bop_sel2( .IN0( Bop_sel[2]), .Y( Bop_sel_buf[2]));
  stdbuf buf_Bop_sel3( .IN0( Bop_sel[3]), .Y( Bop_sel_buf[3]));


/*********************************************************************************
  dffs #(8, `stdcelltype, `group_sha)
	sha_ff( .D( shiftAmount_D), .Q( shiftAmount), 
		.CLK( phi1), .SCANIN( scanin), .TEST( test));


*********************************************************************************/


	
endmodule






