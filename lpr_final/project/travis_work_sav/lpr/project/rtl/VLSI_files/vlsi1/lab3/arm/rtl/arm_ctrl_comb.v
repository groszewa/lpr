//
// arm_ctrl_comb.v
//
// David Van Campenhout
//
// controller
//



// addressRegister mux

`define AR_EXC		2'd0
`define AR_ALU		2'd1
`define AR_PC		2'd2	
`define AR_INC		2'd3	


// processor modes

`define M_USER		2'b00
`define M_FIRQ		2'b01
`define M_IRQ		2'b10
`define M_SVC		2'b11


// alu opcodes

`define ALU_and 	5'b00000
`define ALU_eor 	5'b00001
`define ALU_sub 	5'b00010
`define ALU_rsb 	5'b00011
`define ALU_add 	5'b00100
`define ALU_adc 	5'b00101
`define ALU_sbc 	5'b00110
`define ALU_rsc 	5'b00111
`define ALU_tst 	5'b01000
`define ALU_teq 	5'b01001
`define ALU_cmp 	5'b01010
`define ALU_cmn 	5'b01011
`define ALU_orr 	5'b01100
`define ALU_movB 	5'b01101
`define ALU_bic 	5'b01110
`define ALU_movnB 	5'b01111

`define ALU_movA 	5'd16

// program status register flags

`define PSR_N		31
`define PSR_Z		30
`define PSR_C		29
`define PSR_V		28
`define PSR_I		27
`define PSR_F		26
`define PSR_M1		1
`define PSR_M0		0

// condition flags

`define CF_N		3
`define CF_Z		2
`define CF_C		1
`define CF_V		0

// Aop


`define AOP_APORT		4'b0000
`define AOP_A			4'b0001
`define AOP_REGCOUNT	4'b0011
`define AOP_REGCOUNT1	4'b0111
`define AOP_4			4'b1011
`define AOP_EXC		4'b1111



// Bop


`define BOP_IMM		4'b0111
`define BOP_LDST		4'b1111
`define BOP_REGCOUNT	4'b0011

`define BOP_BPORT		4'b0000
`define BOP_SHIFTOUT	4'b0001
`define BOP_BRANCH		4'b0010
`define BOP_B			4'b0110

// alu operation

