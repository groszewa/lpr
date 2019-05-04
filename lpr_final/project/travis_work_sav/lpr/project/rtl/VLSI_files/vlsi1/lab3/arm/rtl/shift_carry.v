//
// shift_carry.f
//
// David Van Campenhout
//
// logic for shift carry
//




`define LSL	3'b000
`define LSR	3'b001
`define ASR	3'b010
`define ROR	3'b011
`define RRX	3'b111

module shift_carry( 	clk, clear, test,
			shiftType, Aport, imm_amnt, gte32, in31, in0, 
			 carry_in, carryR, carryS, carry_out);

  input		clk;
  input 		clear;
  input		test;

  input [2:0]	shiftType;
  input	[7:0]	Aport;
  input		imm_amnt;	// immediate specified shift amount

  input		gte32;		// shift amount >= 32

  input		in31;
  input		in0;
  input		carry_in;
  input		carryR;
  input		carryS;

  output	carry_out;

  wire		zero;		// shiftAmount == 0
  wire		over32;		// shiftAmount > 32

  reg		carry_out;
  reg		carry_out_D;

  assign	zero = (Aport  == 8'b0 ) & !imm_amnt;
  assign 	over32 = ~imm_amnt & gte32 & 
      ( Aport[4] | Aport[3] | Aport[2] | Aport[1] | Aport[0] );


  always 
  @(posedge clk or negedge clear)
  	begin
	if (!clear)
		begin
			carry_out = 0;
		end
	else
		begin
                	carry_out = carry_out_D;
		end
	end	
			

		
  always @( in0 or in31 or carryR or carryS or
	 	shiftType or carry_in or zero or over32)
  begin

  if (zero)
	carry_out_D = carry_in;
  else case (shiftType)
	`LSL:
		if (over32)
			carry_out_D = 0;
		else 
			carry_out_D = carryR;
	`LSR:
		if (over32)
			carry_out_D = 0;
		else
			carry_out_D = carryS;
	`ASR:
		if (over32)
			carry_out_D = in31;
		else
			carry_out_D = carryS;
	`ROR:
		carry_out_D = carryS;
	`RRX:
		carry_out_D = in0;
	default:
		if (over32)
			carry_out_D = 0;
		else 
			carry_out_D = carryR;
	endcase

  end // logic


		
endmodule



