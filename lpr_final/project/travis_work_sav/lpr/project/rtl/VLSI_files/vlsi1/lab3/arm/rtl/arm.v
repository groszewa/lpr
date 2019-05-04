//
// ARM.v
//
// David Van Campenhout
//
// datapath + control
//

`define group_etc	"group_etc"
`define group_main 	"group_main"
`define dptype 1         
`define stdcelltype 0

// scan chain:
//
// register	width
// ======== 	=====
// dp		278
// wA		  6
// ctrl		 23
// ======== 	=====
// total		307

module arm( phi1, phi2, clear, test, scanin, scanout,
	dataBus, addressBus, en_buses_bar, memoryRead, memoryWrite,
	mem_req_bar, mem_write_read, mem_word_byte, mode_bar );

  input 		phi1;
  input 		phi2; 
  input		clear;
  input		test;
  input		scanin;
  output		scanout;
  inout [31:0]	dataBus;
  output [25:0]	addressBus;
  output		en_buses_bar;
  output		mem_req_bar;
  output		mem_write_read;
  output		mem_word_byte;
  output [1:0]	mode_bar;

// not connected to a pad: !
  output		memoryWrite;
  output		memoryRead;

  wire		swi;
  wire 		undef_instr;
  wire		fiq;
  wire		irq;
  wire		data_abort;
  wire		prefetch_abort;

  wire [31:0]	IR;
  wire [31:0]	IRcurr;
  wire [1:0]	mode;
  wire [1:0] 	mask;
  wire		skip;

  wire		init_reglist;	// initialize reglist
  wire		init_with_IRc;
  wire [5:0]	xReg_D;		// extracted register from register list
//  wire [15:0]	updatedRegList;
//  wire	[4:0]	regCount;	// number of ones in regList
  wire 		regListEmpty;
  
  wire		enIRcurr;
  wire		enIR1;
  wire		enIR2;
  wire		selIR2;
  wire [1:0]	MASKw;
  wire [1:0]	MODEw;
  wire		enMODE;		// enable MODE write port of register file
  wire		enMASK;		// enable MASK write port of register file
  wire [5:0]	rA;			// address of register to be read on A port
  wire [5:0]	rB;			// address of register to be read on B port
  wire [3:0]	Aop_sel;		// selects input to Aope
  wire [3:0]	Bop_sel;		// selects input to Bope
//  wire	 [2:0]	ShA_sel;	// selects shiftAmount

  wire [1:0]	AR_select;
  wire		align_alu_bar;
  wire		enAR;
  wire		enW;			// enable normal write port of register file
  wire		writeStatus;	// enable COND write port of register file
  wire		enINC;		// enable INC write port of register file
  wire [15:0] 	regList;

  wire		memoryWord_Byte;
  wire		evalCondition;
  wire		ldstrByte;
  wire		sDin;		// 1: select data IN
  						// 0: select aluOut   on Wport
  supply1	vdd, Vdd, VDD;
  supply1	vcc, Vcc, VCC;
  supply0	vss, Vss, VSS;

//  wire	 [2:0]	shiftType;	// shift type
//  wire	 [2:0]	shiftType_D;	// shift type

  wire	 	imm_op;
  wire		imm_amnt;
  wire	 	imm_op_D;
  wire		imm_amnt_D;

  wire [4:0]	aluOperation;		// alu operation
  wire [4:0]	aluOperation_D;	// alu operation
  wire [5:0]	wA_D;			// address of register to be written
  wire [5:0]	wA;				// address of register to be written

  wire		dp_scanout;
  wire		wA_scanout;
  
  wire		ctrl_scanout;
  
  assign		wA_scanout = wA[5];
  assign		scanout = ctrl_scanout;

  assign	mem_word_byte = memoryWord_Byte;

  assign	fiq = 1'b0;
  assign	irq = 1'b0;
  assign	prefetch_abort = 1'b0;
  assign        data_abort = 1'b0;

  stdnor2 nor_en_buses_bar( .IN0( memoryRead), .IN1( memoryWrite), 
			.Y( en_buses_bar));

// these regs could have normally be synthesised by vsyn, but the @#$% vsyn
// is too restrictive ...

  dffs_c #(6,`stdcelltype,`group_etc)
	wA_ff( 	.CLK(phi1), .CLR(clear), .TEST(test), 
			.SCANIN(dp_scanout), .D(wA_D), .Q(wA));


