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

module comp_3b (
	a_gt_b,
	a,
    b
);

   output       a_gt_b;
   input  [2:0] a,b;

   wire [2:0]   e,agt;

   comp_1b comp0(.a(a[0]),.b(b[0]),.equal(e[0]),.a_larger(agt[0]));
   comp_1b comp1(.a(a[1]),.b(b[1]),.equal(e[1]),.a_larger(agt[1]));
   comp_1b comp2(.a(a[2]),.b(b[2]),.equal(e[2]),.a_larger(agt[2]));
   

   assign a_gt_b = agt[2] | (agt[1] & e[2]) | (agt[0] & e[2] & e[1]);
   

endmodule // comp_3b



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
   

endmodule // comp_8b


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


module det_stoch_mul (
	a,
    b,
    y
);

   input a,b;
   output y;

   assign y = a & b;

endmodule // det_stoch_mul



module shift_reg_16b (
    clk,
	scan_in,
    wrap_mode,
    en,
    rst,
    shiftreg_out
);

   input         scan_in,wrap_mode,rst,en,clk;
   output  [15:0] shiftreg_out;
   

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
   assign shiftreg_out = shiftreg;
   

endmodule // shift_reg_16b


module pipe_mul_16b (
	a,
    b,
    y
);

   input  [15:0] a,b;
   output [15:0] y;

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
   

endmodule // pipe_mul_16b


module pipe_scale_add_16b (
	a,
    b0,
    b1,
    b2,
    b3,
    b4,
    b5,
    b6,
    b7,
    b8,
    b9,
    b10,
    b11,
    b12,
    b13,
    b14,
    b15,                      
    s,
    y
);

   input  [15:0] a;
   input         b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15;
   input         s;
   output [15:0] y;

   assign y[0]  = (a[0]  & ~s) | (b0  & s);
   assign y[1]  = (a[1]  & ~s) | (b1  & s);
   assign y[2]  = (a[2]  & ~s) | (b2  & s);
   assign y[3]  = (a[3]  & ~s) | (b3  & s);
   assign y[4]  = (a[4]  & ~s) | (b4  & s);
   assign y[5]  = (a[5]  & ~s) | (b5  & s);
   assign y[6]  = (a[6]  & ~s) | (b6  & s);
   assign y[7]  = (a[7]  & ~s) | (b7  & s);
   assign y[8]  = (a[8]  & ~s) | (b8  & s);
   assign y[9]  = (a[9]  & ~s) | (b9  & s);
   assign y[10] = (a[10] & ~s) | (b10 & s);
   assign y[11] = (a[11] & ~s) | (b11 & s);
   assign y[12] = (a[12] & ~s) | (b12 & s);
   assign y[13] = (a[13] & ~s) | (b13 & s);
   assign y[14] = (a[14] & ~s) | (b14 & s);
   assign y[15] = (a[15] & ~s) | (b15 & s);
   

endmodule // pipe_scale_add_16b






module ctr_out_bank (
	clk,
    rst,
    mul_in,
    bin_out
);

   input clk,rst;
   input [15:0] mul_in;
   output [31:0] bin_out;
   
   wire  [3:0] ctr0,ctr1,ctr2,ctr3,ctr4,ctr5,ctr6,ctr7,ctr8,ctr9,ctr10,ctr11,ctr12,ctr13,ctr14,ctr15;

   wire [15:0]  unused;
   
   
   counter #( .WIDTH (4) )
   stoch2bin_0 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[0]),
   .out(ctr0),
   .overflow(unused[0])
   );

   counter #( .WIDTH (4) )
   stoch2bin_1 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[1]),
   .out(ctr1),
   .overflow(unused[1])
   );


   counter #( .WIDTH (4) )
   stoch2bin_2 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[2]),
   .out(ctr2),
   .overflow(unused[2])
   );

   counter #( .WIDTH (4) )
   stoch2bin_3 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[3]),
   .out(ctr3),
   .overflow(unused[3])
   );

   counter #( .WIDTH (4) )
   stoch2bin_4 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[4]),
   .out(ctr4),
   .overflow(unused[4])
   );

   counter #( .WIDTH (4) )
   stoch2bin_5 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[5]),
   .out(ctr5),
   .overflow(unused[5])
   );

   counter #( .WIDTH (4) )
   stoch2bin_6 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[6]),
   .out(ctr6),
   .overflow(unused[6])
   );

   counter #( .WIDTH (4) )
   stoch2bin_7 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[7]),
   .out(ctr7),
   .overflow(unused[7])
   );
 
   counter #( .WIDTH (4) )
   stoch2bin_8 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[8]),
   .out(ctr8),
   .overflow(unused[8])
   );

   counter #( .WIDTH (4) )
   stoch2bin_9 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[9]),
   .out(ctr9),
   .overflow(unused[9])
   );

   counter #( .WIDTH (4) )
   stoch2bin_10 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[10]),
   .out(ctr10),
   .overflow(unused[10])
   );

   counter #( .WIDTH (4) )
   stoch2bin_11 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[11]),
   .out(ctr11),
   .overflow(unused[11])
   );

   counter #( .WIDTH (4) )
   stoch2bin_12 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[12]),
   .out(ctr12),
   .overflow(unused[12])
   );

   counter #( .WIDTH (4) )
   stoch2bin_13 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[13]),
   .out(ctr13),
   .overflow(unused[13])
   );

   counter #( .WIDTH (4) )
   stoch2bin_14 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[14]),
   .out(ctr14),
   .overflow(unused[14])
   );

   counter #( .WIDTH (4) )
   stoch2bin_15 (
   .clk(clk),
   .rst(rst),
   .en(mul_in[15]),
   .out(ctr15),
   .overflow(unused[15])
   );

   assign bin_out = ctr0 + ctr1 + ctr2 + ctr3 + ctr4 + ctr5 + ctr6 + ctr7 + ctr8 + ctr9 + ctr10 + ctr11 + ctr12 + ctr13 + ctr14 + ctr15;
   

       

