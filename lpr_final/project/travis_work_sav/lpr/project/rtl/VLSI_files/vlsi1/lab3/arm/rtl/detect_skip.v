//
// detect_skip.v
//
// David Van Campenhout
//
// no ffs
//



// condition flags

`define CF_N		3
`define CF_Z		2
`define CF_C		1
`define CF_V		0

// condition codes

`define COND_EQ 	4'b0000	
`define COND_NE 	4'b0001
`define COND_CS 	4'b0010
`define COND_CC 	4'b0011
`define COND_MI 	4'b0100
`define COND_PL 	4'b0101
`define COND_VS 	4'b0110
`define COND_VC 	4'b0111
`define COND_HI 	4'b1000
`define COND_LS 	4'b1001
`define COND_GE 	4'b1010
`define COND_LT 	4'b1011
`define COND_GT 	4'b1100
`define COND_LE 	4'b1101
`define COND_AL 	4'b1110
`define COND_NV 	4'b1111


module detect_skip( stat, cond, evalCondition, skip);
  
  input [3:0]	stat;	// datapath status bits of psr
  input [3:0]	cond;	// condition flags of instruction
  input		evalCondition; 

  output	skip;
  reg		ex;

  always begin : logic
	@( stat or cond or evalCondition)
        ex = 1;
	if (evalCondition) 
		case (cond)
			`COND_EQ: ex = stat[`CF_Z];
			`COND_NE: ex = !stat[`CF_Z];
			`COND_CS: ex = stat[`CF_C];
			`COND_CC: ex = !stat[`CF_C];
			`COND_MI: ex = stat[`CF_N];
			`COND_PL: ex = !stat[`CF_N];
			`COND_VS: ex = stat[`CF_V];
			`COND_VC: ex = !stat[`CF_V];
			`COND_HI: ex = ( stat[`CF_C] && !stat[`CF_Z]);
			`COND_LS: ex = (!stat[`CF_C] ||  stat[`CF_Z]);
			`COND_GE: ex = (( stat[`CF_N] &&  stat[`CF_V]) ||
				   	(!stat[`CF_N] && !stat[`CF_V]));
			`COND_LT: ex = (( stat[`CF_N] && !stat[`CF_V]) ||
				   	(!stat[`CF_N] &&  stat[`CF_V]));
			`COND_GT: ex = ( !stat[`CF_Z] && 
				(( stat[`CF_N] &&  stat[`CF_V]) ||
				 (!stat[`CF_N] && !stat[`CF_V])));
			`COND_LE: ex = ( stat[`CF_Z] ||
				( stat[`CF_N] && !stat[`CF_V]) ||
				(!stat[`CF_N] &&  stat[`CF_V]));
			`COND_AL: ex = 1;
			`COND_NV: ex = 0;
		endcase
	else
		ex = 1;        
     	end 	// logic

  assign skip = ~ex;

endmodule

