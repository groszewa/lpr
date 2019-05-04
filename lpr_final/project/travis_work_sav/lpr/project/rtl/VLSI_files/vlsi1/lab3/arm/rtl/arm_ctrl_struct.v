//
// arm_ctrl_struct.v
//
// David Van Campenhout
//
// structural part of controller: latches + skip part
//

`define stdcell_type 0
`define dptype 	1
`define group_state "group_state"
`define group_alu 	"group_alu"
`define group_AR_select	"group_AR_select"


module ffs_c( CLK, CLR, D, SCANIN, TEST, Q); 

  input  CLK;
  input  CLR;			// active low
  input  D;
  input  SCANIN;
  input  TEST;
  output Q;  
  wire	D_mux;
  
  stdmux2 mux( .IN0(D), .IN1(SCANIN), .S0(TEST), .Y(D_mux));
  stddff_c ff( .CLK(CLK), .CLR(CLR), .D(D_mux), .Q(Q));
  
endmodule

module ffs_p( CLK, PRE, D, SCANIN, TEST, Q); 

  input  CLK;
  input  PRE;			// active high
  input  D;
  input  SCANIN;
  input  TEST;
  output Q;  
  wire	D_mux;
  
  stdmux2 mux( .IN0(D), .IN1(SCANIN), .S0(TEST), .Y(D_mux));
  stddff_p ff( .CLK(CLK), .PRE(PRE), .D(D_mux), .Q(Q));
  
endmodule

  
module arm_ctrl(
clk, clear, test, scanin, scanout, 

IR, IRcurr,  mode, mask, skip, 
swi, undef_instr, fiq, irq, prefetch_abort, data_abort,
init_reglist, init_with_IRc_Q, xRegin, regListEmpty, 
enIRcurr, enIR1, enIR2, selIR2, MASKw, MODEw, enMODE, enMASK, 
rA, rB, Aop_sel, Bop_sel,

mem_write_read_Q, mem_req_bar_Q, mode_bar,
imm_op, imm_amnt, aluOperation, wA , wAin,

enINC, enAR, enW, AR_select, align_alu_addr_bar, writeStatus, 
memoryRead_Q, memoryWrite_Q, memoryWord_Byte_Q, ldstrByte_Q,
evalCondition_Q, 
sDin_Q
//, byte_Q
);

input		clk;
input		clear;
input		test;
input		scanin;
//input		scanout; -- changed by Jian Shen
output		scanout;

input [31:0]	IR;
input [31:0]	IRcurr;
input [1:0]	mode;
input [1:0] 	mask;
input		skip;

input		fiq;
input		irq;
input		prefetch_abort;
input		data_abort;
output		swi;
output		undef_instr;

output		init_reglist;	// initialize reglist
input [5:0]	xRegin;		// extracted register from register list
input 		regListEmpty;

input [5:0]	wAin;		// wA_Q
output [5:0]	wA;			

  
// non-latched outputs:

output		enIRcurr;
output		enIR1;
output		enIR2;
output		selIR2;
output [1:0]	MASKw;
output [1:0]	MODEw;
output		enMODE;		// enable MODE write port of register file
output		enMASK;		// enable MASK write port of register file
output [5:0]	rA;			// address of register to be read on A port
output [5:0]	rB;			// address of register to be read on B port
output [3:0]	Aop_sel;		// selects input to Aope
output [3:0]	Bop_sel;		// selects input to Bope

output [1:0]	mode_bar;
output		imm_op;		// shift immediate operand
output		imm_amnt;		// shift by imm spec amount
output [4:0]	aluOperation;	// alu operation

// skip sensitive vars

wire [4:0]	state;			// skip ? 5'b0	:

output		enINC;			// skip ? 1 	:
output		enAR;			// skip ? 1	:
output		enW;				// skip ? 0	:
output [1:0]	AR_select;		// skip ? 2'b0	:
output		align_alu_addr_bar;	// skip ? 1	:
output		writeStatus;		// skip ? 0	:

// vars not sensitive to skip

output		memoryRead_Q;
output		memoryWrite_Q;
output		memoryWord_Byte_Q;

output		mem_req_bar_Q;
output		mem_write_read_Q;

output		evalCondition_Q;
output		init_with_IRc_Q;
output		sDin_Q;
output		ldstrByte_Q;
//output [1:0]	byte_Q;

// skip sensitive vars

wire [4:0]	state_D;

wire			enINC_D;
wire			enAR_D;
wire			enW_D;
wire [1:0]	AR_select_D;
wire			align_alu_addr_bar_D;
wire			writeStatus_D;

// vars not sensitive to skip

wire			memoryRead_D;
wire			memoryWrite_D;
wire			memoryWord_Byte_D;

wire 		mem_req_bar_D;
wire 		mem_write_read_D;

wire			evalCondition_D;
wire			init_with_IRc_D;
wire			qFull_D;
wire			Ifetch_D;
wire			sDin_D;
wire			ldstrByte_D;
// wire [1:0]	byte_D;

// skip sensitive vars

wire [4:0]	state_Q;

wire			enINC_Q;
wire			enAR_Q;
wire			enW_Q;
wire [1:0]	AR_select_Q;
wire			align_alu_addr_bar_Q;
wire			writeStatus_Q;

// other wires

wire			skip_bar;
wire [4:0]	skip_bar5 = {skip_bar, skip_bar, skip_bar, skip_bar, skip_bar};

wire			state_Q_scanout;

//assign 		scanout = byte_Q[1];
assign 		scanout = ldstrByte_Q;

stdbufinv buf_skip( .IN0(skip), .Y(skip_bar));

assign		state_Q_scanout = state_Q[4];



// flip flops

//
// initialization of state to 00001 !
//
ffs_p ff_state0( 
	.CLK( clk), .PRE(clear), .TEST( test), .SCANIN( scanin),
	.D(state_D[0]), .Q(state_Q[0]));

dffs_c #( 4, `stdcell_type, `group_state)
	state_ff ( .CLK( clk), .CLR(clear), .D( state_D[4:1]), .Q( state_Q[4:1]),
	.SCANIN( state_Q[0]), .TEST(test));
	
and2  #(5, `stdcell_type, `group_alu)
	and2_state ( .IN0( state_Q), .IN1(skip_bar5), .Y(state));		
ffs_c ff_enINC( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( state_Q[4]),
	.D( enINC_D), .Q( enINC_Q));
stdor2 or_enINC( .IN0( enINC_Q), .IN1( skip), .Y( enINC));
				
ffs_c ff_enAR( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( enINC_Q),
	.D( enAR_D), .Q( enAR_Q));
stdor2 or_enAR( .IN0( enAR_Q), .IN1( skip), .Y( enAR));

		
ffs_c ff_enW( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( enAR_Q),
	.D( enW_D), .Q( enW_Q));
stdand2 and_enW( .IN0( enW_Q), .IN1( skip_bar), .Y( enW));
		
dffs_c #( 2, `stdcell_type, `group_AR_select)
ff_AR_select( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( enW_Q),
	.D( AR_select_D), .Q( AR_select_Q));
or2 #(2, `stdcell_type, `group_AR_select)
or_AR_select( .IN0( AR_select_Q), .IN1( {skip, skip}), .Y( AR_select));
		
ffs_c ff_align_alu_addr_bar( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( AR_select_Q[1]),
	.D( align_alu_addr_bar_D), .Q( align_alu_addr_bar_Q));
stdor2 and_ff_align_alu_addr_bar( 
	.IN0( align_alu_addr_bar_Q), .IN1( skip), .Y( align_alu_addr_bar));
		
ffs_c ff_writeStatus( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( align_alu_addr_bar_Q),
	.D( writeStatus_D), .Q( writeStatus_Q));
stdand2 and_writeStatus( .IN0( writeStatus_Q), .IN1( skip_bar), .Y( writeStatus));
		
ffs_p ff_memoryRead( 
	.CLK( clk), .PRE(clear), .TEST( test), .SCANIN( writeStatus_Q),
	.D( memoryRead_D), .Q( memoryRead_Q));
		
ffs_c ff_memoryWrite( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( memoryRead_Q),
	.D( memoryWrite_D), .Q( memoryWrite_Q));
		
ffs_c ff_memoryWord_Byte( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( memoryWrite_Q),
	.D( memoryWord_Byte_D), .Q( memoryWord_Byte_Q));
		
ffs_c ff_mem_req_bar( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( memoryWord_Byte_Q),
	.D( mem_req_bar_D), .Q( mem_req_bar_Q));
		
ffs_c ff_mem_write_read( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( mem_req_bar_Q),
	.D( mem_write_read_D), .Q( mem_write_read_Q));			
	
ffs_c ff_evalCondition( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( mem_write_read_Q),
	.D( evalCondition_D), .Q( evalCondition_Q));
		
ffs_c ff_init_with_IRc( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( evalCondition_Q),
	.D( init_with_IRc_D), .Q( init_with_IRc_Q));
		
ffs_c ff_qFull(
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( init_with_IRc_Q),
	.D( qFull_D), .Q( qFull_Q));
		
ffs_c ff_Ifetch( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( qFull_Q),
	.D( Ifetch_D), .Q( Ifetch_Q));
	
/**		   
dffs_c #( 6, `stdcell_type, `group_state) ff_xReg(
	( clk), .CLR(clear), .TEST(test), .SCANIN( Ifetch_Q),
	( xRegin), .Q( xReg_Q));
**/	
		
ffs_c ff_sDin( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( Ifetch_Q),
	.D( sDin_D), .Q( sDin_Q));

ffs_c ff_ldstrByte( 
	.CLK( clk), .CLR(clear), .TEST( test), .SCANIN( sDin_Q),
	.D( ldstrByte_D), .Q( ldstrByte_Q));		
				
//dffs_c #( 2, `stdcell_type, `group_state) ff_byte( 
//	.CLK( clk), .CLR(clear), .TEST(test), .SCANIN( ldstrByte_Q),
//	.D( byte_D), .Q( byte_Q));
		
arm_ctrl_comb arm_ctrl_comb(

.state_D( state_D),
.state(state),
.qFull(qFull_Q),		// ??????????
.qFull_D(qFull_D),
.Ifetch(Ifetch_Q),
.Ifetch_D(Ifetch_D),

.IR( IR), 
.IRcurr( IRcurr),  
.mode( mode), 
.mask( mask), 

.swi( swi), 
.undef_instr( undef_instr), 
.fiq( fiq), 
.irq( irq), 
.prefetch_abort( prefetch_abort), 
.data_abort( data_abort),

.init_reglist( init_reglist), 
.init_with_IRc_D( init_with_IRc_D), 
.xRegin( xRegin), 
.regListEmpty( regListEmpty), 

.enIRcurr( enIRcurr), 
.enIR1( enIR1), 
.enIR2( enIR2), 
.selIR2( selIR2), 
.MASKw( MASKw), 
.MODEw( MODEw), 
.enMODE( enMODE), 
.enMASK( enMASK), 

.rA( rA), 
.rB( rB), 
.Aop_sel( Aop_sel), 
.Bop_sel( Bop_sel),


.AR_select_D( AR_select_D), 
.enAR_D( enAR_D), 
.align_alu_addr_bar_D( align_alu_addr_bar_D), 
.enW_D( enW_D), 
.writeStatus_D( writeStatus_D), 
.enINC_D( enINC_D), 

.memoryRead_D( memoryRead_D), 
.memoryWrite_D( memoryWrite_D), 
.memoryWord_Byte_D( memoryWord_Byte_D), 

.ldstrByte_D( ldstrByte_D),
.ldstrByte_Q( ldstrByte_Q),

.evalCondition_D( evalCondition_D), 
.sDin_D( sDin_D), 


.mem_write_read_D( mem_write_read_D), 
.mem_req_bar_D( mem_req_bar_D), 
.mode_bar( mode_bar),

.imm_op( imm_op), 
.imm_amnt( imm_amnt), 
.aluOperation( aluOperation), 
.wA ( wA ), 
.wAin(wAin)
);
	
endmodule


/******************************************************************	
ffs_c ff_( 
	.CLK( clk)), .CLR(clear), .TEST( test), .SCANIN( ),
	.D( ), .Q( ));		
******************************************************************/
