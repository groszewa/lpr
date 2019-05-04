`timescale 1 ns / 100 ps



module counter #(
    //Top level block parameters
    parameter WIDTH = 4
) (
	out,
	clk,
    en,
	rst,
    overflow
);

   

//Output ports
output reg [WIDTH-1:0] out;
output reg          overflow;
   

//Input ports
input clk;
input rst;
input en;
   



always @(posedge clk or posedge rst) begin
  if (rst) begin
    out <= 0;
    overflow <= 0;
  end else if (en) begin
    out <= out + 1;
    //overflow <= (out == 2 ** WIDTH -1);  
    overflow <= &out;
     
  end
end
endmodule // counter



////module comparator2 (
////	y,
////	a,
////    b
////);
////
////   output       y;
////   input  [1:0] a,b;
////
////   assign y = (a[1] & ~b[1]) | (a[0] & ~b[1] & ~b[0]) | (a[1] & a[0] & ~b[0]);
////   
////
////endmodule // comparator2


module comp_1b (
	a,
    b,
    equal,
    a_larger
);

   output       equal,a_larger;
   input        a,b;

   assign equal    = (a  & b) | (~a & ~b);
   assign a_larger = (a  & ~b);
   

endmodule // comp_1b


              
module comp_2b (
	a_gt_b,
	a,
    b
);

   output       a_gt_b;
   input  [1:0] a,b;

   wire [1:0]   e,agt;

   comp_1b comp0(.a(a[0]),.b(b[0]),.equal(e[0]),.a_larger(agt[0]));
   comp_1b comp1(.a(a[1]),.b(b[1]),.equal(e[1]),.a_larger(agt[1]));

   assign a_gt_b = agt[1] | (agt[0] & e[1]);
   

endmodule // comp_2b



module comp_4b (
	a_gt_b,
	a,
    b
);

   output       a_gt_b;
   input  [3:0] a,b;

   wire [3:0]   e,agt;

   comp_1b comp0(.a(a[0]),.b(b[0]),.equal(e[0]),.a_larger(agt[0]));
   comp_1b comp1(.a(a[1]),.b(b[1]),.equal(e[1]),.a_larger(agt[1]));
   comp_1b comp2(.a(a[2]),.b(b[2]),.equal(e[2]),.a_larger(agt[2]));
   comp_1b comp3(.a(a[3]),.b(b[3]),.equal(e[3]),.a_larger(agt[3]));

   assign a_gt_b = agt[3] | (agt[2] & e[3]) | (agt[1] & e[3] & e[2]) | (agt[0] & e[3] & e[2] & e[1]);
   

endmodule // comp_4b


module comp_5b (
	a_gt_b,
	a,
    b
);

   output       a_gt_b;
   input  [4:0] a,b;

   wire [4:0]   e,agt;

   comp_1b comp0(.a(a[0]),.b(b[0]),.equal(e[0]),.a_larger(agt[0]));
   comp_1b comp1(.a(a[1]),.b(b[1]),.equal(e[1]),.a_larger(agt[1]));
   comp_1b comp2(.a(a[2]),.b(b[2]),.equal(e[2]),.a_larger(agt[2]));
   comp_1b comp3(.a(a[3]),.b(b[3]),.equal(e[3]),.a_larger(agt[3]));
   comp_1b comp4(.a(a[4]),.b(b[4]),.equal(e[4]),.a_larger(agt[4]));
   

   assign a_gt_b = agt[4] | (agt[3] & e[4]) | (agt[2] & e[4] & e[3]) | (agt[1] & e[4] & e[3] & e[2]) | (agt[0] & e[4] & e[3] & e[2] & e[1]);
   

endmodule // comp_5b




module comp_8b (
	a_gt_b,
	a,
    b
);

   output       a_gt_b;
   input  [7:0] a,b;

   wire [7:0]   e,agt;

   wire         e76,e75,e74,e73,e72,e71;
   

   comp_1b comp0(.a(a[0]),.b(b[0]),.equal(e[0]),.a_larger(agt[0]));
   comp_1b comp1(.a(a[1]),.b(b[1]),.equal(e[1]),.a_larger(agt[1]));
   comp_1b comp2(.a(a[2]),.b(b[2]),.equal(e[2]),.a_larger(agt[2]));
   comp_1b comp3(.a(a[3]),.b(b[3]),.equal(e[3]),.a_larger(agt[3]));
   comp_1b comp4(.a(a[4]),.b(b[4]),.equal(e[4]),.a_larger(agt[4]));
   comp_1b comp5(.a(a[5]),.b(b[5]),.equal(e[5]),.a_larger(agt[5]));
   comp_1b comp6(.a(a[6]),.b(b[6]),.equal(e[6]),.a_larger(agt[6]));
   comp_1b comp7(.a(a[7]),.b(b[7]),.equal(e[7]),.a_larger(agt[7]));

   assign e76 = e[7] & e[6];
   assign e75 = e76  & e[5];
   assign e74 = e75  & e[4];
   assign e73 = e74  & e[3];
   assign e72 = e73  & e[2];
   assign e71 = e72  & e[1];
   
   assign a_gt_b = agt[7] | (agt[6] & e[7]) | (agt[5] & e76) | (agt[4] & e75) | (agt[3] & e74) | (agt[2] & e73) | (agt[1] & e72) | (agt[0] & e71);
   

endmodule // comp_10b

module comp_10b (
	a_gt_b,
	a,
    b
);

   output       a_gt_b;
   input  [9:0] a,b;

   wire [9:0]   e,agt;

   wire         e98,e97,e96,e95,e94,e93,e92,e91;
   

   comp_1b comp0(.a(a[0]),.b(b[0]),.equal(e[0]),.a_larger(agt[0]));
   comp_1b comp1(.a(a[1]),.b(b[1]),.equal(e[1]),.a_larger(agt[1]));
   comp_1b comp2(.a(a[2]),.b(b[2]),.equal(e[2]),.a_larger(agt[2]));
   comp_1b comp3(.a(a[3]),.b(b[3]),.equal(e[3]),.a_larger(agt[3]));
   comp_1b comp4(.a(a[4]),.b(b[4]),.equal(e[4]),.a_larger(agt[4]));
   comp_1b comp5(.a(a[5]),.b(b[5]),.equal(e[5]),.a_larger(agt[5]));
   comp_1b comp6(.a(a[6]),.b(b[6]),.equal(e[6]),.a_larger(agt[6]));
   comp_1b comp7(.a(a[7]),.b(b[7]),.equal(e[7]),.a_larger(agt[7]));

   assign e98 = e[9] & e[8];
   assign e97 = e98  & e[7];
   assign e96 = e97  & e[6];
   assign e95 = e96  & e[5];
   assign e94 = e95  & e[4];
   assign e93 = e94  & e[3];
   assign e92 = e93  & e[2];
   assign e91 = e92  & e[1];
   
   assign a_gt_b = agt[9] | (agt[8] & e[9]) | (agt[7] & e98) | (agt[6] & e97) | (agt[5] & e96) | (agt[4] & e95) | (agt[3] & e94) | (agt[2] & e93) | (agt[1] & e92) | (agt[0] & e91);
   

endmodule // comp_10b





module prg_4b (
	clk,
    rst,
    en,
    bin_in,
    sn_out,
    ctr_overflow  
);

   input       clk,rst,en;
   input [3:0] bin_in;
   output      sn_out,ctr_overflow;

   wire [3:0]  ctr4_out;
   
   

counter #(
   .WIDTH (4)
) ctr4 (
  .clk(clk),
  .rst(rst),
  .en(en),
  .out(ctr4_out),
  .overflow(ctr_overflow)
);


comp_4b     comp4 (.a(bin_in), .b(ctr4_out), .a_gt_b(sn_out));

endmodule // prg_4b


module prg_5b (
	clk,
    rst,
    en,
    bin_in,
    sn_out,
    ctr_overflow  
);

   input       clk,rst,en;
   input [4:0] bin_in;
   output      sn_out,ctr_overflow;

   wire [4:0]  ctr4_out;
   
   

counter #(
   .WIDTH (5)
) ctr4 (
  .clk(clk),
  .rst(rst),
  .en(en),
  .out(ctr4_out),
  .overflow(ctr_overflow)
);


comp_5b     comp4 (.a(bin_in), .b(ctr4_out), .a_gt_b(sn_out));

endmodule // prg_5b




module det_stoch_mul (
	a,
    b,
    y
);

   input a,b;
   output y;

   assign y = a & b;

endmodule // det_stoch_mul



module shift_reg_32b (
    clk,
	scan_in,
    wrap_mode,
    en,
    rst,
    shiftreg_out
);

   input         scan_in,wrap_mode,rst,en,clk;
   output  [31:0] shiftreg_out;
   

   reg [31:0]    shiftreg;

   wire          si_int;
   

   always @(posedge clk or posedge rst) begin
     if (rst) begin
       shiftreg <= 0;
     end else if (en) begin
       shiftreg <= {shiftreg[30:0],si_int};
     end
   end
   

   assign si_int = ((~wrap_mode) & (scan_in)) | ((wrap_mode) & (shiftreg[31]));
   assign shiftreg_out = shiftreg;
   

endmodule // shift_reg_32b







module shift_reg_16b_half (
    clk,
	scan_in,
    wrap_mode,
    en,
    rst,
    shiftreg_out
);

   input         scan_in,wrap_mode,rst,en,clk;
   output  [7:0] shiftreg_out;
   

   reg [15:0]    shiftreg;

   wire          si_int;
   

   always @(posedge clk or posedge rst) begin
     if (rst) begin
       shiftreg <= 0;
     end else if (en) begin
       shiftreg <= {shiftreg[14:0],si_int};
     end
   end
   

   assign si_int = ((~wrap_mode) & (scan_in)) | ((wrap_mode) & (shiftreg[15]));
   assign shiftreg_out = shiftreg[15:8];
   

endmodule // shift_reg_16b_half



module shift_reg_16b_quarter (
    clk,
	scan_in,
    wrap_mode,
    en,
    rst,
    shiftreg_out
);

   input         scan_in,wrap_mode,rst,en,clk;
   output  [3:0] shiftreg_out;
   

   reg [15:0]    shiftreg;

   wire          si_int;
   

   always @(posedge clk or posedge rst) begin
     if (rst) begin
       shiftreg <= 0;
     end else if (en) begin
       shiftreg <= {shiftreg[14:0],si_int};
     end
   end
   

   assign si_int = ((~wrap_mode) & (scan_in)) | ((wrap_mode) & (shiftreg[15]));
   assign shiftreg_out = shiftreg[15:12];
   

endmodule // shift_reg_16b_half


module shift_reg_16b_eighth (
    clk,
	scan_in,
    wrap_mode,
    en,
    rst,
    shiftreg_out
);

   input         scan_in,wrap_mode,rst,en,clk;
   output  [1:0] shiftreg_out;
   

   reg [15:0]    shiftreg;

   wire          si_int;
   

   always @(posedge clk or posedge rst) begin
     if (rst) begin
       shiftreg <= 0;
     end else if (en) begin
       shiftreg <= {shiftreg[14:0],si_int};
     end
   end
   

   assign si_int = ((~wrap_mode) & (scan_in)) | ((wrap_mode) & (shiftreg[15]));
   assign shiftreg_out = shiftreg[15:14];
   

endmodule // shift_reg_16b_half





module shift_reg_16b_noshift (
    clk,
	scan_in,
    en,
    rst,
    shiftreg_out
);

   input         scan_in,rst,en,clk;
   output  [15:0] shiftreg_out;
   

   reg [15:0]    shiftreg;

   

   always @(posedge clk or posedge rst) begin
     if (rst) begin
       shiftreg <= 0;
     end else if (en) begin
       shiftreg <= {shiftreg[14:0],scan_in};
     end
   end
   

   assign shiftreg_out = shiftreg;
   

endmodule // shift_reg_16b_noshift






module pipe_mul_32b (
	a,
    b,
    y
);

   input  [31:0] a,b;
   output [31:0] y;

   assign y[0]  = a[0]  & b[0];
   assign y[1]  = a[1]  & b[1];
   assign y[2]  = a[2]  & b[2];
   assign y[3]  = a[3]  & b[3];
   assign y[4]  = a[4]  & b[4];
   assign y[5]  = a[5]  & b[5];
   assign y[6]  = a[6]  & b[6];
   assign y[7]  = a[7]  & b[7];
   assign y[8]  = a[8]  & b[8];
   assign y[9]  = a[9]  & b[9];
   assign y[10] = a[10] & b[10];
   assign y[11] = a[11] & b[11];
   assign y[12] = a[12] & b[12];
   assign y[13] = a[13] & b[13];
   assign y[14] = a[14] & b[14];
   assign y[15] = a[15] & b[15];
   assign y[16] = a[16] & b[16];
   assign y[17] = a[17] & b[17];
   assign y[18] = a[18] & b[18];
   assign y[19] = a[19] & b[19];
   assign y[20] = a[20] & b[20];
   assign y[21] = a[21] & b[21];
   assign y[22] = a[22] & b[22];
   assign y[23] = a[23] & b[23];
   assign y[24] = a[24] & b[24];
   assign y[25] = a[25] & b[25];
   assign y[26] = a[26] & b[26];
   assign y[27] = a[27] & b[27];
   assign y[28] = a[28] & b[28];
   assign y[29] = a[29] & b[29];
   assign y[30] = a[30] & b[30];
   assign y[31] = a[31] & b[31];
   

endmodule // pipe_mul_32b




module pipe_mul_16b_half (
	a,
    b,
    y
);

   input  [7:0] a,b;
   output [7:0] y;

   assign y[0]  = a[0]  & b[0];
   assign y[1]  = a[1]  & b[1];
   assign y[2]  = a[2]  & b[2];
   assign y[3]  = a[3]  & b[3];
   assign y[4]  = a[4]  & b[4];
   assign y[5]  = a[5]  & b[5];
   assign y[6]  = a[6]  & b[6];
   assign y[7]  = a[7]  & b[7];
   

endmodule // pipe_mul_16b_half

module pipe_mul_16b_quarter (
	a,
    b,
    y
);

   input  [3:0] a,b;
   output [3:0] y;

   assign y[0]  = a[0]  & b[0];
   assign y[1]  = a[1]  & b[1];
   assign y[2]  = a[2]  & b[2];
   assign y[3]  = a[3]  & b[3];
   

endmodule // pipe_mul_16b_quarter

module pipe_mul_16b_eighth (
	a,
    b,
    y
);

   input  [1:0] a,b;
   output [1:0] y;

   assign y[0]  = a[0]  & b[0];
   assign y[1]  = a[1]  & b[1];
   

endmodule // pipe_mul_16b_eighth






module ctr_out_bank_32 (
	clk,
    rst,
    en,                    
    mul_in,
    bin_out
);

   input clk,rst;
   input [31:0] mul_in;
   output [31:0] bin_out;
   input        en;
   
   
   wire  [4:0] ctr0,ctr1,ctr2,ctr3,ctr4,ctr5,ctr6,ctr7,ctr8,ctr9,ctr10,ctr11,ctr12,ctr13,ctr14,ctr15,ctr16,ctr17,ctr18,ctr19,ctr20,ctr21,ctr22,ctr23,ctr24,ctr25,ctr26,ctr27,ctr28,ctr29,ctr30,ctr31;

   wire [31:0]  unused;
   
   
   counter #( .WIDTH (5) )
   stoch2bin_0 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[0] & en),
   .out(ctr0),
   .overflow(unused[0])
   );

   counter #( .WIDTH (5) )
   stoch2bin_1 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[1] & en),
   .out(ctr1),
   .overflow(unused[1])
   );


   counter #( .WIDTH (5) )
   stoch2bin_2 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[2] & en),
   .out(ctr2),
   .overflow(unused[2])
   );

   counter #( .WIDTH (5) )
   stoch2bin_3 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[3] & en),
   .out(ctr3),
   .overflow(unused[3])
   );

   counter #( .WIDTH (5) )
   stoch2bin_4 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[4] & en),
   .out(ctr4),
   .overflow(unused[4])
   );

   counter #( .WIDTH (5) )
   stoch2bin_5 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[5] & en),
   .out(ctr5),
   .overflow(unused[5])
   );

   counter #( .WIDTH (5) )
   stoch2bin_6 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[6] & en),
   .out(ctr6),
   .overflow(unused[6])
   );

   counter #( .WIDTH (5) )
   stoch2bin_7 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[7] & en),
   .out(ctr7),
   .overflow(unused[7])
   );
 
   counter #( .WIDTH (5) )
   stoch2bin_8 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[8] & en),
   .out(ctr8),
   .overflow(unused[8])
   );

   counter #( .WIDTH (5) )
   stoch2bin_9 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[9]),
   .out(ctr9),
   .overflow(unused[9])
   );

   counter #( .WIDTH (5) )
   stoch2bin_10 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[10] & en),
   .out(ctr10),
   .overflow(unused[10])
   );

   counter #( .WIDTH (5) )
   stoch2bin_11 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[11] & en),
   .out(ctr11),
   .overflow(unused[11])
   );

   counter #( .WIDTH (5) )
   stoch2bin_12 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[12] & en),
   .out(ctr12),
   .overflow(unused[12])
   );

   counter #( .WIDTH (5) )
   stoch2bin_13 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[13] & en),
   .out(ctr13),
   .overflow(unused[13])
   );

   counter #( .WIDTH (5) )
   stoch2bin_14 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[14] & en),
   .out(ctr14),
   .overflow(unused[14])
   );

   counter #( .WIDTH (5) )
   stoch2bin_15 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[15] & en),
   .out(ctr15),
   .overflow(unused[15])
   );

   counter #( .WIDTH (5) )
   stoch2bin_16 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[16] & en),
   .out(ctr16),
   .overflow(unused[16])
   );


   counter #( .WIDTH (5) )
   stoch2bin_17 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[17] & en),
   .out(ctr17),
   .overflow(unused[17])
   );

   counter #( .WIDTH (5) )
   stoch2bin_18 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[18] & en),
   .out(ctr18),
   .overflow(unused[18])
   );


   counter #( .WIDTH (5) )
   stoch2bin_19 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[19] & en),
   .out(ctr19),
   .overflow(unused[19])
   );

   counter #( .WIDTH (5) )
   stoch2bin_20 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[20] & en),
   .out(ctr20),
   .overflow(unused[20])
   );

   counter #( .WIDTH (5) )
   stoch2bin_21 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[21] & en),
   .out(ctr21),
   .overflow(unused[21])
   );


   counter #( .WIDTH (5) )
   stoch2bin_22 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[22] & en),
   .out(ctr22),
   .overflow(unused[22])
   );

   counter #( .WIDTH (5) )
   stoch2bin_23 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[23] & en),
   .out(ctr23),
   .overflow(unused[23])
   );
 
   counter #( .WIDTH (5) )
   stoch2bin_24 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[24] & en),
   .out(ctr24),
   .overflow(unused[24])
   );

   counter #( .WIDTH (5) )
   stoch2bin_25 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[25] & en),
   .out(ctr25),
   .overflow(unused[25])
   );

   counter #( .WIDTH (5) )
   stoch2bin_26 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[26] & en),
   .out(ctr26),
   .overflow(unused[26])
   );

   counter #( .WIDTH (5) )
   stoch2bin_27 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[27] & en),
   .out(ctr27),
   .overflow(unused[27])
   );

   counter #( .WIDTH (5) )
   stoch2bin_28 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[28] & en),
   .out(ctr28),
   .overflow(unused[28])
   );

   counter #( .WIDTH (5) )
   stoch2bin_29 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[29] & en),
   .out(ctr29),
   .overflow(unused[29])
   );

   counter #( .WIDTH (5) )
   stoch2bin_30 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[30] & en),
   .out(ctr30),
   .overflow(unused[30])
   );

   counter #( .WIDTH (5) )
   stoch2bin_31 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[31] & en),
   .out(ctr31),
   .overflow(unused[31])
   );


   assign bin_out = ctr0 + ctr1 + ctr2 + ctr3 + ctr4 + ctr5 + ctr6 + ctr7 + ctr8 + ctr9 + ctr10 + ctr11 + ctr12 + ctr13 + ctr14 + ctr15 + ctr16 + ctr17 + ctr18 + ctr19 + ctr20 + ctr21 + ctr22 + ctr23 + ctr24 + ctr25 + ctr26 + ctr27 + ctr28 + ctr29 + ctr30 + ctr31;
   

       

endmodule // ctr_out_bank


module ctr_out_bank_half (
	clk,
    rst,
    en,                      
    mul_in,
    bin_out
);

   input clk,rst,en; // add input enable to gate during shift cycles
   input [7:0] mul_in;
   output [31:0] bin_out;
   
   wire  [4:0] ctr0,ctr1,ctr2,ctr3,ctr4,ctr5,ctr6,ctr7;

   wire [7:0]  unused;
   
   
   counter #( .WIDTH (5) )
   stoch2bin_0 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[0] & en),
   .out(ctr0),
   .overflow(unused[0])
   );

   counter #( .WIDTH (5) )
   stoch2bin_1 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[1] & en),
   .out(ctr1),
   .overflow(unused[1])
   );


   counter #( .WIDTH (5) )
   stoch2bin_2 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[2] & en),
   .out(ctr2),
   .overflow(unused[2])
   );

   counter #( .WIDTH (5) )
   stoch2bin_3 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[3] & en),
   .out(ctr3),
   .overflow(unused[3])
   );

   counter #( .WIDTH (5) )
   stoch2bin_4 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[4] & en),
   .out(ctr4),
   .overflow(unused[4])
   );

   counter #( .WIDTH (5) )
   stoch2bin_5 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[5] & en),
   .out(ctr5),
   .overflow(unused[5])
   );

   counter #( .WIDTH (5) )
   stoch2bin_6 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[6] & en),
   .out(ctr6),
   .overflow(unused[6])
   );

   counter #( .WIDTH (5) )
   stoch2bin_7 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[7] & en),
   .out(ctr7),
   .overflow(unused[7])
   );
 

   assign bin_out = ctr0 + ctr1 + ctr2 + ctr3 + ctr4 + ctr5 + ctr6 + ctr7;
   

       

endmodule // ctr_out_bank_half



module ctr_out_bank_quarter (
	clk,
    rst,
    en,                      
    mul_in,
    bin_out
);

   input clk,rst,en; // add input enable to gate during shift cycles
   input [3:0] mul_in;
   output [31:0] bin_out;
   
   wire  [5:0] ctr0,ctr1,ctr2,ctr3;

   wire [3:0]  unused;
   
   
   counter #( .WIDTH (6) )
   stoch2bin_0 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[0] & en),
   .out(ctr0),
   .overflow(unused[0])
   );

   counter #( .WIDTH (6) )
   stoch2bin_1 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[1] & en),
   .out(ctr1),
   .overflow(unused[1])
   );


   counter #( .WIDTH (6) )
   stoch2bin_2 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[2] & en),
   .out(ctr2),
   .overflow(unused[2])
   );

   counter #( .WIDTH (6) )
   stoch2bin_3 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[3] & en),
   .out(ctr3),
   .overflow(unused[3])
   );

 

   assign bin_out = ctr0 + ctr1 + ctr2 + ctr3;
   

       

endmodule // ctr_out_bank_quarter


module ctr_out_bank_eighth (
	clk,
    rst,
    en,                      
    mul_in,
    bin_out
);

   input clk,rst,en; // add input enable to gate during shift cycles
   input [1:0] mul_in;
   output [31:0] bin_out;
   
   wire  [6:0] ctr0,ctr1;

   wire [1:0]  unused;
   
   
   counter #( .WIDTH (7) )
   stoch2bin_0 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[0] & en),
   .out(ctr0),
   .overflow(unused[0])
   );

   counter #( .WIDTH (7) )
   stoch2bin_1 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[1] & en),
   .out(ctr1),
   .overflow(unused[1])
   );


 

   assign bin_out = ctr0 + ctr1;
   

       

endmodule // ctr_out_bank_eighth





module pipe_mul_5b_full_top (
clk,
rst,
en,
output_gate,                          
input_bin_a,
input_bin_b,
input_bin_c,                          
wrap_mode_a,
wrap_mode_b,
en_sr_a,
en_sr_b,
rst_out,
bin_out                  
);

   input clk,rst,en,wrap_mode_a,wrap_mode_b,en_sr_a,en_sr_b,rst_out,output_gate;
   input [4:0] input_bin_a,input_bin_b;
   input [4:0] input_bin_c;
   
   output [9:0] bin_out;
   
   wire [9:0]   bin_out_int;
   wire         sn_out_a,sn_out_b;
   wire         ctr4_overflow_a,ctr4_overflow_b;
   wire [31:0]  sr_out_a,sr_out_b,sr_mul_out;
   
   

//bin2stoch a   
prg_5b dut_prg5b_a (
  .clk(clk),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_a),
  .sn_out(sn_out_a),
  .ctr_overflow(ctr4_overflow_a)         
);

//shiftreg_a  
shift_reg_32b dut_sr_a (
  .clk(clk),
  .scan_in(sn_out_a),
  .wrap_mode(wrap_mode_a),
  .en(en_sr_a),
  .rst(rst),
  .shiftreg_out(sr_out_a)
);

   

//bin2stoch b
prg_5b dut_prg5b_b (
  .clk(clk),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_b),
  .sn_out(sn_out_b),
  .ctr_overflow(ctr4_overflow_b)         
);

//shiftreg_b 
shift_reg_32b dut_sr_b (
  .clk(clk),
  .scan_in(sn_out_b),
  .wrap_mode(wrap_mode_b),
  .en(en_sr_b),
  .rst(rst),
  .shiftreg_out(sr_out_b)
);


   

//pipelined multiplier circuit
pipe_mul_32b dut_pipe_mul (
  .a(sr_out_a),
  .b(sr_out_b),
  .y(sr_mul_out)
);
                       

ctr_out_bank_32 dut_ctr_out (
  .clk(clk),
  .rst(rst_out),
  .en(output_gate),                             
  .mul_in(sr_mul_out),
  .bin_out(bin_out_int)                      
);

   assign bin_out = bin_out_int + input_bin_c;
   
                     

endmodule // pipe_mul_5b_full_top






               







   