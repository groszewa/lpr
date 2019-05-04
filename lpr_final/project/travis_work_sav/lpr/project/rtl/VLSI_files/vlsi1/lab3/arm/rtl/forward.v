//
// forward.v
//
// David Van Campenhout
//
// forwarding for the operands
//
// no ffs

`define AOP_APORT		4'b0000
`define AOP_A			4'b0001
`define AOP_REGCOUNT	4'b0011
`define AOP_REGCOUNT1	4'b0111
`define AOP_4			4'b1011

`define BOP_IMM		4'b0111
`define BOP_LDST		4'b1111
`define BOP_REGCOUNT	4'b0011

`define BOP_BPORT		4'b0000
`define BOP_SHIFTOUT	4'b0001
`define BOP_BRANCH		4'b0010
`define BOP_B			4'b0110

`define FORWARD_EX		2'b00
`define FORWARD_PC		2'b01
`define FORWARD_STAT	2'b10
`define FORWARD_NOT		2'b11

module 
forward( 	rA, rB, wA, enW, enINC, writeStatus, Aop_sel, Bop_sel,
      	forwardonA, forwardonB);

  input [5:0]	rA;
  input [5:0]	rB;
  input	[5:0]	wA;
  input		enW;
  input		enINC;
  input		writeStatus;
  input	[3:0]	Aop_sel;
  input	[3:0]	Bop_sel;

  output [1:0]	forwardonA;
  output [1:0]	forwardonB;

  reg [1:0]	forwardonA;
  reg [1:0]	forwardonB;

  always begin : logic
	@(rA or rB or wA or enINC or enINC or enW or Aop_sel or Bop_sel 
        or writeStatus)
        	forwardonA = `FORWARD_NOT;
        	forwardonB = `FORWARD_NOT;
		
		if (Aop_sel == `AOP_APORT )
			begin
			if (((rA ^ wA) == 6'b0) && enW)
				forwardonA = `FORWARD_EX;
			else if ((rA[3:0] == 4'd15) && enINC)
				forwardonA = `FORWARD_PC;
			else
				forwardonA = `FORWARD_NOT;
			end
		else
			forwardonA = `FORWARD_NOT;


		if (Bop_sel == `BOP_BPORT)
			begin
			if (((rB ^ wA) == 6'b0) && enW)
				forwardonB 	= `FORWARD_EX;	
			else if ((rB[3:0] == 4'd15) && enINC)
				forwardonB 	= `FORWARD_PC;
			else if (writeStatus & (rB[3:0] == 4'd15))
				forwardonB = `FORWARD_STAT;
			else 
        	           	forwardonB = `FORWARD_NOT;
			end
		else
			forwardonB = `FORWARD_NOT;

		// end forwarding

  	end // always
  

endmodule
