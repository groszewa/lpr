module ALU (
CLK,
RST,
A,
B,
CIN,
OPCODE,
OUT,
COUT,
VOUT
);

// Inputs and Outputs
input                 CLK, RST;
input signed  [31:0]  A,B;
input                 CIN;
input         [4:0]   OPCODE;

output reg    [31:0]  OUT;
output reg            COUT, VOUT;

// Internal Signals
reg signed    [31:0]  r_alu_out;
reg                   r_alu_cout, r_alu_vout;
reg                   r_comp_out;

wire unsigned [31:0]  w_A, w_B;
reg  unsigned [31:0]  r_uSHF;
reg  signed   [31:0]  r_SHF;

// Assignments
assign w_A = A;
assign w_B = B;

// ALU Operations
always@(*) begin

	case (OPCODE)
	
	// Logical Operations
	
	5'b00_000 : begin
		r_alu_out = {~A[31:17],A[16],~A[15:0]};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;
	end
	
	5'b00_011 : begin
		r_alu_out = A^B;
		r_alu_cout = 1'b0;
		r_alu_vout = &A? 1'b1 : 1'b0;
	end
	
	5'b00_101 : begin
		r_alu_out = {1'b0,(A[30:0] & B[30:0])};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;
	end
	
	5'b00_111 : begin
		r_alu_out = A | B;
		r_alu_cout = (~(|A) & ~(|B))? 1'b1 : 1'b0;
		r_alu_vout = 1'b0;
	end
	
	// Comparator operations
	
	5'b01_100 : begin // sle
		r_comp_out = A < B;
		r_alu_out = {31'd0, r_comp_out};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;		
	end
		
	5'b01_001 : begin // slt
		r_comp_out = A <= B;
		r_alu_out = {31'd0, r_comp_out};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;		
	end
	
	5'b01_110 : begin // sge
		r_comp_out = A >= B;
		r_alu_out = {31'd0, r_comp_out};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;		
	end
	
	5'b01_011 : begin // sgt
		r_comp_out = A > B;
		r_alu_out = {31'd0, r_comp_out};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;		
	end
	
	5'b01_111 : begin // seq
		r_comp_out = A == B;
		r_alu_out = {4'hF,27'd0, r_comp_out};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;		
	end
	
    5'b01_010 : begin // sne
		r_comp_out = A != B;
		r_alu_out = {31'd0, r_comp_out};
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;		
	end
	
	// Arithmetic operations
	
	5'b10_101 : begin // add
		{r_alu_cout, r_alu_out} = {1'b0,A} + {1'b0,B} + CIN;
		r_alu_vout = (A[31] == B[31]) ? (r_alu_out[31] != A[31]) : 1'b0;
	end
	
	5'b10_001 : begin // addu
		{r_alu_cout, r_alu_out} = {1'b0,A} + {1'b0,B}; // + CIN;
		r_alu_vout = r_alu_cout;
	end
	
	5'b10_100 : begin // sub
		{r_alu_cout, r_alu_out} = {1'b0,A} + ~{B[31],B} + CIN;
		r_alu_vout = ~(A[31] != B[31]) ? (r_alu_out[31] != A[31]) : 1'b0;
	end
	
	5'b10_000 : begin // subu
		{r_alu_cout, r_alu_out} = {1'b0,A} + ~{B[31],B} + CIN;
		r_alu_vout = 1'b0;
	end
		
	5'b10_111 : begin // inc
		{r_alu_cout, r_alu_out} = {1'b1,A} + {32'd0,1'b1};
		r_alu_vout = ~A[31] ? (r_alu_out[31] != A[31]) : 1'b0;
	end
	
	5'b10_110 : begin // dec
		{r_alu_cout, r_alu_out} = {1'b0,A} + 33'h1_FFFF_FFFF;
		r_alu_vout = A[31] ? (r_alu_out[31] != A[31]) : 1'b0;
	end
	
	// Shift Operations

	5'b11_010 : begin // sll
		r_uSHF = w_A << w_B[4:0];
		r_alu_out = r_uSHF[31:0];
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;
	end
	
	5'b11_011 : begin // srl
		r_uSHF = w_A >> w_B[3:0];
		r_alu_out = r_uSHF[31:0];
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;
	end
	
        5'b11_100 : begin // sla
		r_uSHF = w_A << w_B[4:0];
		r_alu_out = r_uSHF[31:0];
		r_alu_cout = 1'b0;
		r_alu_vout = (|w_B[4:0]) ? (w_A[31]? (~r_alu_out[31] || ~(&(w_A >> (32-w_B[4:0])))) : (r_alu_out[31] || (|(w_A >> (32-w_B[4:0])))) ): 1'b0;
	end
	
        5'b11_101 : begin // sra
		r_uSHF = {{32{w_A[31]}},w_A} >> w_B[4:0];
		r_alu_out = r_uSHF[31:0];
		r_alu_cout = 1'b1;
		r_alu_vout = (|w_B[4:0]) ? (|(w_A << (32-w_B[4:0]))): 1'b0;
	end
	
        5'b11_000 : begin // slr
		r_uSHF = (w_A << w_B[4:0]) | (w_A >> (32-w_B[4:0]));
		r_alu_out = r_uSHF[31:0];
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;
	end
	
        5'b11_001 : begin // srr
		r_uSHF = (&w_B[4:0]) ? 32'hFFFF_FFFF : (w_A >> w_B[4:0]) | (w_A << (32-w_B[4:0]));
		r_alu_out = r_uSHF[31:0];
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;
	end
	
        5'b00_010 : begin //unused opcode
		r_alu_out = A | B;
		r_alu_cout = 1'b1;
		r_alu_vout = 1'b1;
	end

	default : begin
		r_alu_out = 32'd0;
		r_alu_cout = 1'b0;
		r_alu_vout = 1'b0;
	end
	
	endcase
end

always @(posedge CLK) begin
	if(RST) begin
		OUT  <= 32'd0;
		COUT <= 1'b0;
		VOUT <= 1'b1;
	end	
	else begin
		OUT  <= r_alu_out[31:0];
		COUT <= r_alu_cout;
		VOUT <= r_alu_vout;
	end
end

endmodule
