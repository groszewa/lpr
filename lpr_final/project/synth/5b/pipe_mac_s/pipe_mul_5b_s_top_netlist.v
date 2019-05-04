
// Generated by Cadence Encounter(R) RTL Compiler RC14.28 - v14.20-s067_1

// Verification Directory fv/pipe_mul_5b_s_top 

module counter_WIDTH9(out, clk, en, rst, overflow);
  input clk, en, rst;
  output [8:0] out;
  output overflow;
  wire clk, en, rst;
  wire [8:0] out;
  wire overflow;
  wire n_0, n_2, n_3, n_4, n_5, n_6, n_7, n_8;
  wire n_9, n_10, n_11, n_12, n_13, n_14, n_15, n_16;
  wire n_17, n_18, n_19, n_20, n_21, n_22, n_23, n_24;
  wire n_25, n_26, n_27, n_28, n_30, n_31, n_34, n_35;
  wire n_36, n_37, n_38, n_39, n_40, n_41, n_42, n_56;
  wire n_57;
  DFFSR \out_reg[8] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_57), .Q
       (n_42));
  DFFSR \out_reg[7] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_31), .Q
       (n_41));
  INVX1 g148(.A (n_30), .Y (n_31));
  MUX2X1 g149(.A (n_28), .B (out[7]), .S (en), .Y (n_30));
  DFFSR \out_reg[6] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_26), .Q
       (n_40));
  HAX1 g152(.A (out[7]), .B (n_23), .YC (n_27), .YS (n_28));
  INVX1 g153(.A (n_25), .Y (n_26));
  MUX2X1 g154(.A (n_24), .B (out[6]), .S (en), .Y (n_25));
  DFFSR \out_reg[5] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_22), .Q
       (n_39));
  HAX1 g156(.A (out[6]), .B (n_19), .YC (n_23), .YS (n_24));
  INVX1 g157(.A (n_21), .Y (n_22));
  MUX2X1 g158(.A (n_20), .B (out[5]), .S (en), .Y (n_21));
  DFFSR \out_reg[4] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_18), .Q
       (n_38));
  HAX1 g160(.A (out[5]), .B (n_15), .YC (n_19), .YS (n_20));
  INVX1 g161(.A (n_17), .Y (n_18));
  MUX2X1 g162(.A (n_16), .B (out[4]), .S (en), .Y (n_17));
  DFFSR \out_reg[3] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_14), .Q
       (n_37));
  HAX1 g164(.A (out[4]), .B (n_11), .YC (n_15), .YS (n_16));
  INVX1 g165(.A (n_13), .Y (n_14));
  MUX2X1 g166(.A (n_12), .B (out[3]), .S (en), .Y (n_13));
  DFFSR \out_reg[2] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_10), .Q
       (n_36));
  HAX1 g168(.A (out[3]), .B (n_7), .YC (n_11), .YS (n_12));
  INVX1 g169(.A (n_9), .Y (n_10));
  MUX2X1 g170(.A (n_8), .B (out[2]), .S (en), .Y (n_9));
  DFFSR \out_reg[1] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_6), .Q
       (n_35));
  HAX1 g172(.A (out[2]), .B (n_3), .YC (n_7), .YS (n_8));
  INVX1 g173(.A (n_5), .Y (n_6));
  MUX2X1 g174(.A (n_4), .B (out[1]), .S (en), .Y (n_5));
  DFFSR \out_reg[0] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_0), .Q
       (n_34));
  HAX1 g176(.A (out[1]), .B (out[0]), .YC (n_3), .YS (n_4));
  INVX1 g178(.A (rst), .Y (n_2));
  BUFX2 drc_bufs215(.A (n_42), .Y (out[8]));
  BUFX2 drc_bufs216(.A (n_34), .Y (out[0]));
  BUFX2 drc_bufs217(.A (n_35), .Y (out[1]));
  BUFX2 drc_bufs218(.A (n_36), .Y (out[2]));
  BUFX2 drc_bufs219(.A (n_37), .Y (out[3]));
  BUFX2 drc_bufs220(.A (n_38), .Y (out[4]));
  BUFX2 drc_bufs221(.A (n_39), .Y (out[5]));
  BUFX2 drc_bufs222(.A (n_40), .Y (out[6]));
  BUFX2 drc_bufs223(.A (n_41), .Y (out[7]));
  XOR2X1 g2(.A (en), .B (out[0]), .Y (n_0));
  XOR2X1 g233(.A (n_56), .B (out[8]), .Y (n_57));
  AND2X1 g3(.A (en), .B (n_27), .Y (n_56));
endmodule