endmodule // ctr_out_bank



module prg4b_bank (
	clk,
    rst,
    en,
    bin_in0,
    bin_in1,
    bin_in2,
    bin_in3,
    bin_in4,
    bin_in5,
    bin_in6,
    bin_in7,
    bin_in8,
    bin_in9,
    bin_in10,
    bin_in11,
    bin_in12,
    bin_in13,
    bin_in14,
    bin_in15,
    sn_out0,
    sn_out1,
    sn_out2,
    sn_out3,
    sn_out4,
    sn_out5,
    sn_out6,
    sn_out7,
    sn_out8,
    sn_out9,
    sn_out10,
    sn_out11,
    sn_out12,
    sn_out13,
    sn_out14,
    sn_out15,
);

   input clk,rst,en;
   input [3:0] bin_in0,bin_in1,bin_in2,bin_in3,bin_in4,bin_in5,bin_in6,bin_in7,bin_in8,bin_in9,bin_in10,bin_in11,bin_in12,bin_in13,bin_in14,bin_in15;
   
   output sn_out0,sn_out1,sn_out2,sn_out3,sn_out4,sn_out5,sn_out6,sn_out7,sn_out8,sn_out9,sn_out10,sn_out11,sn_out12,sn_out13,sn_out14,sn_out15;

   wire [15:0] unused;
   
   
   prg_4b prg_bank0 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in0),                 
   .sn_out(sn_out0),
   .ctr_overflow(unused[0])
   );

   prg_4b prg_bank1 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in1),                 
   .sn_out(sn_out1),
   .ctr_overflow(unused[1])
   );
   
   prg_4b prg_bank2 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in2),                 
   .sn_out(sn_out2),
   .ctr_overflow(unused[2])
   );

   prg_4b prg_bank3 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in3),                 
   .sn_out(sn_out3),
   .ctr_overflow(unused[3])
   );
   
   prg_4b prg_bank4 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in4),                 
   .sn_out(sn_out4),
   .ctr_overflow(unused[4])
   );

   prg_4b prg_bank5 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in5),                 
   .sn_out(sn_out5),
   .ctr_overflow(unused[5])
   );

   prg_4b prg_bank6 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in6),                 
   .sn_out(sn_out6),
   .ctr_overflow(unused[6])
   );
   
   prg_4b prg_bank7 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in7),                 
   .sn_out(sn_out7),
   .ctr_overflow(unused[7])
   );

   prg_4b prg_bank8 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in8),                 
   .sn_out(sn_out8),
   .ctr_overflow(unused[8])
   );
   
   prg_4b prg_bank9 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in9),                 
   .sn_out(sn_out9),
   .ctr_overflow(unused[9])
   );

   prg_4b prg_bank10 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in10),                 
   .sn_out(sn_out10),
   .ctr_overflow(unused[10])
   );
   
   prg_4b prg_bank11 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in11),                 
   .sn_out(sn_out11),
   .ctr_overflow(unused[11])
   );

   prg_4b prg_bank12 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in12),                 
   .sn_out(sn_out12),
   .ctr_overflow(unused[12])
   );
   

   prg_4b prg_bank13 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in13),                 
   .sn_out(sn_out13),
   .ctr_overflow(unused[13])
   );
   
   prg_4b prg_bank14 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in14),                 
   .sn_out(sn_out14),
   .ctr_overflow(unused[14])
   );

   prg_4b prg_bank15 (
   .clk(clk),
   .rst(rst),
   .en(en),
   .bin_in(bin_in15),                 
   .sn_out(sn_out15),
   .ctr_overflow(unused[15])
   );
   
       