`define ALUOP_MOVA	3'd0
`define ALUOP_MOVB	3'd1	
`define ALUOP_ADD	3'd2
`define ALUOP_SUB	3'd3
`define ALUOP_RSB	3'd4
`define ALUOP_IR	3'd5
`define ALUOP_OLD	3'd6

module arm_ctrl_comb(

state_D, state,
qFull_D, qFull,
Ifetch_D, Ifetch,

IR, IRcurr,  mode, mask, 
swi, undef_instr, fiq, irq, prefetch_abort, data_abort,
init_reglist, init_with_IRc_D, xRegin, regListEmpty, 
enIRcurr, enIR1, enIR2, selIR2, MASKw, MODEw, enMODE, enMASK, 
rA, rB, Aop_sel, Bop_sel,

AR_select_D, enAR_D, align_alu_addr_bar_D, enW_D, writeStatus_D, enINC_D, 
memoryRead_D, memoryWrite_D, memoryWord_Byte_D, 
evalCondition_D, sDin_D, 

ldstrByte_D, ldstrByte_Q,

mem_write_read_D, mem_req_bar_D, mode_bar,
imm_op, imm_amnt, aluOperation, wA , wAin);

input [4:0]	state;
output [4:0]	state_D;
reg [4:0]  	state_D;

input		qFull;
output		qFull_D;
reg 			qFull_D;

input		ldstrByte_Q;	// internal signal
output		ldstrByte_D;
reg			ldstrByte_D;

input		Ifetch;
output		Ifetch_D;
reg			Ifetch_D;
	   
// skip sensitive outputs:

output [1:0]	AR_select_D;
reg [1:0]		AR_select_D;

output		enAR_D;		// enable address register
reg			enAR_D;
  
output		align_alu_addr_bar_D; // address on aluOUT needs to be aligned
reg			align_alu_addr_bar_D;
  
output		enW_D;		// enable normal write port of register file
reg			enW_D;

output		writeStatus_D;	// enable COND write port of register file
reg			writeStatus_D;

output		enINC_D;		// enable INC write port of register file
reg			enINC_D;

output		evalCondition_D;
reg			evalCondition_D;

output		sDin_D;		// 1: select data IN; 0: aluOut on Wport
reg			sDin_D;

// latched outputs:

output		memoryRead_D;
reg			memoryRead_D;

output		memoryWrite_D;
reg			memoryWrite_D;

output		memoryWord_Byte_D;
reg 			memoryWord_Byte_D;

output		mem_write_read_D;
//reg 			mem_write_read_D;

output		mem_req_bar_D;
//reg 			mem_req_bar_D;

output		init_with_IRc_D;
reg			init_with_IRc_D;

// inputs 

input [31:0]	IR;
input [31:0]	IRcurr;
input [1:0]	mode;
input [1:0] 	mask;

input		fiq;
input		irq;
input		prefetch_abort;
input		data_abort;


input [5:0]	xRegin;		// extracted register from register list
input 		regListEmpty;

input [5:0]	wAin;		// wA_Q
  
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
output		swi;
output		undef_instr;
output		init_reglist;	// initialize reglist

// external (since multibit) latched outputs 

output		imm_op;		// shift immediate operand
output		imm_amnt;		// shift by imm spec amount
output [4:0]	aluOperation;	// alu operation

output [5:0]	wA;			// address of register to be written
reg 	[5:0]	wA;		// address of register to be written

// non-latched outputs:

reg			enIRcurr;
reg			enIR1;
reg			enIR2;
reg			selIR2;
reg [1:0]		MASKw;
reg [1:0]		MODEw;
reg			enMODE;		// enable MODE write port of register file
reg			enMASK;		// enable MASK write port of register file
reg [5:0]		rA;			// address of register to be read on A port
reg [5:0]		rB;			// address of register to be read on B port
reg [3:0]		Aop_sel;		// selects input to Aope
reg [3:0]		Bop_sel;		// selects input to Bope

reg [4:0]		aluOperation;
reg			imm_op;
reg			imm_amnt;

reg			init_reglist;

reg			swi;
reg			undef_instr;



// ff in

//  reg		mem_write_read_D;
//  reg [5:0]	wA_D;		// address of register to be written





// comb( ff-out)
  
// ff in
  
//  reg [1:0]	byte_D;
//  reg [15:0]	regList_D;

//

wire		zero_ror;	// zero ror for shift with imm op
wire		zero_shift;	// zero shift for shift with reg spec op


// states

  parameter 
	ST_READY 		= 5'd0,
	ST_RESET		= 5'd1,
	ST_RESET1		= 5'd2,
	ST_RESET2		= 5'd3,
	ST_SHIFT		= 5'd4,
	ST_B1		= 5'd5,
	ST_B2		= 5'd6,
	ST_refillPipe1	= 5'd7,
	ST_refillPipe2 = 5'd8,
//	ST_readShift	= 5'd9,			This is commented out by Jian Shen, Oct. 1998
	ST_LDR0		= 5'd9,
	ST_LDR1		= 5'd10,
	ST_LDR2		= 5'd11,
	ST_STR0		= 5'd12,
	ST_STR1		= 5'd13,
	ST_LDM1		= 5'd14,
	ST_LDMloop	= 5'd15,
	ST_STM1		= 5'd16,
	ST_STMloop	= 5'd17,
	ST_SWI1		= 5'd18,
	ST_SWI2		= 5'd19;
//	ST_readShift	= 5'd9,
//	ST_LDR0		= 5'd10,
//	ST_LDR1		= 5'd11,
//	ST_LDR2		= 5'd12,
//	ST_STR0		= 5'd13,
//	ST_STR1		= 5'd14,
//	ST_LDM1		= 5'd15,
//	ST_LDMloop	= 5'd16,
//	ST_STM1		= 5'd17,
//	ST_STMloop	= 5'd18,
//	ST_SWI1		= 5'd19,
//	ST_SWI2		= 5'd20;





assign	mem_req_bar_D = ~memoryRead_D & ~memoryWrite_D;
assign	mem_write_read_D = memoryWrite_D;

assign	mode_bar = ~ mode;

assign	zero_ror = (IR[11:8] == 4'b0);
assign	zero_shift = (IR[11:4] == 8'b0);	
		// automatically false if reg spec shift amount
							
// clock process

//  always 
//  @(posedge clk or negedge clear)
//	begin
//		if (!clear)
//		begin
//			byte			<= #2  byte_D;
//			wA			<= #2  6'b0;
//			wA_D			<= #2  6'b0;
//		end
//	else // clear = 1
//		begin
//			// state stuff:
//			byte		<= #2  byte_D;
//
//
//			
//			// latched outputs:
//
//			mem_write_read	<= #2  mem_write_read_D;
//			aluOperation	<= #2  aluOperation_D;
//			wA		<= #2  wA_Dtemp;
//		end
//	end		// end clock process
//
//

// logic block

  always 
  @( IR or state or mode or mask 
		or wAin or IRcurr or regListEmpty 
		or xRegin 
		or Ifetch or rA or rB or qFull or ldstrByte_Q
		or zero_ror or zero_shift )
	
	begin : logic

                // defaults:

		enIRcurr = 0;
		init_reglist = 0;
		enAR_D = 1;
		align_alu_addr_bar_D = 1;
		sDin_D = 0;
		ldstrByte_D = 0;
		
		enMODE = 0;
		enMASK = 0;
		writeStatus_D = 0;                
		init_with_IRc_D = 0;

		swi = 0;
		undef_instr = 0;
	

		// IR queue related signals

 
		enIR1 = Ifetch;
		if (!qFull || (qFull && ( state == ST_READY)))
			enIR2 = 1;
		else 
			enIR2 = 0;
		selIR2	= qFull;
		if (state == ST_READY)
			enIRcurr = 1;
		else 
 			enIRcurr = 0;

		// main sequencer

		 case (state) 		
ST_RESET:
	begin
			memoryRead_D 	= 1;
			memoryWrite_D 	= 0;
			memoryWord_Byte_D = 1;
			enW_D		= 0;
			writeStatus_D 	= 0;
			evalCondition_D= 0;
			state_D 		= ST_RESET1;
			AR_select_D 	= `AR_EXC;
			sDin_D		= 0;
			qFull_D		= 0;
			Ifetch_D		= 0;
			MASKw		= 2'b11;	// disable interrupts
			MODEw		= `M_SVC;	// go to SVC
			enINC_D		= 0;
			enMODE		= 1;
			enMASK		= 1;
	end
	
ST_RESET1:
	begin	
			memoryRead_D 	= 1;
			memoryWord_Byte_D = 1;
			memoryWrite_D 	= 0;
			enW_D		= 0;
			evalCondition_D = 0;
			state_D 		= ST_RESET2;
			writeStatus_D 	= 0;
			AR_select_D 	= `AR_INC;
			sDin_D		= 0;
			qFull_D		= 0;
			Ifetch_D		= 1;
			enINC_D		= 0;
			enMODE		= 0;
			enMASK		= 0;
	end	