module counter_WIDTH9_1(out, clk, en, rst, overflow);
  input clk, en, rst;
  output [8:0] out;
  output overflow;
  wire clk, en, rst;
  wire [8:0] out;
  wire overflow;
  wire n_0, n_2, n_3, n_4, n_5, n_6, n_7, n_8;
  wire n_9, n_10, n_11, n_12, n_13, n_14, n_15, n_16;
  wire n_17, n_18, n_19, n_20, n_21, n_22, n_23, n_24;
  wire n_25, n_26, n_27, n_28, n_30, n_31, n_34, n_35;
  wire n_36, n_37, n_38, n_39, n_40, n_41, n_42, n_56;
  wire n_57;
  DFFSR \out_reg[8] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_57), .Q
       (n_42));
  DFFSR \out_reg[7] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_31), .Q
       (n_41));
  INVX1 g148(.A (n_30), .Y (n_31));
  MUX2X1 g149(.A (n_28), .B (out[7]), .S (en), .Y (n_30));
  DFFSR \out_reg[6] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_26), .Q
       (n_40));
  HAX1 g152(.A (out[7]), .B (n_23), .YC (n_27), .YS (n_28));
  INVX1 g153(.A (n_25), .Y (n_26));
  MUX2X1 g154(.A (n_24), .B (out[6]), .S (en), .Y (n_25));
  DFFSR \out_reg[5] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_22), .Q
       (n_39));
  HAX1 g156(.A (out[6]), .B (n_19), .YC (n_23), .YS (n_24));
  INVX1 g157(.A (n_21), .Y (n_22));
  MUX2X1 g158(.A (n_20), .B (out[5]), .S (en), .Y (n_21));
  DFFSR \out_reg[4] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_18), .Q
       (n_38));
  HAX1 g160(.A (out[5]), .B (n_15), .YC (n_19), .YS (n_20));
  INVX1 g161(.A (n_17), .Y (n_18));
  MUX2X1 g162(.A (n_16), .B (out[4]), .S (en), .Y (n_17));
  DFFSR \out_reg[3] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_14), .Q
       (n_37));
  HAX1 g164(.A (out[4]), .B (n_11), .YC (n_15), .YS (n_16));
  INVX1 g165(.A (n_13), .Y (n_14));
  MUX2X1 g166(.A (n_12), .B (out[3]), .S (en), .Y (n_13));
  DFFSR \out_reg[2] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_10), .Q
       (n_36));
  HAX1 g168(.A (out[3]), .B (n_7), .YC (n_11), .YS (n_12));
  INVX1 g169(.A (n_9), .Y (n_10));
  MUX2X1 g170(.A (n_8), .B (out[2]), .S (en), .Y (n_9));
  DFFSR \out_reg[1] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_6), .Q
       (n_35));
  HAX1 g172(.A (out[2]), .B (n_3), .YC (n_7), .YS (n_8));
  INVX1 g173(.A (n_5), .Y (n_6));
  MUX2X1 g174(.A (n_4), .B (out[1]), .S (en), .Y (n_5));
  DFFSR \out_reg[0] (.R (n_2), .S (1'b1), .CLK (clk), .D (n_0), .Q
       (n_34));
  HAX1 g176(.A (out[1]), .B (out[0]), .YC (n_3), .YS (n_4));
  INVX1 g178(.A (rst), .Y (n_2));
  BUFX2 drc_bufs215(.A (n_42), .Y (out[8]));
  BUFX2 drc_bufs216(.A (n_34), .Y (out[0]));
  BUFX2 drc_bufs217(.A (n_35), .Y (out[1]));
  BUFX2 drc_bufs218(.A (n_36), .Y (out[2]));
  BUFX2 drc_bufs219(.A (n_37), .Y (out[3]));
  BUFX2 drc_bufs220(.A (n_38), .Y (out[4]));
  BUFX2 drc_bufs221(.A (n_39), .Y (out[5]));
  BUFX2 drc_bufs222(.A (n_40), .Y (out[6]));
  BUFX2 drc_bufs223(.A (n_41), .Y (out[7]));
  XOR2X1 g2(.A (en), .B (out[0]), .Y (n_0));
  XOR2X1 g233(.A (n_56), .B (out[8]), .Y (n_57));
  AND2X1 g3(.A (en), .B (n_27), .Y (n_56));
endmodule

module ctr_out_bank_32_s(clk, rst, en, mul_in, bin_out);
  input clk, rst, en;
  input [3:0] mul_in;
  output [9:0] bin_out;
  wire clk, rst, en;
  wire [3:0] mul_in;
  wire [9:0] bin_out;
  wire [8:0] ctr0;
  wire [15:0] unused;
  wire [8:0] ctr1;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_13, n_15;
  counter_WIDTH9 stoch2bin_0(.out (ctr0), .clk (clk), .en (n_15), .rst
       (rst), .overflow (unused[0]));
  counter_WIDTH9_1 stoch2bin_1(.out (ctr1), .clk (clk), .en (n_13),
       .rst (rst), .overflow (unused[1]));
  AND2X1 g99(.A (mul_in[0]), .B (en), .Y (n_15));
  AND2X1 g100(.A (mul_in[1]), .B (en), .Y (n_13));
  FAX1 g533(.A (ctr0[8]), .B (ctr1[8]), .C (n_7), .YC (bin_out[9]), .YS
       (bin_out[8]));
  FAX1 g534(.A (ctr0[7]), .B (ctr1[7]), .C (n_6), .YC (n_7), .YS
       (bin_out[7]));
  FAX1 g535(.A (ctr0[6]), .B (ctr1[6]), .C (n_5), .YC (n_6), .YS
       (bin_out[6]));
  FAX1 g536(.A (ctr0[5]), .B (ctr1[5]), .C (n_4), .YC (n_5), .YS
       (bin_out[5]));
  FAX1 g537(.A (ctr0[4]), .B (ctr1[4]), .C (n_3), .YC (n_4), .YS
       (bin_out[4]));
  FAX1 g538(.A (ctr0[3]), .B (ctr1[3]), .C (n_2), .YC (n_3), .YS
       (bin_out[3]));
  FAX1 g539(.A (ctr0[2]), .B (ctr1[2]), .C (n_1), .YC (n_2), .YS
       (bin_out[2]));
  FAX1 g540(.A (ctr0[1]), .B (ctr1[1]), .C (n_0), .YC (n_1), .YS
       (bin_out[1]));
  HAX1 g541(.A (ctr1[0]), .B (ctr0[0]), .YC (n_0), .YS (bin_out[0]));
endmodule

module pipe_mul_2b(a, b, y);
  input [1:0] a, b;
  output [1:0] y;
  wire [1:0] a, b;
  wire [1:0] y;
  AND2X1 g15(.A (b[1]), .B (a[1]), .Y (y[1]));
  AND2X1 g16(.A (b[0]), .B (a[0]), .Y (y[0]));
endmodule

module comp_1b(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_1;
  AND2X1 g14(.A (n_1), .B (a), .Y (a_larger));
  INVX1 g15(.A (b), .Y (n_1));
endmodule

module comp_1b_1(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_1b_2(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_1b_3(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_1b_4(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_5b(a_gt_b, a, b);
  input [4:0] a, b;
  output a_gt_b;
  wire [4:0] a, b;
  wire a_gt_b;
  wire UNCONNECTED, agt, agt_11, agt_13, agt_18, agt_24, e, e_15;
  wire e_21, e_28, n_0, n_1, n_2, n_3, n_4, n_5;
  wire n_6, n_7, n_8;
  comp_1b comp0(.a (a[0]), .b (b[0]), .equal (UNCONNECTED), .a_larger
       (agt_24));
  comp_1b_1 comp1(.a (a[1]), .b (b[1]), .equal (e_28), .a_larger
       (agt_18));
  comp_1b_2 comp2(.a (a[2]), .b (b[2]), .equal (e_21), .a_larger
       (agt_13));
  comp_1b_3 comp3(.a (a[3]), .b (b[3]), .equal (e_15), .a_larger (agt));
  comp_1b_4 comp4(.a (a[4]), .b (b[4]), .equal (e), .a_larger (agt_11));
  INVX1 g20(.A (e_21), .Y (n_8));
  INVX1 g22(.A (e), .Y (n_7));
  INVX1 g21(.A (agt_13), .Y (n_6));
  INVX1 g23(.A (agt_11), .Y (n_5));
  OAI21X1 g120(.A (n_7), .B (n_1), .C (n_5), .Y (a_gt_b));
  AOI21X1 g121(.A (e_15), .B (n_3), .C (agt), .Y (n_4));
  OAI21X1 g122(.A (n_8), .B (n_0), .C (n_6), .Y (n_3));
  AOI21X1 g123(.A (agt_24), .B (e_28), .C (agt_18), .Y (n_2));
  BUFX2 drc_bufs(.A (n_4), .Y (n_1));
  BUFX2 drc_bufs124(.A (n_2), .Y (n_0));
endmodule

module counter_WIDTH5(out, clk, en, rst, overflow);
  input clk, en, rst;
  output [4:0] out;
  output overflow;
  wire clk, en, rst;
  wire [4:0] out;
  wire overflow;
  wire n_0, n_3, n_4, n_5, n_6, n_7, n_8, n_9;
  wire n_10, n_11, n_12, n_13, n_15, n_16, n_18, n_19;
  wire n_20, n_21, n_22, n_32, n_33;
  DFFSR \out_reg[4] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_33), .Q
       (n_22));
  DFFSR \out_reg[3] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_16), .Q
       (n_21));
  INVX1 g81(.A (n_15), .Y (n_16));
  MUX2X1 g82(.A (n_13), .B (out[3]), .S (en), .Y (n_15));
  DFFSR \out_reg[2] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_11), .Q
       (n_20));
  HAX1 g85(.A (out[3]), .B (n_8), .YC (n_12), .YS (n_13));
  INVX1 g86(.A (n_10), .Y (n_11));
  MUX2X1 g87(.A (n_9), .B (out[2]), .S (en), .Y (n_10));
  DFFSR \out_reg[1] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_7), .Q
       (n_19));
  HAX1 g89(.A (out[2]), .B (n_4), .YC (n_8), .YS (n_9));
  INVX1 g90(.A (n_6), .Y (n_7));
  MUX2X1 g91(.A (n_5), .B (out[1]), .S (en), .Y (n_6));
  DFFSR \out_reg[0] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_0), .Q
       (n_18));
  HAX1 g93(.A (out[1]), .B (out[0]), .YC (n_4), .YS (n_5));
  INVX1 g98(.A (rst), .Y (n_3));
  BUFX2 drc_bufs118(.A (n_22), .Y (out[4]));
  BUFX2 drc_bufs119(.A (n_18), .Y (out[0]));
  BUFX2 drc_bufs120(.A (n_19), .Y (out[1]));
  BUFX2 drc_bufs121(.A (n_20), .Y (out[2]));
  BUFX2 drc_bufs122(.A (n_21), .Y (out[3]));
  XOR2X1 g2(.A (en), .B (out[0]), .Y (n_0));
  XOR2X1 g128(.A (n_32), .B (out[4]), .Y (n_33));
  AND2X1 g3(.A (n_12), .B (en), .Y (n_32));
