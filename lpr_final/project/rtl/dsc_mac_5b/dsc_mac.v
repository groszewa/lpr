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


module prg_8b (
	clk,
    rst,
    en,
    bin_in,
    sn_out,
    ctr_overflow  
);

   input       clk,rst,en;
   input [7:0] bin_in;
   output      sn_out,ctr_overflow;

   wire [7:0]  ctr8_out;
   
   

counter #(
   .WIDTH (8)
) ctr8 (
  .clk(clk),
  .rst(rst),
  .en(en),
  .out(ctr8_out),
  .overflow(ctr_overflow)
);


comp_8b     comp8 (.a(bin_in), .b(ctr8_out), .a_gt_b(sn_out));

endmodule // prg_8b


module prg_10b (
	clk,
    rst,
    en,
    bin_in,
    sn_out,
    ctr_overflow  
);

   input       clk,rst,en;
   input [9:0] bin_in;
   output      sn_out,ctr_overflow;

   wire [9:0]  ctr8_out;
   
   

counter #(
   .WIDTH (10)
) ctr8 (
  .clk(clk),
  .rst(rst),
  .en(en),
  .out(ctr8_out),
  .overflow(ctr_overflow)
);


comp_10b     comp10 (.a(bin_in), .b(ctr8_out), .a_gt_b(sn_out));

endmodule // prg_10b


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


module det_stoch_scale_add (
	a,
    b,
    s,
    y
);

   input a,b,s;
   output y;

   assign y = ( a & ~s ) | ( b & s );

endmodule // det_stoch_mul


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




module dsc_mac_top (
	clk,
    rst,
    en,
    input_bin_a,
    input_bin_b,
    input_bin_c,
    en_c,
    bin_out,
    bin_out_overflow                                                
);

   input clk,rst,en,en_c;
   input [3:0] input_bin_a,input_bin_b;
   input [7:0] input_bin_c;

   output [7:0] bin_out;
   output bin_out_overflow;

   wire   sn_out_a,sn_out_b;
   wire   ctr4_overlflow_a,ctr4_overflow_b;

   wire   start_add,op_end;

   wire   sn_out_c,ctr8_overflow_c;

   wire   sn_mul_out,sn_add_out;
   
   
   
   
   

//bin2stoch a   
prg_5b dut_prg5b_a (
  .clk(clk),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_a),
  .sn_out(sn_out_a),
  .ctr_overflow(ctr4_overflow_a)         
);

//bin2stoch b
prg_5b dut_prg5b_b (
  .clk(ctr4_overflow_a),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_b),
  .sn_out(sn_out_b),
  .ctr_overflow(ctr4_overflow_b)         
);

//control counter
counter #(
  .WIDTH (1)
) control (
  .clk(ctr4_overflow_b),
  .rst(rst),
  .en(en),
  .out(start_add),
  .overflow(op_end)
);
           

//multiplier circuit
det_stoch_mul dut_mul (
  .a(sn_out_a),
  .b(sn_out_b),
  .y(sn_mul_out)
);

prg_10b dut_prg10b_c (
  .clk(clk),
  .rst(rst),
  .en(en_c),
  .bin_in(input_bin_c),
  .sn_out(sn_out_c),
  .ctr_overflow(ctr8_overflow_c)         
);

det_stoch_scale_add dut_adder (
  .a(sn_mul_out),
  .b(sn_out_c),
  .s(start_add),
  .y(sn_add_out)
);

                       
//stoch2bin out
counter #(
  .WIDTH (10)
) stoch2bin_out (
  .clk(clk),
  .rst(rst),
  .en(sn_add_out),
  .out(bin_out),
  .overflow(bin_out_overflow)
);
   

endmodule // dsc_mac_top



               







   