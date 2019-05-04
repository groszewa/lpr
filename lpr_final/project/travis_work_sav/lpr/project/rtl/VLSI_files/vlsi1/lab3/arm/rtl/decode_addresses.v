//
// decode_addresses.v
//
// David Van Campenhout
//
// decode addresses for regfile
//
// no ffs



module 
decode_addresses(	rA, rB, wA, enW, enINC, enMODE, enMASK, enCOND, 
				mode, mrA, mrB, mwA, 
				sel_A, sel_B, sel_stat, sel_mask, sel_inc, sel_mode, 
				en_regfile, en_IRQ13, en_SVC13, 
				en_stat, en_mask, en_pcAddr, en_mode );
  
  input [5:0]	rA;	// number of physical register to be read on A port
  input [5:0]	rB;	// number of physical register to be read on B port
  input [5:0]	wA;

  input		enW;
  input		enINC;
  input		enMODE;
  input		enMASK;
  input		enCOND;

  input [1:0] 	mode;	// to check whether user mode

  output [4:0]	mrA;	// mapped rA
  output [4:0]	mrB;	// mapped rB
  output [4:0]	mwA;	// mapped wA

  output [1:0]	sel_A;
  output [1:0]	sel_B;
  output	sel_stat;
  output	sel_mask;
  output	sel_inc;
  output	sel_mode;

  output	en_regfile;
  output	en_IRQ13;
  output	en_SVC13;
  output	en_stat;
  output	en_mask;
  output	en_pcAddr;
  output	en_mode;

  reg	 [4:0]	mrA;	// mapped rA
  reg	 [4:0]	mrB;	// mapped rB
  reg	 [4:0]	mwA;	// mapped wA

  reg	 [1:0]	sel_A;
  reg	 [1:0]	sel_B;
  reg		sel_stat;
  reg		sel_mask;
  reg		sel_inc;
  reg		sel_mode;

  reg		en_regfile;
  reg		en_IRQ13;
  reg		en_SVC13;
  reg		en_stat;
  reg		en_mask;
  reg		en_pcAddr;
  reg		en_mode;

`define M_USER	2'b00
`define M_FIRQ	2'b01
`define M_IRQ	2'b10
`define M_SVC	2'b11