endmodule

module prg_5b(clk, rst, en, bin_in, sn_out, ctr_overflow);
  input clk, rst, en;
  input [4:0] bin_in;
  output sn_out, ctr_overflow;
  wire clk, rst, en;
  wire [4:0] bin_in;
  wire sn_out, ctr_overflow;
  wire [4:0] ctr4_out;
  wire n_9;
  comp_5b comp4(.a_gt_b (sn_out), .a (bin_in), .b (ctr4_out));
  counter_WIDTH5 ctr4(.out (ctr4_out), .clk (clk), .en (en), .rst
       (rst), .overflow (n_9));
endmodule

module comp_1b_5(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_1;
  AND2X1 g14(.A (n_1), .B (a), .Y (a_larger));
  INVX1 g15(.A (b), .Y (n_1));
endmodule

module comp_1b_6(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_1b_7(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_1b_8(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_1b_9(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g25(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g26(.A (b), .Y (n_0));
endmodule

module comp_5b_1(a_gt_b, a, b);
  input [4:0] a, b;
  output a_gt_b;
  wire [4:0] a, b;
  wire a_gt_b;
  wire UNCONNECTED0, agt, agt_11, agt_13, agt_18, agt_24, e, e_15;
  wire e_21, e_28, n_0, n_1, n_2, n_3, n_4, n_5;
  wire n_6, n_7, n_8;
  comp_1b_5 comp0(.a (a[0]), .b (b[0]), .equal (UNCONNECTED0),
       .a_larger (agt_24));
  comp_1b_6 comp1(.a (a[1]), .b (b[1]), .equal (e_28), .a_larger
       (agt_18));
  comp_1b_7 comp2(.a (a[2]), .b (b[2]), .equal (e_21), .a_larger
       (agt_13));
  comp_1b_8 comp3(.a (a[3]), .b (b[3]), .equal (e_15), .a_larger (agt));
  comp_1b_9 comp4(.a (a[4]), .b (b[4]), .equal (e), .a_larger (agt_11));
  INVX1 g21(.A (agt_13), .Y (n_8));
  INVX1 g20(.A (e_21), .Y (n_7));
  INVX1 g22(.A (e), .Y (n_6));
  INVX1 g23(.A (agt_11), .Y (n_5));
  OAI21X1 g120(.A (n_6), .B (n_1), .C (n_5), .Y (a_gt_b));
  AOI21X1 g121(.A (e_15), .B (n_3), .C (agt), .Y (n_4));
  OAI21X1 g122(.A (n_7), .B (n_0), .C (n_8), .Y (n_3));
  AOI21X1 g123(.A (agt_24), .B (e_28), .C (agt_18), .Y (n_2));
  BUFX2 drc_bufs(.A (n_4), .Y (n_1));
  BUFX2 drc_bufs124(.A (n_2), .Y (n_0));
endmodule

module counter_WIDTH5_1(out, clk, en, rst, overflow);
  input clk, en, rst;
  output [4:0] out;
  output overflow;
  wire clk, en, rst;
  wire [4:0] out;
  wire overflow;
  wire n_0, n_3, n_4, n_5, n_6, n_7, n_8, n_9;
  wire n_10, n_11, n_12, n_13, n_15, n_16, n_18, n_19;
  wire n_20, n_21, n_22, n_32, n_33;
  DFFSR \out_reg[4] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_33), .Q
       (n_22));
  DFFSR \out_reg[3] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_16), .Q
       (n_21));
  INVX1 g81(.A (n_15), .Y (n_16));
  MUX2X1 g82(.A (n_13), .B (out[3]), .S (en), .Y (n_15));
  DFFSR \out_reg[2] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_11), .Q
       (n_20));
  HAX1 g85(.A (out[3]), .B (n_8), .YC (n_12), .YS (n_13));
  INVX1 g86(.A (n_10), .Y (n_11));
  MUX2X1 g87(.A (n_9), .B (out[2]), .S (en), .Y (n_10));
  DFFSR \out_reg[1] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_7), .Q
       (n_19));
  HAX1 g89(.A (out[2]), .B (n_4), .YC (n_8), .YS (n_9));
  INVX1 g90(.A (n_6), .Y (n_7));
  MUX2X1 g91(.A (n_5), .B (out[1]), .S (en), .Y (n_6));
  DFFSR \out_reg[0] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_0), .Q
       (n_18));
  HAX1 g93(.A (out[1]), .B (out[0]), .YC (n_4), .YS (n_5));
  INVX1 g98(.A (rst), .Y (n_3));
  BUFX2 drc_bufs118(.A (n_22), .Y (out[4]));
  BUFX2 drc_bufs119(.A (n_18), .Y (out[0]));
  BUFX2 drc_bufs120(.A (n_19), .Y (out[1]));
  BUFX2 drc_bufs121(.A (n_20), .Y (out[2]));
  BUFX2 drc_bufs122(.A (n_21), .Y (out[3]));
  XOR2X1 g2(.A (en), .B (out[0]), .Y (n_0));
  XOR2X1 g128(.A (n_32), .B (out[4]), .Y (n_33));
  AND2X1 g3(.A (n_12), .B (en), .Y (n_32));
