//
// aluflags.f
//
// David Van Campenhout
//
// no ffs
//
//


// condition flags

`define CF_N		3
`define CF_Z		2
`define CF_C		1
`define CF_V		0



module aluflags( carry_in, ovf_in, zero_in, neg_in, 
		oldOverflow, shiftCarry, alu_m,
		flagsOut);

  input		carry_in;
  input		ovf_in;
  input		zero_in;
  input		neg_in;
  input 	oldOverflow;
  input 	shiftCarry;
  input		alu_m;

  output [3:0]	flagsOut;
  reg [3:0]	flagsOut;


  always begin : logic	
	@( ovf_in or carry_in or alu_m or zero_in or neg_in or 
         shiftCarry or oldOverflow)
        
	flagsOut[`CF_Z] = zero_in;
	flagsOut[`CF_N] = neg_in;

	if (alu_m)	// arithmetic operation
		begin
		flagsOut[`CF_V] = ovf_in;
		flagsOut[`CF_C] = carry_in;
		end
	else
		begin
		flagsOut[`CF_V] = oldOverflow;
		flagsOut[`CF_C] = shiftCarry;
		end
	end	// always @()

endmodule





