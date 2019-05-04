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
   

endmodule // det_stoch_mul




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


module pipe_mul_top (
clk,
rst,
en,
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

   input clk,rst,en,wrap_mode_a,wrap_mode_b,en_sr_a,en_sr_b,rst_out;
   input [3:0] input_bin_a,input_bin_b;
   output [7:0] bin_out;
   input [7:0]  input_bin_c;
   

   wire         sn_out_a,sn_out_b;
   wire         ctr4_overflow_a,ctr4_overflow_b;
   wire [15:0]  sr_out_a,sr_out_b,sr_mul_out;
   wire [7:0]   bin_out_int;
   
   

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
shift_reg_16b_noshift dut_sr_a (
  .clk(clk),
  .scan_in(sn_out_a),
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
                       

ctr_out_bank dut_ctr_out (
  .clk(clk),
  .rst(rst_out),
  .mul_in(sr_mul_out),
  .bin_out(bin_out_int)                      
);

   assign bin_out = bin_out_int + input_bin_c;
   
                     

endmodule // pipe_mul_top



               







   