endmodule

module prg_5b_1(clk, rst, en, bin_in, sn_out, ctr_overflow);
  input clk, rst, en;
  input [4:0] bin_in;
  output sn_out, ctr_overflow;
  wire clk, rst, en;
  wire [4:0] bin_in;
  wire sn_out, ctr_overflow;
  wire [4:0] ctr4_out;
  wire n_9;
  comp_5b_1 comp4(.a_gt_b (sn_out), .a (bin_in), .b (ctr4_out));
  counter_WIDTH5_1 ctr4(.out (ctr4_out), .clk (clk), .en (en), .rst
       (rst), .overflow (n_9));
endmodule

module shift_reg_32b_s(clk, scan_in, wrap_mode, en, rst, shiftreg_out);
  input clk, scan_in, wrap_mode, en, rst;
  output [1:0] shiftreg_out;
  wire clk, scan_in, wrap_mode, en, rst;
  wire [1:0] shiftreg_out;
  wire [31:0] shiftreg;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_9, n_10, n_11, n_12, n_13, n_14, n_15;
  wire n_16, n_17, n_18, n_19, n_20, n_21, n_22, n_23;
  wire n_24, n_25, n_26, n_27, n_28, n_29, n_30, n_34;
  wire n_35, n_36, n_37, n_38, n_39, n_40, n_41, n_42;
  wire n_43, n_44, n_45, n_46, n_47, n_48, n_49, n_50;
  wire n_51, n_52, n_53, n_54, n_55, n_56, n_57, n_58;
  wire n_59, n_60, n_61, n_62, n_63, n_64, n_65, n_66;
  wire n_67, n_68, n_69, n_70, n_71, n_72, n_73, n_74;
  wire n_75, n_76, n_77, n_78, n_79, n_80, n_81, n_82;
  wire n_83, n_84, n_85, n_86, n_87, n_88, n_89, n_90;
  wire n_91, n_92, n_93, n_94, n_95, n_96, n_97, n_98;
  wire n_99, n_100;
  DFFSR \shiftreg_reg[0] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_100),
       .Q (shiftreg[0]));
  OAI21X1 g59(.A (n_35), .B (n_37), .C (n_0), .Y (n_100));
  DFFSR \shiftreg_reg[12] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_58),
       .Q (shiftreg[12]));
  DFFSR \shiftreg_reg[19] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_53),
       .Q (shiftreg[19]));
  DFFSR \shiftreg_reg[30] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_99),
       .Q (shiftreg[30]));
  DFFSR \shiftreg_reg[31] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_98),
       .Q (shiftreg[31]));
  DFFSR \shiftreg_reg[3] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_95),
       .Q (shiftreg[3]));
  DFFSR \shiftreg_reg[13] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_96),
       .Q (shiftreg[13]));
  DFFSR \shiftreg_reg[1] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_94),
       .Q (shiftreg[1]));
  DFFSR \shiftreg_reg[4] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_93),
       .Q (shiftreg[4]));
  DFFSR \shiftreg_reg[5] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_91),
       .Q (shiftreg[5]));
  DFFSR \shiftreg_reg[20] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_92),
       .Q (shiftreg[20]));
  DFFSR \shiftreg_reg[6] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_90),
       .Q (shiftreg[6]));
  DFFSR \shiftreg_reg[10] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_97),
       .Q (shiftreg[10]));
  DFFSR \shiftreg_reg[14] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_89),
       .Q (shiftreg[14]));
  DFFSR \shiftreg_reg[21] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_88),
       .Q (shiftreg[21]));
  DFFSR \shiftreg_reg[7] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_87),
       .Q (shiftreg[7]));
  DFFSR \shiftreg_reg[8] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_86),
       .Q (shiftreg[8]));
  DFFSR \shiftreg_reg[22] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_85),
       .Q (shiftreg[22]));
  DFFSR \shiftreg_reg[9] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_84),
       .Q (shiftreg[9]));
  DFFSR \shiftreg_reg[15] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_67),
       .Q (shiftreg[15]));
  DFFSR \shiftreg_reg[23] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_66),
       .Q (shiftreg[23]));
  DFFSR \shiftreg_reg[11] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_65),
       .Q (shiftreg[11]));
  DFFSR \shiftreg_reg[16] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_61),
       .Q (shiftreg[16]));
  DFFSR \shiftreg_reg[24] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_64),
       .Q (shiftreg[24]));
  DFFSR \shiftreg_reg[25] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_63),
       .Q (shiftreg[25]));
  DFFSR \shiftreg_reg[26] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_62),
       .Q (shiftreg[26]));
  DFFSR \shiftreg_reg[17] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_60),
       .Q (shiftreg[17]));
  DFFSR \shiftreg_reg[27] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_59),
       .Q (shiftreg[27]));
  DFFSR \shiftreg_reg[28] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_57),
       .Q (shiftreg[28]));
  DFFSR \shiftreg_reg[18] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_56),
       .Q (shiftreg[18]));
  DFFSR \shiftreg_reg[29] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_55),
       .Q (shiftreg[29]));
  DFFSR \shiftreg_reg[2] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_54),
       .Q (shiftreg[2]));
  INVX1 g91(.A (n_83), .Y (n_99));
  INVX1 g92(.A (n_82), .Y (n_98));
  INVX1 g93(.A (n_81), .Y (n_97));
  INVX1 g94(.A (n_80), .Y (n_96));
  INVX1 g95(.A (n_79), .Y (n_95));
  INVX1 g96(.A (n_78), .Y (n_94));
  INVX1 g97(.A (n_77), .Y (n_93));
  INVX1 g98(.A (n_76), .Y (n_92));
  INVX1 g99(.A (n_75), .Y (n_91));
  INVX1 g100(.A (n_74), .Y (n_90));
  INVX1 g101(.A (n_73), .Y (n_89));
  INVX1 g102(.A (n_72), .Y (n_88));
  INVX1 g103(.A (n_71), .Y (n_87));
  INVX1 g104(.A (n_70), .Y (n_86));
  INVX1 g105(.A (n_69), .Y (n_85));
  INVX1 g106(.A (n_68), .Y (n_84));
  MUX2X1 g107(.A (n_20), .B (shiftreg_out[0]), .S (en), .Y (n_83));
  MUX2X1 g108(.A (shiftreg_out[1]), .B (shiftreg_out[0]), .S (n_35), .Y
       (n_82));
  MUX2X1 g109(.A (n_14), .B (n_2), .S (en), .Y (n_81));
  MUX2X1 g110(.A (n_30), .B (n_3), .S (en), .Y (n_80));
  MUX2X1 g111(.A (n_21), .B (n_24), .S (en), .Y (n_79));
  MUX2X1 g112(.A (n_1), .B (n_10), .S (en), .Y (n_78));
  MUX2X1 g113(.A (n_24), .B (n_25), .S (en), .Y (n_77));
  MUX2X1 g114(.A (n_9), .B (n_11), .S (en), .Y (n_76));
  MUX2X1 g115(.A (n_25), .B (n_26), .S (en), .Y (n_75));
  MUX2X1 g116(.A (n_26), .B (n_27), .S (en), .Y (n_74));
  MUX2X1 g117(.A (n_3), .B (n_23), .S (en), .Y (n_73));
  MUX2X1 g118(.A (n_11), .B (n_12), .S (en), .Y (n_72));
  MUX2X1 g119(.A (n_27), .B (n_28), .S (en), .Y (n_71));
  MUX2X1 g120(.A (n_28), .B (n_29), .S (en), .Y (n_70));
  MUX2X1 g121(.A (n_12), .B (n_13), .S (en), .Y (n_69));
  MUX2X1 g122(.A (n_29), .B (n_14), .S (en), .Y (n_68));
  INVX1 g123(.A (n_52), .Y (n_67));
  INVX1 g124(.A (n_51), .Y (n_66));
  INVX1 g125(.A (n_50), .Y (n_65));
  INVX1 g126(.A (n_49), .Y (n_64));
  INVX1 g127(.A (n_48), .Y (n_63));
  INVX1 g128(.A (n_47), .Y (n_62));
  INVX1 g129(.A (n_46), .Y (n_61));
  INVX1 g130(.A (n_45), .Y (n_60));
  INVX1 g131(.A (n_44), .Y (n_59));
  INVX1 g132(.A (n_43), .Y (n_58));
  INVX1 g133(.A (n_42), .Y (n_57));
  INVX1 g134(.A (n_41), .Y (n_56));
  INVX1 g135(.A (n_40), .Y (n_55));
  INVX1 g136(.A (n_39), .Y (n_54));
  INVX1 g137(.A (n_38), .Y (n_53));
  MUX2X1 g138(.A (n_23), .B (n_5), .S (en), .Y (n_52));
  MUX2X1 g139(.A (n_13), .B (n_15), .S (en), .Y (n_51));
  MUX2X1 g140(.A (n_2), .B (n_4), .S (en), .Y (n_50));
  MUX2X1 g141(.A (n_15), .B (n_7), .S (en), .Y (n_49));
  MUX2X1 g142(.A (n_7), .B (n_16), .S (en), .Y (n_48));
  MUX2X1 g143(.A (n_16), .B (n_17), .S (en), .Y (n_47));
  MUX2X1 g144(.A (n_5), .B (n_22), .S (en), .Y (n_46));
  MUX2X1 g145(.A (n_22), .B (n_6), .S (en), .Y (n_45));
  MUX2X1 g146(.A (n_17), .B (n_18), .S (en), .Y (n_44));
  MUX2X1 g147(.A (n_4), .B (n_30), .S (en), .Y (n_43));
  MUX2X1 g148(.A (n_18), .B (n_19), .S (en), .Y (n_42));
  MUX2X1 g149(.A (n_6), .B (n_8), .S (en), .Y (n_41));
  MUX2X1 g150(.A (n_19), .B (n_20), .S (en), .Y (n_40));
  MUX2X1 g151(.A (n_10), .B (n_21), .S (en), .Y (n_39));
  MUX2X1 g152(.A (n_8), .B (n_9), .S (en), .Y (n_38));
  MUX2X1 g153(.A (shiftreg_out[1]), .B (scan_in), .S (wrap_mode), .Y
       (n_37));
  NAND2X1 g154(.A (n_35), .B (n_1), .Y (n_36));
  INVX1 g155(.A (en), .Y (n_35));
  INVX1 g156(.A (rst), .Y (n_34));
  BUFX2 drc_bufs284(.A (n_36), .Y (n_0));
  BUFX2 drc_bufs285(.A (shiftreg[0]), .Y (n_1));
  BUFX2 drc_bufs286(.A (shiftreg[10]), .Y (n_2));
  BUFX2 drc_bufs287(.A (shiftreg[12]), .Y (n_30));
  BUFX2 drc_bufs288(.A (shiftreg[8]), .Y (n_29));
  BUFX2 drc_bufs289(.A (shiftreg[7]), .Y (n_28));
  BUFX2 drc_bufs290(.A (shiftreg[6]), .Y (n_27));
  BUFX2 drc_bufs291(.A (shiftreg[5]), .Y (n_26));
  BUFX2 drc_bufs292(.A (shiftreg[4]), .Y (n_25));
  BUFX2 drc_bufs293(.A (shiftreg[3]), .Y (n_24));
  BUFX2 drc_bufs294(.A (shiftreg[31]), .Y (shiftreg_out[1]));
  BUFX2 drc_bufs295(.A (shiftreg[30]), .Y (shiftreg_out[0]));
  BUFX2 drc_bufs296(.A (shiftreg[2]), .Y (n_21));
  BUFX2 drc_bufs297(.A (shiftreg[29]), .Y (n_20));
  BUFX2 drc_bufs298(.A (shiftreg[28]), .Y (n_19));
  BUFX2 drc_bufs299(.A (shiftreg[27]), .Y (n_18));
  BUFX2 drc_bufs300(.A (shiftreg[26]), .Y (n_17));
  BUFX2 drc_bufs301(.A (shiftreg[25]), .Y (n_16));
  BUFX2 drc_bufs302(.A (shiftreg[24]), .Y (n_7));
  BUFX2 drc_bufs303(.A (shiftreg[16]), .Y (n_22));
  BUFX2 drc_bufs304(.A (shiftreg[22]), .Y (n_13));
  BUFX2 drc_bufs305(.A (shiftreg[21]), .Y (n_12));
  BUFX2 drc_bufs306(.A (shiftreg[20]), .Y (n_11));
  BUFX2 drc_bufs307(.A (shiftreg[1]), .Y (n_10));
  BUFX2 drc_bufs308(.A (shiftreg[19]), .Y (n_9));
  BUFX2 drc_bufs309(.A (shiftreg[18]), .Y (n_8));
  BUFX2 drc_bufs310(.A (shiftreg[17]), .Y (n_6));
  BUFX2 drc_bufs311(.A (shiftreg[23]), .Y (n_15));
  BUFX2 drc_bufs312(.A (shiftreg[15]), .Y (n_5));
  BUFX2 drc_bufs313(.A (shiftreg[14]), .Y (n_23));
  BUFX2 drc_bufs314(.A (shiftreg[13]), .Y (n_3));
  BUFX2 drc_bufs315(.A (shiftreg[9]), .Y (n_14));
  BUFX2 drc_bufs316(.A (shiftreg[11]), .Y (n_4));