ST_RESET2:
	begin	
			memoryRead_D 	= 1;
			memoryWrite_D 	= 0;
                        memoryWord_Byte_D = 1;
			enW_D		= 0;
		       	writeStatus_D 	= 0;
		       	evalCondition_D = 0;         
			AR_select_D 	= `AR_INC;
			sDin_D		= 0;
			enINC_D		= 1;
		       	state_D 	= ST_READY;
			qFull_D		= 0;
			Ifetch_D	= 1;
			MASKw		= 2'b00;	// enable interrupts
			enMODE		= 0;
			enMASK		= 1;
	end

ST_READY:
	begin
	Ifetch_D = 1;	// the next cycle is the first execute cycle
				// of the instruction being decoded
				// in such cycles we always fetch the instruction
				// two words after the instruction being decoded here
	qFull_D	= qFull && Ifetch;	// if we don't fetch, the pipe
							// gets empty
	sDin_D 	= 0;
       	casex( {IR[27:24], IR[20], IR[7], IR[4] } )

{ 7'b101xxxx }: // branch, branch with link
	begin

 			memoryRead_D 	= 1;
			memoryWrite_D 	= 0;
			memoryWord_Byte_D = 1;
			// causes incremented PC to be loaded in Aop
			// Aop_sel		= `AOP_INC;
			Aop_sel		= `AOP_APORT;
			rA 		= { mode, 4'd15};
			Bop_sel 	= `BOP_BRANCH;
			aluOperation 	= `ALU_add;
			writeStatus_D 	= 0;
			enW_D		= 0;
			evalCondition_D = 1;
			AR_select_D 	= `AR_ALU;
			align_alu_addr_bar_D = 0;
			enINC_D		= 0;
		       	state_D 	= ST_B1;
			enMODE		= 0;
			enMASK		= 0;
       	end

