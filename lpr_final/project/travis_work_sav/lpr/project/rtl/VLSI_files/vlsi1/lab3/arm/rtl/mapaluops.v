//
// mapaluops.v
//
// David Van Campenhout
//
// combinational logic for mapping ARM alu opcodes to CASCADE alu
//

`define CA_0	2'b00 
`define CA_1	2'b01
`define CA_CABAR 2'b10
`define CA_CA	2'b11

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

module mapaluops(clk, clear, opin, 
      		alu_s, alu_m, sel_c, reverse, clearA_bar, clearB_bar);

  input			clk;
  input			clear;
  input 	[4:0]	opin;
  output	[3:0]	alu_s;
  output		alu_m;
  output	[1:0]	sel_c;
  output		reverse;
  output		clearA_bar;
  output		clearB_bar;

  reg		[3:0]	alu_s;
  reg			alu_m;
  reg		[1:0]	sel_c;
  reg 			reverse;

  reg			clearA_bar;
  reg			clearB_bar;

  reg		[3:0]	alu_s_D;
  reg			alu_m_D;
  reg		[1:0]	sel_c_D;
  reg 			reverse_D;

  reg			clearA_bar_D;
  reg			clearB_bar_D;




  always begin : logic
	@( opin)
	clearA_bar_D = 1;
	clearB_bar_D = 1;
	alu_s_D = 4'b1111;
	alu_m_D = 0;
	sel_c_D = `CA_0;
	reverse_D = 0;

	 case (opin)
		`ALU_and:
			begin
			alu_s_D = 4'b1110;
			alu_m_D = 0;
			reverse_D = 0;
			end
		`ALU_eor:
			begin
			alu_s_D = 4'b1001;
			alu_m_D = 0;
			reverse_D = 0;
			end
		`ALU_sub:
			begin
			alu_s_D = 4'b0110;
			alu_m_D = 1;
			sel_c_D = `CA_1;
			reverse_D = 0;
			end
		`ALU_rsb:
			begin
			alu_s_D = 4'b0110;
			alu_m_D = 1;
			sel_c_D = `CA_1;
			reverse_D = 1;
			end
		`ALU_add:
			begin
			alu_s_D = 4'b1001;
			alu_m_D = 1;
			sel_c_D = `CA_0;
			reverse_D = 0;
			end
		`ALU_adc:
			begin
			alu_s_D = 4'b1001;
			alu_m_D = 1;
			sel_c_D = `CA_CA;
			reverse_D = 0;
			end
		`ALU_sbc:
			begin
			alu_s_D = 4'b0110;
			alu_m_D = 1;
			sel_c_D = `CA_CA;
			reverse_D = 0;
			end
		`ALU_rsc:
			begin
			alu_s_D = 4'b0110;
			alu_m_D = 1;
			sel_c_D = `CA_CA;
			reverse_D = 1;
			end
		`ALU_tst:
			begin
			alu_s_D = 4'b1110;
			alu_m_D = 0;
			reverse_D = 0;
			end
		`ALU_teq:
			begin
			alu_s_D = 4'b1001;
			alu_m_D = 0;
			reverse_D = 0;
			end
		`ALU_cmp:
			begin
			alu_s_D = 4'b0110;
			alu_m_D = 1;
			sel_c_D = `CA_1;
			reverse_D = 0;
			end
		`ALU_cmn:
			begin
			alu_s_D = 4'b1001;
			alu_m_D = 1;
			sel_c_D = `CA_0;
			reverse_D = 0;
			end
		`ALU_orr:
			begin
			alu_s_D = 4'b1011;
			alu_m_D = 0;
			reverse_D = 0;
			end
		`ALU_movB:
			begin
			alu_s_D = 4'b1010;
			alu_m_D = 0;
			reverse_D = 0;
			clearA_bar_D = 0;
			end
		`ALU_bic:
			begin
			alu_s_D = 4'b1101;
			alu_m_D = 0;
			reverse_D = 0;
			end
		`ALU_movnB:
			begin
			alu_s_D = 4'b0101;
			alu_m_D = 0;
			reverse_D = 0;
			clearA_bar_D = 0;
			end
		`ALU_movA:
			begin
			alu_s_D = 4'b1111;
			alu_m_D = 0;
			reverse_D = 0;
			clearB_bar_D = 0;
			end
		default:
			begin
			alu_s_D = 4'b1111;
			alu_m_D = 0;
			reverse_D = 0;
			clearB_bar_D = 0;
			end
	endcase
	end // logic


  always @(posedge clk or negedge clear)
	begin
	if (!clear)
		begin
			alu_s 		<= #2 4'b1111;
			alu_m 		<= #2 0;
			sel_c 		<= #2 `CA_0;
			reverse 		<= #2 0;
			clearA_bar 	<= #2 1;
			clearB_bar 	<= #2 0;
		end
	else
		begin
			alu_s 		<= #2 alu_s_D;    
			alu_m 		<= #2 alu_m_D;    
			sel_c 		<= #2 sel_c_D;   
			reverse 		<= #2 reverse_D;
			clearA_bar 	<= #2 clearA_bar_D;
			clearB_bar 	<= #2 clearB_bar_D;
		end
	end

endmodule
