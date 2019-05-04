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


module pipe_mac_top (
clk,
rst,
en,
input_bin_a,
input_bin_b,
en_sr_a,
en_sr_b,
wrap_mode_a,
wrap_mode_b,
input_bin_c0,
input_bin_c1,
input_bin_c2,
input_bin_c3,
input_bin_c4,
input_bin_c5,
input_bin_c6,
input_bin_c7,
input_bin_c8,
input_bin_c9,
input_bin_c10,  
input_bin_c11,
input_bin_c12,
input_bin_c13,
input_bin_c14,
input_bin_c15,
en_c_bank,  
start_add,
rst_out,
bin_out             
);

   input clk,rst,en;

   input [3:0] input_bin_a, input_bin_b;
   
   input       wrap_mode_a,wrap_mode_b;
   input       en_sr_a,en_sr_b;

   input       rst_out;

   input [3:0] input_bin_c0,input_bin_c1,input_bin_c2,input_bin_c3,input_bin_c4,input_bin_c5,input_bin_c6,input_bin_c7,input_bin_c8,input_bin_c9,input_bin_c10,input_bin_c11,input_bin_c12,input_bin_c13,input_bin_c14,input_bin_c15;
   
   input       en_c_bank;
   input       start_add;

   
   output [7:0] bin_out;


   wire [3:0] ctr4_out_a,ctr4_out_b;
   wire       ctr4_overflow_a,ctr4b_overflow_b;
   
   wire           sn_out_a,sn_out_b,sn_mul_out;

   //wire [3:0]     bin_out;
   wire           bin_out_overflow;

   wire [15:0]    sr_out_a,sr_out_b;
   wire [15:0]    sr_mul_out;

   wire [7:0]    bin_out;

   wire          sn_out_c0,sn_out_c1,sn_out_c2,sn_out_c3,sn_out_c4,sn_out_c5,sn_out_c6,sn_out_c7,sn_out_c8,sn_out_c9,sn_out_c10,sn_out_c11,sn_out_c12,sn_out_c13,sn_out_c14,sn_out_c15;
   wire [15:0]         sr_add_out;


//bin2stoch a   
prg_4b dut_prg4b_a (
  .clk(clk),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_a),
  .sn_out(sn_out_a),
  .ctr_overflow(ctr4_overflow_a)         
);

//shiftreg_a  
shift_reg_16b dut_sr_a (
  .clk(clk),
  .scan_in(sn_out_a),
  .wrap_mode(wrap_mode_a),
  .en(en_sr_a),
  .rst(rst),
  .shiftreg_out(sr_out_a)
);

   

//bin2stoch b
prg_4b dut_prg4b_b (
  .clk(clk),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_b),
  .sn_out(sn_out_b),
  .ctr_overflow(ctr4_overflow_b)         
);

//shiftreg_b 
shift_reg_16b dut_sr_b (
  .clk(clk),
  .scan_in(sn_out_b),
  .wrap_mode(wrap_mode_b),
  .en(en_sr_b),
  .rst(rst),
  .shiftreg_out(sr_out_b)
);


   

//pipelined multiplier circuit
pipe_mul_16b dut_pipe_mul (
  .a(sr_out_a),
  .b(sr_out_b),
  .y(sr_mul_out)
);

//split c inputs
prg4b_bank dut_prg4b_bank_c (
  .clk(clk),
  .rst(rst),
  .en(en_c_bank),
  .bin_in0(input_bin_c0),
  .bin_in1(input_bin_c1),
  .bin_in2(input_bin_c2),
  .bin_in3(input_bin_c3),
  .bin_in4(input_bin_c4),
  .bin_in5(input_bin_c5),
  .bin_in6(input_bin_c6),
  .bin_in7(input_bin_c7),
  .bin_in8(input_bin_c8),
  .bin_in9(input_bin_c9),
  .bin_in10(input_bin_c10),
  .bin_in11(input_bin_c11),
  .bin_in12(input_bin_c12),
  .bin_in13(input_bin_c13),
  .bin_in14(input_bin_c14),
  .bin_in15(input_bin_c15),                           
  .sn_out0(sn_out_c0),
  .sn_out1(sn_out_c1),
  .sn_out2(sn_out_c2),
  .sn_out3(sn_out_c3),
  .sn_out4(sn_out_c4),
  .sn_out5(sn_out_c5),
  .sn_out6(sn_out_c6),
  .sn_out7(sn_out_c7),
  .sn_out8(sn_out_c8),
  .sn_out9(sn_out_c9),
  .sn_out10(sn_out_c10),
  .sn_out11(sn_out_c11),
  .sn_out12(sn_out_c12),
  .sn_out13(sn_out_c13),
  .sn_out14(sn_out_c14),
  .sn_out15(sn_out_c15)                                                      
);
   

pipe_scale_add_16b dut_scale_add (
  .a(sr_mul_out),
  .b0(sn_out_c0),
  .b1(sn_out_c1),
  .b2(sn_out_c2),
  .b3(sn_out_c3),
  .b4(sn_out_c4),
  .b5(sn_out_c5),
  .b6(sn_out_c6),
  .b7(sn_out_c7),
  .b8(sn_out_c8),
  .b9(sn_out_c9),
  .b10(sn_out_c10),
  .b11(sn_out_c11),
  .b12(sn_out_c12),
  .b13(sn_out_c13),
  .b14(sn_out_c14),
  .b15(sn_out_c15),
  .s(start_add),
  .y(sr_add_out)
);
   
                       

ctr_out_bank dut_ctr_out (
  .clk(clk),
  .rst(rst_out),
  .mul_in(sr_add_out),
  .bin_out(bin_out)                      
);
   
   

endmodule // det_stoch_mul



               







   