/*************************************************************************************
  dffs #(5,`stdcelltype,`group_etc)
	aluOperation_ff( .CLK(phi1),  
			.SCANIN(scanin), .TEST(test), 
			.D(aluOperation_D), .Q(aluOperation));


  dffs #(2,`stdcelltype,`group_etc)
	shiftType_ff( .CLK(phi1), 
			.SCANIN(scanin), .TEST(test), 
			.D({imm_op_D, imm_amnt_D}), 
			.Q({imm_op, imm_amnt}));
*************************************************************************************/

  arm_dp DP(
	.phi1(phi1), 
	.phi2(phi2), 
	.clear(clear),
	.test(test),
	.scanin(scanin),
	.scanout(dp_scanout),
	.addressBus(addressBus), 
	.dataBus(dataBus), 
	.IR(IR), 
	.IRcurr(IRcurr), 
	.mode(mode), 
	.mask(mask), 
	.skip(skip), 
	.swi(swi),
	.undef_instr(undef_instr),
	.prefetch_abort(prefetch_abort),
	.data_abort(data_abort),
	.fiq(fiq),
	.irq(irq),
	.init_reglist(init_reglist),
	.init_with_IRc( init_with_IRc),
	.xReg_D(xReg_D), 
	.regListEmpty(regListEmpty), 
	.enIRcurr(enIRcurr), 
	.enIR1(enIR1), 
	.enIR2(enIR2), 
	.selIR2(selIR2), 
	.MASKw(MASKw), 
	.MODEw(MODEw), 
	.enMODE(enMODE), 
	.enMASK(enMASK), 
	.rA(rA), 
	.rB(rB), 
	.Aop_sel(Aop_sel), 
	.Bop_sel(Bop_sel), 
//	.ShA_sel(ShA_sel), 
	.AR_select(AR_select), 
	.align_alu_addr_bar( align_alu_addr_bar),
	.enAR(enAR),
	.enW(enW),
	.writeStatus(writeStatus), 
	.enINC(enINC), 
	.memoryRead(memoryRead), 
	.memoryWrite(memoryWrite), 
	.memoryWord_Byte(memoryWord_Byte), 
	.evalCondition(evalCondition), 
	.sDin(sDin), 
	.ldstrByte(ldstrByte),
//	.shiftType(shiftType), 
//	.shiftType_D(shiftType_D), 
	.imm_amnt( imm_amnt),
	.imm_op( imm_op),
	.aluOperation(aluOperation), 
	.wA(wA));
 
  arm_ctrl CTRL(
	.clk(phi1), 
	.clear(clear), 
	.test(test),
	.scanin(wA_scanout),
	.scanout(ctrl_scanout),
	.IR(IR), 
	.IRcurr(IRcurr), 
	.mode(mode), 
	.mask(mask), 
	.skip(skip), 
	.swi(swi),
	.undef_instr(undef_instr),
	.prefetch_abort(prefetch_abort),
	.data_abort(data_abort),
	.fiq(fiq),
	.irq(irq),
	.init_reglist(init_reglist),
	.init_with_IRc_Q( init_with_IRc),
	.xRegin(xReg_D), 
	.regListEmpty(regListEmpty), 
	.enIRcurr(enIRcurr), 
	.enIR1(enIR1), 
	.enIR2(enIR2), 
	.selIR2(selIR2), 
	.MASKw(MASKw), 
	.MODEw(MODEw), 
	.enMODE(enMODE), 
	.enMASK(enMASK), 
	.rA(rA), 
	.rB(rB), 
	.Aop_sel(Aop_sel), 
	.Bop_sel(Bop_sel), 
	.mem_write_read_Q( mem_write_read),
	.mem_req_bar_Q( mem_req_bar),
	.mode_bar( mode_bar),
	.imm_op( imm_op),
	.imm_amnt( imm_amnt),
	.aluOperation(aluOperation), 
	.wA(wA_D),
	.wAin(wA),
	.enINC(enINC), 
	.enAR( enAR),
	.enW(enW), 
//	.ShA_sel(ShA_sel), 
	.AR_select(AR_select), 
	.align_alu_addr_bar( align_alu_addr_bar),
	.writeStatus(writeStatus), 
	.memoryRead_Q(memoryRead), 
	.memoryWrite_Q(memoryWrite), 
	.memoryWord_Byte_Q(memoryWord_Byte), 
	.ldstrByte_Q(ldstrByte),
	.evalCondition_Q(evalCondition), 
	.sDin_Q(sDin)
//	.shiftType(shiftType_D), 
	);


endmodule