`define MUX_REGFILE	2'd0
`define MUX_IRQ13	2'd1
`define MUX_SVC13	2'd2
`define MUX_PC		2'd3


  always begin: logic
	@(rA or rB or wA or enMODE or enW or enINC or enMASK or enCOND or mode)

	en_pcAddr = 0;
	en_stat = 0;
	en_mask = 0;
	en_mode = 0; 
	en_SVC13 = 0;
	en_IRQ13 = 0;
	en_regfile = 0;
	sel_mode = 0;
	sel_stat = 0;
	sel_inc = 0;
	sel_mask = 0;

	
	// map read address port A
	if (rA[3:0] == 4'd15)
		begin
		sel_A = `MUX_PC;		
		end
	else
		begin
		case (rA[5:4])
		`M_USER:	// map R0U - R15U to 0 - 15
				begin
				mrA = { 1'b0, rA[3:0]};
				sel_A = `MUX_REGFILE;
				end
		`M_FIRQ: 	// map R8F - R14F to 16 - 22
			begin
			if (!rA[3]) // (rA[3:0] < 4'd8)
				mrA = {1'b0, rA[3:0]};
			else
				mrA = {2'b10, rA[2:0]};
			sel_A = `MUX_REGFILE;
			end
		`M_IRQ:	// map R14I to 15
			begin
			if ( !( (rA[3:2] == 2'b11) && ( rA[1] | rA[0] ))) // ( rA[3:0] < 4'd13 )
				begin
				mrA = {1'b0, rA[3:0]};
				sel_A = `MUX_REGFILE;
				end
			else if ( rA[3:0] == 4'd13)
				begin
				sel_A = `MUX_IRQ13;
				end
			else
				begin
				mrA = 5'd15;
				sel_A = `MUX_REGFILE;
				end
			end
		`M_SVC: // map R14S to 23
			begin
			if ( !( (rA[3:2] == 2'b11) && ( rA[1] | rA[0] ))) // ( rA[3:0] < 4'd13 )
				begin
				mrA ={1'b0, rA[3:0]};
				sel_A = `MUX_REGFILE;
				end
			else if ( rA[3:0] == 4'd13)
				begin
				sel_A = `MUX_SVC13;
				end
			else
				begin
				mrA = 5'd23;
				sel_A = `MUX_REGFILE;
				end
			end
		endcase
		end	// if (rA[3:0] == 4'd15) else

	// map read address port B
	if (rB[3:0] == 4'd15)
		begin
		sel_B = `MUX_PC;		
		end
	else
		begin
		case (rB[5:4])
			`M_USER:
				begin
				mrB = { 1'b0, rB[3:0]};
				sel_B = `MUX_REGFILE;
				end
		`M_FIRQ: // map R8F - R14F to 16 - 22
			begin
			if (!rB[3]) // (rB[3:0] < 4'd8) 
				mrB = {1'b0, rB[3:0]};
			else
				mrB = {2'b10, rB[2:0]};
			sel_B = `MUX_REGFILE;
			end
		`M_IRQ:	// map R14I to 15
			begin
			if ( !( (rB[3:2] == 2'b11) && ( rB[1] | rB[0] )))  //( rB[3:0] < 4'd13 )
				begin
				mrB = {1'b0, rB[3:0]};
				sel_B = `MUX_REGFILE;
				end
			else if ( rB[3:0] == 4'd13)
				begin
				sel_B = `MUX_IRQ13;
				end
			else
				begin
				mrB = 5'd15;
				sel_B = `MUX_REGFILE;
				end
			end
		`M_SVC: // map R14S to 23
			begin
			if ( !( (rB[3:2] == 2'b11) && ( rB[1] | rB[0] ))) // ( rB[3:0] < 4'd13 )
				begin
				mrB ={1'b0, rB[3:0]};
				sel_B = `MUX_REGFILE;
				end
			else if ( rB[3:0] == 4'd13)
				begin
				sel_B = `MUX_SVC13;
				end
			else
				begin
				mrB = 5'd23;
				sel_B = `MUX_REGFILE;
				end
			end
		endcase
		end	// if (rB[3:0] == 4'd15) else

	// map write address
		
	if (wA[3:0] != 4'd15)
		begin
		case (wA[5:4])
		`M_USER:
			begin
			mwA = { 1'b0, wA[3:0]};
			end
		`M_FIRQ: // map R8F - R14F to 16 - 22
			begin
			if (!wA[3])        // ( wA[3:0] < 4'd8)
				mwA = {1'b0, wA[3:0]};
			else
				mwA = {2'b10, wA[2:0]};
			end

		`M_IRQ:	// map R14I to 15
			begin
			if ( !( (wA[3:2] == 2'b11) && ( wA[1] | wA[0] ))) // ( wA[3:0] < 4'd13 )	
				begin
				mwA = {1'b0, wA[3:0]};
				end
			else if ( wA[3:0] != 4'd13)
				begin
				mwA = 5'd15;
				end
// else
//	begin
//	end
			end
		`M_SVC: // map R14S to 23
			begin
			if ( !( (wA[3:2] == 2'b11) && ( wA[1] | wA[0] ))) // ( wA[3:0] < 4'd13 )
				begin
				mwA ={1'b0, wA[3:0]};
				end
			else if ( wA[3:0] != 4'd13)
				begin
				mwA = 5'd23;
				end
//			else
//				begin
//				end
			end
		endcase
		end	// if (wA[3:0] != 4'd15) 
		

	// set enables




	if (enW)
		begin
		if ( wA[3:0] == 4'd15)
			begin
			en_pcAddr = 1;
			if ( mode != 2'd0)
				begin
				en_stat = 1;
				en_mask = 1;
				en_mode = 1;
				end
			end
		else // wA[3:0] != 4'd15
			begin
			if (enINC)
				begin
				en_pcAddr 	= 1;
				sel_inc 	= 1;
				end
			if (enCOND)
				begin
				en_stat  = 1;
				sel_stat = 1;
				end
			if (enMODE)
				begin
				en_mode  = 1;
				sel_mode = 1;
				end
			if (enMASK)
				begin
				en_mask  = 1;
				sel_mask = 1;
				end
			if ( wA == {`M_IRQ, 4'd13} )
				en_IRQ13 = 1;
			else if ( wA == {`M_SVC, 4'd13} )
				en_SVC13 = 1;
			else
				en_regfile = 1;
			end
		end // if (enW)
	else	// !enW
		begin
			en_regfile = 0;
			if (enMODE)
				begin
				en_mode  = 1;
				sel_mode = 1;
				end
			if (enMASK)
				begin
				en_mask  = 1;
				sel_mask = 1;
				end
			if (enINC)
				begin
				en_pcAddr 	= 1;
				sel_inc 	= 1;
				end
			if (enCOND)
				begin
				en_stat  = 1;
				sel_stat = 1;
				end
		end


  	end // always
endmodule

/********

assign wAisPC = wA[3:0] == 4'd15;
assign en_stat = enW & wAisPC & (mode != 2'd0) 
		| 
assign en_pcAddr = enW & wAisPC & 

**********/