endmodule

module shift_reg_32b_s_1(clk, scan_in, wrap_mode, en, rst,
     shiftreg_out);
  input clk, scan_in, wrap_mode, en, rst;
  output [1:0] shiftreg_out;
  wire clk, scan_in, wrap_mode, en, rst;
  wire [1:0] shiftreg_out;
  wire [31:0] shiftreg;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_9, n_10, n_11, n_12, n_13, n_14, n_15;
  wire n_16, n_17, n_18, n_19, n_20, n_21, n_22, n_23;
  wire n_24, n_25, n_26, n_27, n_28, n_29, n_30, n_34;
  wire n_35, n_36, n_37, n_38, n_39, n_40, n_41, n_42;
  wire n_43, n_44, n_45, n_46, n_47, n_48, n_49, n_50;
  wire n_51, n_52, n_53, n_54, n_55, n_56, n_57, n_58;
  wire n_59, n_60, n_61, n_62, n_63, n_64, n_65, n_66;
  wire n_67, n_68, n_69, n_70, n_71, n_72, n_73, n_74;
  wire n_75, n_76, n_77, n_78, n_79, n_80, n_81, n_82;
  wire n_83, n_84, n_85, n_86, n_87, n_88, n_89, n_90;
  wire n_91, n_92, n_93, n_94, n_95, n_96, n_97, n_98;
  wire n_99, n_100;
  DFFSR \shiftreg_reg[0] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_100),
       .Q (shiftreg[0]));
  OAI21X1 g59(.A (n_35), .B (n_37), .C (n_0), .Y (n_100));
  DFFSR \shiftreg_reg[12] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_58),
       .Q (shiftreg[12]));
  DFFSR \shiftreg_reg[19] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_53),
       .Q (shiftreg[19]));
  DFFSR \shiftreg_reg[30] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_99),
       .Q (shiftreg[30]));
  DFFSR \shiftreg_reg[31] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_98),
       .Q (shiftreg[31]));
  DFFSR \shiftreg_reg[3] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_95),
       .Q (shiftreg[3]));
  DFFSR \shiftreg_reg[13] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_96),
       .Q (shiftreg[13]));
  DFFSR \shiftreg_reg[1] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_94),
       .Q (shiftreg[1]));
  DFFSR \shiftreg_reg[4] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_93),
       .Q (shiftreg[4]));
  DFFSR \shiftreg_reg[5] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_91),
       .Q (shiftreg[5]));
  DFFSR \shiftreg_reg[20] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_92),
       .Q (shiftreg[20]));
  DFFSR \shiftreg_reg[6] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_90),
       .Q (shiftreg[6]));
  DFFSR \shiftreg_reg[10] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_97),
       .Q (shiftreg[10]));
  DFFSR \shiftreg_reg[14] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_89),
       .Q (shiftreg[14]));
  DFFSR \shiftreg_reg[21] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_88),
       .Q (shiftreg[21]));
  DFFSR \shiftreg_reg[7] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_87),
       .Q (shiftreg[7]));
  DFFSR \shiftreg_reg[8] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_86),
       .Q (shiftreg[8]));
  DFFSR \shiftreg_reg[22] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_85),
       .Q (shiftreg[22]));
  DFFSR \shiftreg_reg[9] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_84),
       .Q (shiftreg[9]));
  DFFSR \shiftreg_reg[15] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_67),
       .Q (shiftreg[15]));
  DFFSR \shiftreg_reg[23] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_66),
       .Q (shiftreg[23]));
  DFFSR \shiftreg_reg[11] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_65),
       .Q (shiftreg[11]));
  DFFSR \shiftreg_reg[16] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_61),
       .Q (shiftreg[16]));
  DFFSR \shiftreg_reg[24] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_64),
       .Q (shiftreg[24]));
  DFFSR \shiftreg_reg[25] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_63),
       .Q (shiftreg[25]));
  DFFSR \shiftreg_reg[26] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_62),
       .Q (shiftreg[26]));
  DFFSR \shiftreg_reg[17] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_60),
       .Q (shiftreg[17]));
  DFFSR \shiftreg_reg[27] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_59),
       .Q (shiftreg[27]));
  DFFSR \shiftreg_reg[28] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_57),
       .Q (shiftreg[28]));
  DFFSR \shiftreg_reg[18] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_56),
       .Q (shiftreg[18]));
  DFFSR \shiftreg_reg[29] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_55),
       .Q (shiftreg[29]));
  DFFSR \shiftreg_reg[2] (.R (n_34), .S (1'b1), .CLK (clk), .D (n_54),
       .Q (shiftreg[2]));
  INVX1 g91(.A (n_83), .Y (n_99));
  INVX1 g92(.A (n_82), .Y (n_98));
  INVX1 g93(.A (n_81), .Y (n_97));
  INVX1 g94(.A (n_80), .Y (n_96));
  INVX1 g95(.A (n_79), .Y (n_95));
  INVX1 g96(.A (n_78), .Y (n_94));
  INVX1 g97(.A (n_77), .Y (n_93));
  INVX1 g98(.A (n_76), .Y (n_92));
  INVX1 g99(.A (n_75), .Y (n_91));
  INVX1 g100(.A (n_74), .Y (n_90));
  INVX1 g101(.A (n_73), .Y (n_89));
  INVX1 g102(.A (n_72), .Y (n_88));
  INVX1 g103(.A (n_71), .Y (n_87));
  INVX1 g104(.A (n_70), .Y (n_86));
  INVX1 g105(.A (n_69), .Y (n_85));
  INVX1 g106(.A (n_68), .Y (n_84));
  MUX2X1 g107(.A (n_20), .B (shiftreg_out[0]), .S (en), .Y (n_83));
  MUX2X1 g108(.A (shiftreg_out[1]), .B (shiftreg_out[0]), .S (n_35), .Y
       (n_82));
  MUX2X1 g109(.A (n_14), .B (n_2), .S (en), .Y (n_81));
  MUX2X1 g110(.A (n_30), .B (n_3), .S (en), .Y (n_80));
  MUX2X1 g111(.A (n_21), .B (n_24), .S (en), .Y (n_79));
  MUX2X1 g112(.A (n_1), .B (n_10), .S (en), .Y (n_78));
  MUX2X1 g113(.A (n_24), .B (n_25), .S (en), .Y (n_77));
  MUX2X1 g114(.A (n_9), .B (n_11), .S (en), .Y (n_76));
  MUX2X1 g115(.A (n_25), .B (n_26), .S (en), .Y (n_75));
  MUX2X1 g116(.A (n_26), .B (n_27), .S (en), .Y (n_74));
  MUX2X1 g117(.A (n_3), .B (n_23), .S (en), .Y (n_73));
  MUX2X1 g118(.A (n_11), .B (n_12), .S (en), .Y (n_72));
  MUX2X1 g119(.A (n_27), .B (n_28), .S (en), .Y (n_71));
  MUX2X1 g120(.A (n_28), .B (n_29), .S (en), .Y (n_70));
  MUX2X1 g121(.A (n_12), .B (n_13), .S (en), .Y (n_69));
  MUX2X1 g122(.A (n_29), .B (n_14), .S (en), .Y (n_68));
  INVX1 g123(.A (n_52), .Y (n_67));
  INVX1 g124(.A (n_51), .Y (n_66));
  INVX1 g125(.A (n_50), .Y (n_65));
  INVX1 g126(.A (n_49), .Y (n_64));
  INVX1 g127(.A (n_48), .Y (n_63));
  INVX1 g128(.A (n_47), .Y (n_62));
  INVX1 g129(.A (n_46), .Y (n_61));
  INVX1 g130(.A (n_45), .Y (n_60));
  INVX1 g131(.A (n_44), .Y (n_59));
  INVX1 g132(.A (n_43), .Y (n_58));
  INVX1 g133(.A (n_42), .Y (n_57));
  INVX1 g134(.A (n_41), .Y (n_56));
  INVX1 g135(.A (n_40), .Y (n_55));
  INVX1 g136(.A (n_39), .Y (n_54));
  INVX1 g137(.A (n_38), .Y (n_53));
  MUX2X1 g138(.A (n_23), .B (n_5), .S (en), .Y (n_52));
  MUX2X1 g139(.A (n_13), .B (n_15), .S (en), .Y (n_51));
  MUX2X1 g140(.A (n_2), .B (n_4), .S (en), .Y (n_50));
  MUX2X1 g141(.A (n_15), .B (n_7), .S (en), .Y (n_49));
  MUX2X1 g142(.A (n_7), .B (n_16), .S (en), .Y (n_48));
  MUX2X1 g143(.A (n_16), .B (n_17), .S (en), .Y (n_47));
  MUX2X1 g144(.A (n_5), .B (n_22), .S (en), .Y (n_46));
  MUX2X1 g145(.A (n_22), .B (n_6), .S (en), .Y (n_45));
  MUX2X1 g146(.A (n_17), .B (n_18), .S (en), .Y (n_44));
  MUX2X1 g147(.A (n_4), .B (n_30), .S (en), .Y (n_43));
  MUX2X1 g148(.A (n_18), .B (n_19), .S (en), .Y (n_42));
  MUX2X1 g149(.A (n_6), .B (n_8), .S (en), .Y (n_41));
  MUX2X1 g150(.A (n_19), .B (n_20), .S (en), .Y (n_40));
  MUX2X1 g151(.A (n_10), .B (n_21), .S (en), .Y (n_39));
  MUX2X1 g152(.A (n_8), .B (n_9), .S (en), .Y (n_38));
  MUX2X1 g153(.A (shiftreg_out[1]), .B (scan_in), .S (wrap_mode), .Y
       (n_37));
  NAND2X1 g154(.A (n_35), .B (n_1), .Y (n_36));
  INVX1 g155(.A (en), .Y (n_35));
  INVX1 g156(.A (rst), .Y (n_34));
  BUFX2 drc_bufs284(.A (n_36), .Y (n_0));
  BUFX2 drc_bufs285(.A (shiftreg[0]), .Y (n_1));
  BUFX2 drc_bufs286(.A (shiftreg[10]), .Y (n_2));
  BUFX2 drc_bufs287(.A (shiftreg[12]), .Y (n_30));
  BUFX2 drc_bufs288(.A (shiftreg[8]), .Y (n_29));
  BUFX2 drc_bufs289(.A (shiftreg[7]), .Y (n_28));
  BUFX2 drc_bufs290(.A (shiftreg[6]), .Y (n_27));
  BUFX2 drc_bufs291(.A (shiftreg[5]), .Y (n_26));
  BUFX2 drc_bufs292(.A (shiftreg[4]), .Y (n_25));
  BUFX2 drc_bufs293(.A (shiftreg[3]), .Y (n_24));
  BUFX2 drc_bufs294(.A (shiftreg[31]), .Y (shiftreg_out[1]));
  BUFX2 drc_bufs295(.A (shiftreg[30]), .Y (shiftreg_out[0]));
  BUFX2 drc_bufs296(.A (shiftreg[2]), .Y (n_21));
  BUFX2 drc_bufs297(.A (shiftreg[29]), .Y (n_20));
  BUFX2 drc_bufs298(.A (shiftreg[28]), .Y (n_19));
  BUFX2 drc_bufs299(.A (shiftreg[27]), .Y (n_18));
  BUFX2 drc_bufs300(.A (shiftreg[26]), .Y (n_17));
  BUFX2 drc_bufs301(.A (shiftreg[25]), .Y (n_16));
  BUFX2 drc_bufs302(.A (shiftreg[24]), .Y (n_7));
  BUFX2 drc_bufs303(.A (shiftreg[16]), .Y (n_22));
  BUFX2 drc_bufs304(.A (shiftreg[22]), .Y (n_13));
  BUFX2 drc_bufs305(.A (shiftreg[21]), .Y (n_12));
  BUFX2 drc_bufs306(.A (shiftreg[20]), .Y (n_11));
  BUFX2 drc_bufs307(.A (shiftreg[1]), .Y (n_10));
  BUFX2 drc_bufs308(.A (shiftreg[19]), .Y (n_9));
  BUFX2 drc_bufs309(.A (shiftreg[18]), .Y (n_8));
  BUFX2 drc_bufs310(.A (shiftreg[17]), .Y (n_6));
  BUFX2 drc_bufs311(.A (shiftreg[23]), .Y (n_15));
  BUFX2 drc_bufs312(.A (shiftreg[15]), .Y (n_5));
  BUFX2 drc_bufs313(.A (shiftreg[14]), .Y (n_23));
  BUFX2 drc_bufs314(.A (shiftreg[13]), .Y (n_3));
  BUFX2 drc_bufs315(.A (shiftreg[9]), .Y (n_14));
  BUFX2 drc_bufs316(.A (shiftreg[11]), .Y (n_4));
endmodule

module pipe_mul_5b_s_top(clk, rst, en, output_gate, input_bin_a,
     input_bin_b, input_bin_c, wrap_mode_a, wrap_mode_b, en_sr_a,
     en_sr_b, rst_out, bin_out);
  input clk, rst, en, output_gate, wrap_mode_a, wrap_mode_b, en_sr_a,
       en_sr_b, rst_out;
  input [4:0] input_bin_a, input_bin_b, input_bin_c;
  output [9:0] bin_out;
  wire clk, rst, en, output_gate, wrap_mode_a, wrap_mode_b, en_sr_a,
       en_sr_b, rst_out;
  wire [4:0] input_bin_a, input_bin_b, input_bin_c;
  wire [9:0] bin_out;
  wire [31:0] sr_mul_out;
  wire [9:0] bin_out_int;
  wire [31:0] sr_out_a;
  wire [31:0] sr_out_b;
  wire ctr4_overflow_a, ctr4_overflow_b, n_0, n_1, n_2, n_3, n_4, n_5;
  wire n_6, n_7, n_8, sn_out_a, sn_out_b;
  ctr_out_bank_32_s dut_ctr_out(.clk (clk), .rst (rst_out), .en
       (output_gate), .mul_in (sr_mul_out[3:0]), .bin_out
       (bin_out_int));
  pipe_mul_2b dut_pipe_mul(.a (sr_out_a[1:0]), .b (sr_out_b[1:0]), .y
       (sr_mul_out[1:0]));
  prg_5b dut_prg5b_a(.clk (clk), .rst (rst), .en (en), .bin_in
       (input_bin_a), .sn_out (sn_out_a), .ctr_overflow
       (ctr4_overflow_a));
  prg_5b_1 dut_prg5b_b(.clk (clk), .rst (rst), .en (en), .bin_in
       (input_bin_b), .sn_out (sn_out_b), .ctr_overflow
       (ctr4_overflow_b));
  shift_reg_32b_s dut_sr_a(.clk (clk), .scan_in (sn_out_a), .wrap_mode
       (wrap_mode_a), .en (en_sr_a), .rst (rst), .shiftreg_out
       (sr_out_a[1:0]));
  shift_reg_32b_s_1 dut_sr_b(.clk (clk), .scan_in (sn_out_b),
       .wrap_mode (wrap_mode_b), .en (en_sr_b), .rst (rst),
       .shiftreg_out (sr_out_b[1:0]));
  XOR2X1 g429(.A (n_8), .B (bin_out_int[9]), .Y (bin_out[9]));
  HAX1 g430(.A (bin_out_int[8]), .B (n_7), .YC (n_8), .YS (bin_out[8]));
  HAX1 g431(.A (bin_out_int[7]), .B (n_6), .YC (n_7), .YS (bin_out[7]));
  HAX1 g432(.A (bin_out_int[6]), .B (n_5), .YC (n_6), .YS (bin_out[6]));
  HAX1 g433(.A (bin_out_int[5]), .B (n_4), .YC (n_5), .YS (bin_out[5]));
  FAX1 g434(.A (input_bin_c[4]), .B (bin_out_int[4]), .C (n_3), .YC
       (n_4), .YS (bin_out[4]));
  FAX1 g435(.A (input_bin_c[3]), .B (bin_out_int[3]), .C (n_2), .YC
       (n_3), .YS (bin_out[3]));
  FAX1 g436(.A (input_bin_c[2]), .B (bin_out_int[2]), .C (n_1), .YC
       (n_2), .YS (bin_out[2]));
  FAX1 g437(.A (input_bin_c[1]), .B (bin_out_int[1]), .C (n_0), .YC
       (n_1), .YS (bin_out[1]));
  HAX1 g438(.A (input_bin_c[0]), .B (bin_out_int[0]), .YC (n_0), .YS
       (bin_out[0]));
endmodule