{ 7'b000xx00 },
{ 7'b000xx01 },
{ 7'b000xx10 },
{ 7'b001xxxx }: // alu operations; 
      		// more cycles if dest = PC or non-trivial shift
	begin
		rB = {mode, IR[3:0]};	// Rm

		Aop_sel = `AOP_APORT;

                if ( ~IR[25] & IR[4]) 
			begin 
//			rA = {mode, IRcurr[3:0]}; -- changed by Jian Shen 1.11.99
			rA = {mode, IR[11:8]};
			end
	        else
			begin
			rA = {mode, IR[19:16]};	// Rn
			end


		if ( IR[25]) 
			begin
			Bop_sel	= `BOP_IMM;
			imm_op	= 1;
			imm_amnt = 1;
			end
		else
			begin
			Bop_sel = `BOP_BPORT;
			imm_op 	= 0;
			imm_amnt = ~IR[4];
			end

		aluOperation 	= {1'b0,IR[24:21]};
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
                memoryWord_Byte_D = 1;
		wA		= {mode, IR[15:12]}; // Rd
		enMODE		= 0;
		enMASK		= 0;
		evalCondition_D = 1;

		if ( (zero_ror & IR[25]) | (zero_shift & ~IR[25]) )
			begin
			enW_D		= !(IR[24:23]==2'b10);
			writeStatus_D 	= IR[20] | (IR[24:23]==2'b10);
			if ( IR[15:12] == 4'd15)	// pc write
				begin
				state_D 	= ST_refillPipe1;
				enINC_D		= 0;
				AR_select_D 	= `AR_ALU;
				align_alu_addr_bar_D = 0;
				end
			else
				begin
				state_D 	= ST_READY;
				enINC_D		= 1;
				AR_select_D 	= `AR_INC;
				end
			end
		else
			begin
			enW_D		= 0;
			writeStatus_D 	= 0;
			state_D 	= ST_SHIFT;
			enINC_D		= 1;
			AR_select_D 	= `AR_INC;
			end

        end	// { 7'b00xxxxx }:
{ 7'b010x1xx},
{ 7'b011x100},
{ 7'b011x101},
{ 7'b011x110}: // LDR; 
	begin

		rA = {mode, IR[19:16]};		// Rn;
		rB = {mode, IR[3:0]};		// Rm;

		// forwarding for Aop
		Aop_sel = `AOP_APORT;

		imm_op = 0;
		imm_amnt = 1;		// shift amount may not be specified
						// by register

		if ( ~IR[25] )		// immediate: different as aluOps $#@!
			begin
			Bop_sel		= `BOP_LDST;
			end
		else 
			begin
			// forwarding for Bop
			Bop_sel = `BOP_BPORT;

		//	if (IR[4]) ; //undefined instruction -> trap ?
			end

		if ( IR[24] )	// pre-indexed
			if ( IR[23] )
				aluOperation 	= `ALU_add;
			else	
				aluOperation 	= `ALU_sub;
		else		// post-indexed
			aluOperation = `ALU_movA;


		if ( ~IR[25] | zero_shift & IR[25])
			begin
			state_D 	= ST_LDR1;	
			end			
		else
			begin
			state_D 	= ST_LDR0;
			end			

		ldstrByte_D	= IR[22];
       		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		wA		= rA;
		enW_D		= 0;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D 	= 0;
		evalCondition_D = 1;
		AR_select_D 	= `AR_ALU;
		enINC_D		= 1;
	end

{ 7'b010x0xx},
{ 7'b011x000},
{ 7'b011x001},
{ 7'b011x010}: // STR; 
	begin
		rA = {mode, IR[19:16]};	// Rn;
		rB = {mode, IR[3:0]};	// Rm;

		// forwarding for Aop
		Aop_sel = `AOP_APORT;

		imm_op = 0;
		imm_amnt = 1;	// never register spec. shift amount

		if ( !IR[25] )		// immediate: different as aluOps $#@!
			begin
			Bop_sel		= `BOP_LDST;
			end
		else 
			begin
			// forwarding for Bop
			Bop_sel = `BOP_BPORT;

//			if (IR[4]) ; //undefined instruction -> trap ?
			end
			// end forwarding

		if ( IR[24] )	// pre-indexed
			if ( IR[23] )
				aluOperation 	= `ALU_add;
			else	
				aluOperation 	= `ALU_sub;
		else		// post-indexed
			aluOperation = `ALU_movA;

		if ( ~IR[25] | zero_shift & IR[25])
			begin
			state_D 	= ST_STR1;	
			end			
		else
			begin
			state_D 	= ST_STR0;
			end			

		ldstrByte_D	= IR[22];
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		wA		= rA;
		enW_D		= 0;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D 	= 0;
		evalCondition_D = 1;
		AR_select_D 	= `AR_ALU;
		enINC_D		= 1;

	end

{ 7'b100x1xx}: 	// LDM; 
			// first execute cycle: address calculation
			// and prefetch
	begin
		rB = {mode, IR[19:16]};	// Rn

		// forwarding for Bop
		Bop_sel = `BOP_BPORT;

//		ShA_sel 	= `SHA_ZERO;
//		shiftType 	= `LSL;

//		regList_D = IR[15:0];
//		regList = IR[15:0];
                init_reglist	= 1;
		init_with_IRc_D	= 1;
		case (IR[24:23])
			2'b01:	// post-increment
				begin
				Aop_sel = `AOP_A;	// don't care
				aluOperation = `ALU_movB;
				end
			2'b00:	// post-decrement	
				begin
				Aop_sel = `AOP_REGCOUNT1;
				aluOperation = `ALU_rsb;
				end
			2'b11:	// pre-increment	
				begin
				Aop_sel = `AOP_4;
				aluOperation = `ALU_add;
				end
			2'b10:	// pre-decrement	
				begin
				Aop_sel = `AOP_REGCOUNT;
				aluOperation = `ALU_rsb;
				end
		endcase

		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		wA		= rB;	// Rn
		enW_D		= 0;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D 	= 0;
		evalCondition_D = 1;
		state_D		= ST_LDM1;
		AR_select_D 	= `AR_ALU;
		align_alu_addr_bar_D = 0;
		enINC_D		= 1;
	end

{ 7'b100x0xx}: 	// STM; 
			// first execute cycle: address calculation
			// and prefetch
	begin
		rB = {mode, IR[19:16]};	// Rn

		// forwarding for Bop
		Bop_sel = `BOP_BPORT;

//		ShA_sel 	= `SHA_ZERO;
//		shiftType 	= `LSL;

//		regList_D = IR[15:0];
//		regList = IR[15:0];
                init_reglist	= 1;
		init_with_IRc_D	= 1;
		case (IR[24:23])
			2'b01:	// post-increment
				begin
				Aop_sel = `AOP_A;
				aluOperation = `ALU_movB;
				end
			2'b00:	// post-decrement	
				begin
				Aop_sel = `AOP_REGCOUNT1;
				aluOperation = `ALU_rsb;
				end
			2'b11:	// pre-increment	
				begin
				Aop_sel = `AOP_4;
				aluOperation = `ALU_add;
				end
			2'b10:	// pre-decrement	
				begin
				Aop_sel = `AOP_REGCOUNT;
				aluOperation = `ALU_rsb;
				end
		endcase

		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		wA		= rB;	// Rn: base
		enW_D		= 0;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D 	= 0;
		evalCondition_D = 1;
		state_D		= ST_STM1;
		AR_select_D 	= `AR_ALU;
		align_alu_addr_bar_D = 0;
		enINC_D		= 1;
	end
	{ 7'b1111xxx }: // SWI
	begin
			swi		= 1;
 			memoryRead_D 	= 1;
			memoryWrite_D 	= 0;
                        memoryWord_Byte_D = 1;
			// causes incremented PC to be loaded in Aop
			// Aop_sel		= `AOP_INC;
			Aop_sel		= `AOP_EXC;
			aluOperation 	= `ALU_movA;
			writeStatus_D 	= 0;
			enW_D		= 0;
			evalCondition_D = 1;
			AR_select_D 	= `AR_ALU;
			align_alu_addr_bar_D = 0;
			enINC_D		= 0;
		       	state_D 	= ST_SWI1;
//                        MODEw		= `M_SVC;
			enMODE		= 0;
			enMASK		= 0;
			
       	end

default: 	// not an implemented instruction or undefined instruction
	 	// save address of the faulting instruction in R14_svc
		// currently like SWI (to be changed later on ...)
		// start fetching from &4
	begin
			undef_instr	= 1;
 			memoryRead_D 	= 1;
			memoryWrite_D 	= 0;
                        memoryWord_Byte_D = 1;
			// causes incremented PC to be loaded in Aop
			// Aop_sel		= `AOP_INC;
			Aop_sel		= `AOP_EXC;
			aluOperation 	= `ALU_movA;
			writeStatus_D 	= 0;
			enW_D		= 0;
			evalCondition_D = 1;
			AR_select_D 	= `AR_ALU;
			align_alu_addr_bar_D = 0;
			enINC_D		= 0;
		       	state_D 	= ST_SWI1;
                        MODEw		= `M_SVC;
			enMODE		= 1;
			enMASK		= 0;
			
	end	
		
	endcase // casex( {IR[27:24], IR[20], IR[7], IR[4]} )

	end

ST_SHIFT: 
	begin
		rB = {mode, IRcurr[3:0]}; // in case of a reg spec shift
	        rA = {mode, IRcurr[19:16]};
		Aop_sel = `AOP_APORT;
		Bop_sel	= `BOP_SHIFTOUT;

		aluOperation 	= {1'b0,IRcurr[24:21]};
		memoryRead_D 	= 0;
		memoryWrite_D 	= 0;
                memoryWord_Byte_D = 1;
		wA		= {mode, IRcurr[15:12]}; // Rd
		enMODE		= 0;
		enMASK		= 0;
		evalCondition_D = 0;

//		enW_D		= !(IR[24:23]==2'b10);		-- changed by Jian Shen 
		enW_D		= !(IRcurr[24:23]==2'b10);
		writeStatus_D 	= IRcurr[20] | (IRcurr[24:23]==2'b10);

		Ifetch_D	= 0;
		qFull_D		= 1;

		if ( IRcurr[15:12] == 4'd15)	// pc write
			begin
			state_D 	= ST_refillPipe1;
			enINC_D		= 0;
			AR_select_D 	= `AR_ALU;
			align_alu_addr_bar_D = 0;
			end
		else
			begin
			state_D 	= ST_READY;
			enINC_D		= 0;
			AR_select_D 	= `AR_PC;
			end			
        end

ST_refillPipe1: // refill pipe after flow has been changed
	begin
		enW_D		= 0;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
//		AR_select_D 	= `AR_INC;	-- changed by Jian Shen
		AR_select_D 	= `AR_PC;
		Ifetch_D	= 1;
		qFull_D		= 0;
		enINC_D		= 1;		
		state_D 	= ST_refillPipe2;
	end

ST_refillPipe2: // refill pipe after flow has been changed
	begin
		enW_D		= 0;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
//		AR_select_D 	= `AR_INC;	-- changed by Jian Shen 1.10.99
		AR_select_D 	= `AR_PC;
		Ifetch_D	= 1;
		qFull_D		= 0;
		enINC_D		= 1;	
		state_D 	= ST_READY;
	end

ST_B1:
	begin
		rB		= {mode, 4'd15};
		Bop_sel		= `BOP_BPORT;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		aluOperation 	= `ALU_movB;
//		ShA_sel		= `SHA_ZERO;
		wA 		= {mode, 4'd14};
		enW_D 		= IRcurr[24];	// branch with link
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		AR_select_D 	= `AR_INC;
		Ifetch_D	= 1;
		qFull_D		= 0;
		enINC_D		= 0;
		state_D 	= ST_B2;
	end
ST_B2:
	begin
		rB = {mode, 4'd14};

		// forwarding for Bop
		Bop_sel = `BOP_BPORT;

		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		Aop_sel 	= `AOP_4;
		aluOperation 	= `ALU_rsb;
//		ShA_sel		= `SHA_ZERO;
		wA 		= {mode, 4'd14};
		enW_D 		= IRcurr[24];	// branch with link
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		AR_select_D 	= `AR_INC;
		Ifetch_D	= 1;
		qFull_D		= 0;
		enINC_D		= 1;
		state_D 	= ST_READY;
	end


ST_LDR0:
	begin
		Aop_sel = `AOP_A;
		Bop_sel	= `BOP_SHIFTOUT;

		if ( IRcurr[24] )	// pre-indexed
			if ( IRcurr[23] )
				aluOperation 	= `ALU_add;
			else	
				aluOperation 	= `ALU_sub;
		else		// post-indexed
			aluOperation = `ALU_movA;

		ldstrByte_D	= IRcurr[22];
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		wA		= {mode, IRcurr[19:16]};
		enW_D		= 0;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D 	= 0;
		evalCondition_D = 0;
       		state_D 	= ST_LDR1;
		AR_select_D 	= `AR_ALU;
		enINC_D		= 1;
	end



ST_LDR1:
	begin
		Aop_sel		= `AOP_A;
		Bop_sel		= `BOP_B;
//		byte			= aluOut[1:0];
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = ldstrByte_Q;
		ldstrByte_D	= ldstrByte_Q;
		if ( IRcurr[23] )	// if post-indexed: calculate new base
			aluOperation 	= `ALU_add;
		else
			aluOperation 	= `ALU_sub;
		wA 		= {mode, IRcurr[19:16]};	// changed
		// post indexed -> always writeBack
		enW_D 		= IRcurr[21] | ~IRcurr[24];
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		AR_select_D 	= `AR_PC;
		Ifetch_D	= 0;
		qFull_D		= 1;
		enINC_D		= 0;
		state_D 	= ST_LDR2;
	end



ST_LDR2:
	begin
		// Aop_sel		= 'bx;
		// Bop_sel		= `BOP_DB;
		sDin_D 		= 1;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		enINC_D		= 0;
		AR_select_D 	= `AR_PC;
		aluOperation 	= `ALU_movB;
//		shiftType	= `LSL;
		wA 		= {mode, IRcurr[15:12]};	// Rd
		enW_D 		= 1;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		Ifetch_D		= 0;
		qFull_D		= 1;
		if ( (4'd15 == IRcurr[15:12]) || (IRcurr[21] && ( 4'd15 == wAin[3:0])))
			state_D 	= ST_refillPipe1;
		else
			state_D	= ST_READY;
	end

ST_STR0:
	begin
		Aop_sel = `AOP_A;
		Bop_sel = `BOP_SHIFTOUT;

		if ( IRcurr[24] )	// pre-indexed
			if ( IRcurr[23] )
				aluOperation 	= `ALU_add;
			else	
				aluOperation 	= `ALU_sub;
		else		// post-indexed
			aluOperation = `ALU_movA;



		ldstrByte_D	= IRcurr[22];
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		wA		= {mode, IRcurr[19:16]};
		enW_D		= 0;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D 	= 0;
		evalCondition_D = 0;
	       	state_D 	= ST_STR1;	
		AR_select_D 	= `AR_ALU;
		enINC_D		= 0;

	end


ST_STR1:
	begin
		rB		= {mode, IRcurr[15:12]};	// Rd
		Aop_sel		= `AOP_A;
		Bop_sel		= `BOP_B;
		AR_select_D 	= `AR_PC;
		enINC_D		= 0;
		memoryRead_D 	= 0;
		memoryWrite_D 	= 1;
		memoryWord_Byte_D = ldstrByte_Q;
		if ( IRcurr[23] )	// if post-indexed: calculate new base
			aluOperation 	= `ALU_add;
		else
			aluOperation 	= `ALU_sub;
//		ShA_sel		= `SHA_SHA;
		wA 		= {mode, IRcurr[19:16]};
		// post-indexed: always WB
		enW_D 		= IRcurr[21] | ~IRcurr[24]; 
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		Ifetch_D	= 0;
		qFull_D		= 1;
		state_D		= ST_READY;
	end

ST_LDM1:	// base modification and fetching first data
	begin
		rA 		= {mode, IRcurr[19:16]};	// Rn
		Aop_sel		= `AOP_APORT;
		Bop_sel		= `BOP_REGCOUNT;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;

		if (IRcurr[23])	// increment
				aluOperation = `ALU_add;
		else		// decrement
				aluOperation = `ALU_sub;

//		ShA_sel		= `SHA_ZERO;
//		shiftType	= `LSL;
		wA		= {mode, IRcurr[19:16]};
		enW_D 		= IRcurr[21];
                init_reglist 	= 1;
//		regList		= regList_Q;
//		regList_D	= updatedRegList;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		AR_select_D 	= `AR_INC;
		Ifetch_D	= 0;
		qFull_D		= 1;
		enINC_D		= 0;
		state_D		= ST_LDMloop;
		end

ST_LDMloop:	// write register; fetch data; 
	begin
		Aop_sel		= `AOP_A;
		// Bop_sel		= `BOP_DIN;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;		
		aluOperation 	= `ALU_movB;
		sDin_D		= 1;
//		ShA_sel		= `SHA_ZERO;
//		shiftType	= `LSL;
		wA 			= xRegin;
		enW_D 		= 1;
//		regList		= regList_Q;
//		regList_D	= updatedRegList;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		Ifetch_D	= 0;
		qFull_D		= 1;
		enINC_D		= 0;
		if (~regListEmpty) 
			begin
			AR_select_D 	= `AR_INC;
			state_D     	= ST_LDMloop;
			end
		else 	begin
			AR_select_D 	= `AR_PC;			
			if ( xRegin[3:0] == 4'd15) 
				begin
				state_D = ST_refillPipe1;
				end
			else
				begin
				state_D	= ST_READY;
				end
		       	end
			
	end

ST_STM1:	// base modification and storing first register
		// termination if only one register to be stored
	begin
		rA 		= {mode, IRcurr[19:16]};	// Rn
		rB		= xRegin;
		Aop_sel		= `AOP_APORT;
		Bop_sel		= `BOP_REGCOUNT;
		memoryRead_D 	= 0;
		memoryWrite_D 	= 1;
		memoryWord_Byte_D = 1;		// store word

		if (IRcurr[23])	// increment
				aluOperation = `ALU_add;
		else		// decrement
				aluOperation = `ALU_sub;

//		ShA_sel		= `SHA_ZERO;
//		shiftType	= `LSL;
		wA 		= {mode, IRcurr[19:16]};
		enW_D 		= IRcurr[21];	// update base if requested
//		regList		= regList_Q;
//		regList_D	= updatedRegList;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		if (regListEmpty)
			begin
			AR_select_D 	= `AR_PC;
			state_D 	= ST_READY;
			end
		else
			begin
			AR_select_D 	= `AR_INC;
			state_D 	= ST_STMloop;
			end
		Ifetch_D	= 0;
		qFull_D		= 1;
		enINC_D		= 0;
 	end

ST_STMloop:	// loop and termination
	begin
		rB		= xRegin;
		Aop_sel		= `AOP_APORT;
		Bop_sel		= `BOP_REGCOUNT;
		memoryRead_D 	= 0;
		memoryWrite_D 	= 1;
		memoryWord_Byte_D = 1;		// store word
//		ShA_sel		= `SHA_ZERO;
//		shiftType	= `LSL;
		wA 		= 6'd0;		// changed!!!!
		enW_D 		= 0;
//		regList		= regList_Q;
//		regList_D	= updatedRegList;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		Ifetch_D	= 0;
		qFull_D		= 1;
		enINC_D		= 0;
		if (regListEmpty)
			begin
			AR_select_D 	= `AR_PC;
			state_D 	= ST_READY;
			end
		else
			begin
			AR_select_D 	= `AR_INC;
			state_D 	= ST_STMloop;
			end

	end



ST_SWI1:
	begin
		rB		= {mode, 4'd15};
		Bop_sel		= `BOP_BPORT;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		aluOperation 	= `ALU_movB;
		wA 		= {`M_SVC, 4'd14};
		enW_D 		= 1;       // write link reg of svc
		MODEw		= `M_SVC;
		enMODE		= 1;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		AR_select_D 	= `AR_INC;
		Ifetch_D	= 1;
		qFull_D		= 0;
		enINC_D		= 0;
		state_D 	= ST_SWI2;
	end
ST_SWI2:
	begin
		rB 		= {mode, 4'd14};
		Bop_sel 	= `BOP_BPORT;
		memoryRead_D 	= 1;
		memoryWrite_D 	= 0;
		memoryWord_Byte_D = 1;
		Aop_sel 	= `AOP_4;
		aluOperation 	= `ALU_rsb;
		wA 		= {mode, 4'd14};
		enW_D 		= 1;
		enMODE		= 0;
		enMASK		= 0;
		writeStatus_D	= 0;
		evalCondition_D = 0;
		AR_select_D 	= `AR_INC;
		Ifetch_D	= 1;
		qFull_D		= 0;
		enINC_D		= 1;
		state_D 	= ST_READY;
	end

		
	endcase // case (state)


        end 	// logic 


			
endmodule

 







