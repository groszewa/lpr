/****************************************/
/*					*/
/*	Filename: bm_4-bit.v		*/
/*	Function: multiplies 2 4-bit	*/
/*		  numbers using booth	*/
/*		  multiplication	*/
/*	Last Edit: 3/18/2018		*/
/*	Owner: Travis Lenz		*/
/*					*/
/****************************************/

`timescale 1 ns / 100 ps

module bm_4b(a, b, c, rst, clk);	

// Constants
parameter WIDTH = 4;

// Port Declarations
input [WIDTH-1:0] a, b;//a will be multiplier, b multiplicand
input clk, rst;	//clock and reset
output [(WIDTH*2)-1:0] c;  //c will be product of a and b

// Registers
reg [(WIDTH*2)-1:0] accumulator; //accumulates sum during booth execution
reg [WIDTH-1:0] ctr; //track which multiplicand bits have been used
reg [WIDTH:0] a_val; //will have dynamic value of a, to be shifted during execution
//reg [WIDTH-1:0] neg_b; //will contain negative b 

// Wires
wire [(2*WIDTH)-1:0] b_wire; //will allow us to operate on b input
wire [(2*WIDTH)-1:0] b_neg_wire; //will allow us to add negative b
//wire a_wire; //will allow us to load a

// Variable Assignments
assign b_wire = {4'h0,b};
assign b_neg_wire = {4'hF,~b} + 1;
assign c = accumulator;
//assign a_wire = a;

// Always Statements
always @ (posedge clk) begin: BOOTH_MULT
	if (rst) begin
		accumulator <= 8'b0;
		ctr <= 0;
		a_val <= (a<<1);
	end else if (ctr < 4) begin
		if ((a_val[1] == 1)&&(a_val[0] == 0)) begin: BOOTH_10
			accumulator <= accumulator + (b_neg_wire<<ctr);
		end else if ((a_val[1] == 0)&&(a_val[0]==1)) begin: BOOTH_01
			accumulator <= accumulator + (b_wire<<ctr);
		end else if (a_val[1] == a_val[0]) begin
			accumulator <= accumulator;
		end
		ctr <= ctr+1;
		a_val <= (a_val >> 1);
	end
end

endmodule 