endmodule // prg4b_bank


module add8_3b (
x1,
x2,
x3,
x4,
x5,
x6,
x7,
x8,
y
);
   input [2:0] x1,x2,x3,x4,x5,x6,x7,x8;
   output [5:0] y;

   assign y = x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8;
   

endmodule // add8_3b

module add8_5b (
x1,
x2,
x3,
x4,
x5,
x6,
x7,
x8,
y
);
   input [4:0] x1,x2,x3,x4,x5,x6,x7,x8;
   output [7:0] y;

   assign y = x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8;
   

endmodule // add8_5b

module add4_6b (
x1,
x2,
x3,
x4,
y
);
   input [5:0] x1,x2,x3,x4;
   output [7:0] y;

   assign y = x1 + x2 + x3 + x4;
   

endmodule // add4_6b


             

module top (
a,
x1, 
xx1,xx2,xx3,xx4,xx5,xx6,xx7,xx8,xx9,
zz1,zz2,zz3,zz4,zz5,zz6,zz7,zz8,zz9,
ww1,ww2,ww3,ww4,
ww,            
zz,                    
y,
y1,           
);

   input a;
   input [2:0] x1;
   input [2:0] xx1;
   
   
   
   output y;
   output [5:0] y1;
   

   wire   clk,rst;
   wire [15:0] ctr_out;
   wire        unused;
   input [2:0]  xx2,xx3,xx4,xx5,xx6,xx7,xx8,xx9;
   input [4:0]  zz1,zz2,zz3,zz4,zz5,zz6,zz7,zz8,zz9;
   output [7:0] zz;

   input [5:0]  ww1,ww2,ww3,ww4;
   output [7:0] ww;
   
   
   
   

   
   comp_3b comp_3b (
.a_gt_b(y),
.a(x1),
.b(xx1)           
);
   
   

   counter #( .WIDTH (3) )
   counter_3b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[2:0]),
   .overflow(y)
   );

   counter #( .WIDTH (4) )
   counter_4b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[3:0]),
   .overflow(y)
   );

   counter #( .WIDTH (5) )
   counter_5b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[4:0]),
   .overflow(y)
   );

   counter #( .WIDTH (6) )
   counter_6b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[5:0]),
   .overflow(y)
   );
   
   counter #( .WIDTH (7) )
   counter_7b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[6:0]),
   .overflow(y)
   );

   counter #( .WIDTH (8) )
   counter_8b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[7:0]),
   .overflow(y)
   );
   
   counter #( .WIDTH (9) )
   counter_9b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[8:0]),
   .overflow(y)
   );

   counter #( .WIDTH (10) )
   counter_10b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[9:0]),
   .overflow(y)
   );

   counter #( .WIDTH (11) )
   counter_11b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[10:0]),
   .overflow(y)
   );

   counter #( .WIDTH (12) )
   counter_12b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[1:0]),
   .overflow(y)
   );

   counter #( .WIDTH (13) )
   counter_13b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[12:0]),
   .overflow(y)
   );
   
   counter #( .WIDTH (14) )
   counter_14b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[13:0]),
   .overflow(y)
   );

   counter #( .WIDTH (15) )
   counter_15b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[14:0]),
   .overflow(y)
   );
   
   counter #( .WIDTH (16) )
   counter_16b (
   .clk(a),
   .rst(rst),
   .en(a),
   .out(ctr_out[15:0]),
   .overflow(y)
   );

   add8_3b add8_3b (
.x1(x1),
.x2(xx3),
.x3(xx4),
.x4(xx5),
.x5(xx6),
.x6(xx7),
.x7(xx8),
.x8(xx9),
.y(y1)            
   );

   add8_5b add8_5b (
.x1(zz1),
.x2(zz2),
.x3(zz3),
.x4(zz4),
.x5(zz5),
.x6(zz6),
.x7(zz7),
.x8(zz8),
.y(zz)            
   );

   add4_6b add4_6b (
.x1(ww1),
.x2(ww2),
.x3(ww3),
.x4(ww4),
.y(ww)            
   );

   
   

          
   assign y = a;

endmodule // top



               







   