
// Generated by Cadence Encounter(R) RTL Compiler RC14.28 - v14.20-s067_1

// Verification Directory fv/pipe_mul_half_top 

module csa_tree_add_628_68_group_49(in_0, in_1, in_2, in_3, in_4, in_5,
     in_6, in_7, out_0);
  input [4:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  output [7:0] out_0;
  wire [4:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  wire [7:0] out_0;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_9, n_10, n_11, n_12, n_13, n_14, n_15;
  wire n_16, n_17, n_18, n_19, n_20, n_21, n_22, n_23;
  wire n_24, n_25, n_26, n_27, n_28, n_29, n_30, n_31;
  wire n_32, n_33, n_34, n_36, n_37, n_38, n_39, n_40;
  wire n_41, n_42, n_43, n_44, n_45, n_46, n_47, n_48;
  wire n_49, n_50, n_51, n_52, n_54, n_55, n_56, n_57;
  wire n_58, n_59, n_60, n_62, n_64, n_66;
  FAX1 g825(.A (n_44), .B (n_56), .C (n_66), .YC (out_0[7]), .YS
       (out_0[6]));
  FAX1 g826(.A (n_58), .B (n_57), .C (n_64), .YC (n_66), .YS
       (out_0[5]));
  FAX1 g827(.A (n_54), .B (n_59), .C (n_62), .YC (n_64), .YS
       (out_0[4]));
  FAX1 g828(.A (n_48), .B (n_55), .C (n_60), .YC (n_62), .YS
       (out_0[3]));
  FAX1 g829(.A (n_39), .B (n_49), .C (n_52), .YC (n_60), .YS
       (out_0[2]));
  FAX1 g830(.A (n_46), .B (n_41), .C (n_51), .YC (n_58), .YS (n_59));
  FAX1 g831(.A (n_40), .B (n_45), .C (n_50), .YC (n_56), .YS (n_57));
  FAX1 g832(.A (n_43), .B (n_38), .C (n_47), .YC (n_54), .YS (n_55));
  FAX1 g833(.A (n_31), .B (n_34), .C (n_37), .YC (n_52), .YS
       (out_0[1]));
  FAX1 g834(.A (n_26), .B (n_33), .C (n_42), .YC (n_50), .YS (n_51));
  FAX1 g835(.A (n_30), .B (n_29), .C (n_36), .YC (n_48), .YS (n_49));
  FAX1 g836(.A (n_7), .B (n_27), .C (n_28), .YC (n_46), .YS (n_47));
  FAX1 g837(.A (n_24), .B (n_16), .C (n_32), .YC (n_44), .YS (n_45));
  FAX1 g838(.A (n_12), .B (n_22), .C (n_19), .YC (n_42), .YS (n_43));
  FAX1 g839(.A (n_6), .B (n_25), .C (n_17), .YC (n_40), .YS (n_41));
  FAX1 g840(.A (n_14), .B (n_23), .C (n_13), .YC (n_38), .YS (n_39));
  FAX1 g841(.A (n_10), .B (n_21), .C (n_15), .YC (n_36), .YS (n_37));
  FAX1 g842(.A (n_3), .B (n_9), .C (n_11), .YC (n_34), .YS (out_0[0]));
  FAX1 g843(.A (in_5[4]), .B (in_6[4]), .C (n_18), .YC (n_32), .YS
       (n_33));
  FAX1 g844(.A (n_2), .B (n_1), .C (n_8), .YC (n_30), .YS (n_31));
  FAX1 g845(.A (n_0), .B (n_5), .C (n_20), .YC (n_28), .YS (n_29));
  FAX1 g846(.A (in_5[3]), .B (in_6[3]), .C (n_4), .YC (n_26), .YS
       (n_27));
  FAX1 g847(.A (in_0[4]), .B (in_1[4]), .C (in_3[4]), .YC (n_24), .YS
       (n_25));
  FAX1 g848(.A (in_2[2]), .B (in_5[2]), .C (in_6[2]), .YC (n_22), .YS
       (n_23));
  FAX1 g849(.A (in_2[1]), .B (in_5[1]), .C (in_6[1]), .YC (n_20), .YS
       (n_21));
  FAX1 g850(.A (in_0[3]), .B (in_1[3]), .C (in_3[3]), .YC (n_18), .YS
       (n_19));
  FAX1 g851(.A (in_2[4]), .B (in_4[4]), .C (in_7[4]), .YC (n_16), .YS
       (n_17));
  FAX1 g852(.A (in_3[1]), .B (in_4[1]), .C (in_7[1]), .YC (n_14), .YS
       (n_15));
  FAX1 g853(.A (in_3[2]), .B (in_4[2]), .C (in_7[2]), .YC (n_12), .YS
       (n_13));
  FAX1 g854(.A (in_2[0]), .B (in_3[0]), .C (in_4[0]), .YC (n_10), .YS
       (n_11));
  FAX1 g855(.A (in_1[0]), .B (in_5[0]), .C (in_6[0]), .YC (n_8), .YS
       (n_9));
  FAX1 g856(.A (in_2[3]), .B (in_4[3]), .C (in_7[3]), .YC (n_6), .YS
       (n_7));
  HAX1 g857(.A (in_1[2]), .B (in_0[2]), .YC (n_4), .YS (n_5));
  HAX1 g858(.A (in_7[0]), .B (in_0[0]), .YC (n_2), .YS (n_3));
  HAX1 g859(.A (in_1[1]), .B (in_0[1]), .YC (n_0), .YS (n_1));
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

module counter_WIDTH5_2(out, clk, en, rst, overflow);
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

module counter_WIDTH5_3(out, clk, en, rst, overflow);
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

module counter_WIDTH5_4(out, clk, en, rst, overflow);
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

module counter_WIDTH5_5(out, clk, en, rst, overflow);
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

module counter_WIDTH5_6(out, clk, en, rst, overflow);
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

module counter_WIDTH5_7(out, clk, en, rst, overflow);
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

module ctr_out_bank_half(clk, rst, en, mul_in, bin_out);
  input clk, rst, en;
  input [7:0] mul_in;
  output [31:0] bin_out;
  wire clk, rst, en;
  wire [7:0] mul_in;
  wire [31:0] bin_out;
  wire [4:0] ctr7;
  wire [4:0] ctr6;
  wire [4:0] ctr5;
  wire [4:0] ctr4;
  wire [4:0] ctr3;
  wire [4:0] ctr2;
  wire [4:0] ctr0;
  wire [4:0] ctr1;
  wire [7:0] unused;
  wire n_1, n_2, n_3, n_4, n_5, n_6, n_16, n_26;
  csa_tree_add_628_68_group_49 csa_tree_add_628_68_groupi(.in_0 (ctr7),
       .in_1 (ctr6), .in_2 (ctr5), .in_3 (ctr4), .in_4 (ctr3), .in_5
       (ctr2), .in_6 (ctr0), .in_7 (ctr1), .out_0 (bin_out[7:0]));
  counter_WIDTH5 stoch2bin_0(.out (ctr0), .clk (clk), .en (n_16), .rst
       (rst), .overflow (unused[0]));
  counter_WIDTH5_1 stoch2bin_1(.out (ctr1), .clk (clk), .en (n_6), .rst
       (rst), .overflow (unused[1]));
  counter_WIDTH5_2 stoch2bin_2(.out (ctr2), .clk (clk), .en (n_5), .rst
       (rst), .overflow (unused[2]));
  counter_WIDTH5_3 stoch2bin_3(.out (ctr3), .clk (clk), .en (n_4), .rst
       (rst), .overflow (unused[3]));
  counter_WIDTH5_4 stoch2bin_4(.out (ctr4), .clk (clk), .en (n_3), .rst
       (rst), .overflow (unused[4]));
  counter_WIDTH5_5 stoch2bin_5(.out (ctr5), .clk (clk), .en (n_2), .rst
       (rst), .overflow (unused[5]));
  counter_WIDTH5_6 stoch2bin_6(.out (ctr6), .clk (clk), .en (n_1), .rst
       (rst), .overflow (unused[6]));
  counter_WIDTH5_7 stoch2bin_7(.out (ctr7), .clk (clk), .en (n_26),
       .rst (rst), .overflow (unused[7]));
  AND2X1 g57(.A (mul_in[0]), .B (en), .Y (n_16));
  AND2X1 g58(.A (mul_in[1]), .B (en), .Y (n_6));
  AND2X1 g59(.A (mul_in[3]), .B (en), .Y (n_4));
  AND2X1 g60(.A (mul_in[7]), .B (en), .Y (n_26));
  AND2X1 g61(.A (mul_in[4]), .B (en), .Y (n_3));
  AND2X1 g62(.A (mul_in[2]), .B (en), .Y (n_5));
  AND2X1 g63(.A (mul_in[5]), .B (en), .Y (n_2));
  AND2X1 g64(.A (mul_in[6]), .B (en), .Y (n_1));
endmodule

module pipe_mul_16b_half(a, b, y);
  input [7:0] a, b;
  output [7:0] y;
  wire [7:0] a, b;
  wire [7:0] y;
  AND2X1 g57(.A (b[7]), .B (a[7]), .Y (y[7]));
  AND2X1 g58(.A (b[6]), .B (a[6]), .Y (y[6]));
  AND2X1 g59(.A (b[2]), .B (a[2]), .Y (y[2]));
  AND2X1 g60(.A (b[1]), .B (a[1]), .Y (y[1]));
  AND2X1 g61(.A (b[4]), .B (a[4]), .Y (y[4]));
  AND2X1 g62(.A (b[0]), .B (a[0]), .Y (y[0]));
  AND2X1 g63(.A (b[5]), .B (a[5]), .Y (y[5]));
  AND2X1 g64(.A (b[3]), .B (a[3]), .Y (y[3]));
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
  HAX1 g27(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g28(.A (b), .Y (n_0));
endmodule

module comp_1b_2(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g27(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g28(.A (b), .Y (n_0));
endmodule

module comp_1b_3(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g27(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g28(.A (b), .Y (n_0));
endmodule

module comp_4b(a_gt_b, a, b);
  input [3:0] a, b;
  output a_gt_b;
  wire [3:0] a, b;
  wire a_gt_b;
  wire UNCONNECTED, agt, agt_9, agt_11, agt_16, e, e_13, e_19;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6;
  comp_1b comp0(.a (a[0]), .b (b[0]), .equal (UNCONNECTED), .a_larger
       (agt_16));
  comp_1b_1 comp1(.a (a[1]), .b (b[1]), .equal (e_19), .a_larger
       (agt_11));
  comp_1b_2 comp2(.a (a[2]), .b (b[2]), .equal (e_13), .a_larger (agt));
  comp_1b_3 comp3(.a (a[3]), .b (b[3]), .equal (e), .a_larger (agt_9));
  INVX1 g12(.A (e), .Y (n_6));
  INVX1 g13(.A (agt_9), .Y (n_5));
  OAI21X1 g73(.A (n_6), .B (n_1), .C (n_5), .Y (a_gt_b));
  AOI21X1 g74(.A (e_13), .B (n_3), .C (agt), .Y (n_4));
  INVX1 g75(.A (n_0), .Y (n_3));
  AOI21X1 g76(.A (agt_16), .B (e_19), .C (agt_11), .Y (n_2));
  BUFX2 drc_bufs(.A (n_4), .Y (n_1));
  BUFX2 drc_bufs77(.A (n_2), .Y (n_0));
endmodule

module counter_WIDTH4(out, clk, en, rst, overflow);
  input clk, en, rst;
  output [3:0] out;
  output overflow;
  wire clk, en, rst;
  wire [3:0] out;
  wire overflow;
  wire n_0, n_3, n_4, n_5, n_6, n_7, n_8, n_9;
  wire n_11, n_12, n_14, n_15, n_16, n_17, n_26, n_27;
  DFFSR \out_reg[3] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_27), .Q
       (n_17));
  DFFSR \out_reg[2] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_12), .Q
       (n_16));
  INVX1 g66(.A (n_11), .Y (n_12));
  MUX2X1 g67(.A (n_9), .B (out[2]), .S (en), .Y (n_11));
  DFFSR \out_reg[1] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_7), .Q
       (n_15));
  HAX1 g70(.A (out[2]), .B (n_4), .YC (n_8), .YS (n_9));
  INVX1 g71(.A (n_6), .Y (n_7));
  MUX2X1 g72(.A (n_5), .B (out[1]), .S (en), .Y (n_6));
  DFFSR \out_reg[0] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_0), .Q
       (n_14));
  HAX1 g74(.A (out[1]), .B (out[0]), .YC (n_4), .YS (n_5));
  INVX1 g79(.A (rst), .Y (n_3));
  BUFX2 drc_bufs95(.A (n_17), .Y (out[3]));
  BUFX2 drc_bufs96(.A (n_14), .Y (out[0]));
  BUFX2 drc_bufs97(.A (n_15), .Y (out[1]));
  BUFX2 drc_bufs98(.A (n_16), .Y (out[2]));
  XOR2X1 g2(.A (en), .B (out[0]), .Y (n_0));
  XOR2X1 g103(.A (n_26), .B (out[3]), .Y (n_27));
  AND2X1 g3(.A (n_8), .B (en), .Y (n_26));
endmodule

module prg_4b(clk, rst, en, bin_in, sn_out, ctr_overflow);
  input clk, rst, en;
  input [3:0] bin_in;
  output sn_out, ctr_overflow;
  wire clk, rst, en;
  wire [3:0] bin_in;
  wire sn_out, ctr_overflow;
  wire [3:0] ctr4_out;
  wire n_1;
  comp_4b comp4(.a_gt_b (sn_out), .a (bin_in), .b (ctr4_out));
  counter_WIDTH4 ctr4(.out (ctr4_out), .clk (clk), .en (en), .rst
       (rst), .overflow (n_1));
endmodule

module comp_1b_4(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_1;
  AND2X1 g14(.A (n_1), .B (a), .Y (a_larger));
  INVX1 g15(.A (b), .Y (n_1));
endmodule

module comp_1b_5(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g27(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g28(.A (b), .Y (n_0));
endmodule

module comp_1b_6(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g27(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g28(.A (b), .Y (n_0));
endmodule

module comp_1b_7(a, b, equal, a_larger);
  input a, b;
  output equal, a_larger;
  wire a, b;
  wire equal, a_larger;
  wire n_0;
  HAX1 g27(.A (a), .B (n_0), .YC (a_larger), .YS (equal));
  INVX1 g28(.A (b), .Y (n_0));
endmodule

module comp_4b_1(a_gt_b, a, b);
  input [3:0] a, b;
  output a_gt_b;
  wire [3:0] a, b;
  wire a_gt_b;
  wire UNCONNECTED0, agt, agt_9, agt_11, agt_16, e, e_13, e_19;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6;
  comp_1b_4 comp0(.a (a[0]), .b (b[0]), .equal (UNCONNECTED0),
       .a_larger (agt_16));
  comp_1b_5 comp1(.a (a[1]), .b (b[1]), .equal (e_19), .a_larger
       (agt_11));
  comp_1b_6 comp2(.a (a[2]), .b (b[2]), .equal (e_13), .a_larger (agt));
  comp_1b_7 comp3(.a (a[3]), .b (b[3]), .equal (e), .a_larger (agt_9));
  INVX1 g12(.A (e), .Y (n_6));
  INVX1 g13(.A (agt_9), .Y (n_5));
  OAI21X1 g73(.A (n_6), .B (n_1), .C (n_5), .Y (a_gt_b));
  AOI21X1 g74(.A (e_13), .B (n_3), .C (agt), .Y (n_4));
  INVX1 g75(.A (n_0), .Y (n_3));
  AOI21X1 g76(.A (agt_16), .B (e_19), .C (agt_11), .Y (n_2));
  BUFX2 drc_bufs(.A (n_4), .Y (n_1));
  BUFX2 drc_bufs77(.A (n_2), .Y (n_0));
endmodule

module counter_WIDTH4_1(out, clk, en, rst, overflow);
  input clk, en, rst;
  output [3:0] out;
  output overflow;
  wire clk, en, rst;
  wire [3:0] out;
  wire overflow;
  wire n_0, n_3, n_4, n_5, n_6, n_7, n_8, n_9;
  wire n_11, n_12, n_14, n_15, n_16, n_17, n_26, n_27;
  DFFSR \out_reg[3] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_27), .Q
       (n_17));
  DFFSR \out_reg[2] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_12), .Q
       (n_16));
  INVX1 g66(.A (n_11), .Y (n_12));
  MUX2X1 g67(.A (n_9), .B (out[2]), .S (en), .Y (n_11));
  DFFSR \out_reg[1] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_7), .Q
       (n_15));
  HAX1 g70(.A (out[2]), .B (n_4), .YC (n_8), .YS (n_9));
  INVX1 g71(.A (n_6), .Y (n_7));
  MUX2X1 g72(.A (n_5), .B (out[1]), .S (en), .Y (n_6));
  DFFSR \out_reg[0] (.R (n_3), .S (1'b1), .CLK (clk), .D (n_0), .Q
       (n_14));
  HAX1 g74(.A (out[1]), .B (out[0]), .YC (n_4), .YS (n_5));
  INVX1 g79(.A (rst), .Y (n_3));
  BUFX2 drc_bufs95(.A (n_17), .Y (out[3]));
  BUFX2 drc_bufs96(.A (n_14), .Y (out[0]));
  BUFX2 drc_bufs97(.A (n_15), .Y (out[1]));
  BUFX2 drc_bufs98(.A (n_16), .Y (out[2]));
  XOR2X1 g2(.A (en), .B (out[0]), .Y (n_0));
  XOR2X1 g103(.A (n_26), .B (out[3]), .Y (n_27));
  AND2X1 g3(.A (n_8), .B (en), .Y (n_26));
endmodule

module prg_4b_1(clk, rst, en, bin_in, sn_out, ctr_overflow);
  input clk, rst, en;
  input [3:0] bin_in;
  output sn_out, ctr_overflow;
  wire clk, rst, en;
  wire [3:0] bin_in;
  wire sn_out, ctr_overflow;
  wire [3:0] ctr4_out;
  wire n_1;
  comp_4b_1 comp4(.a_gt_b (sn_out), .a (bin_in), .b (ctr4_out));
  counter_WIDTH4_1 ctr4(.out (ctr4_out), .clk (clk), .en (en), .rst
       (rst), .overflow (n_1));
endmodule

module shift_reg_16b_half(clk, scan_in, wrap_mode, en, rst,
     shiftreg_out);
  input clk, scan_in, wrap_mode, en, rst;
  output [7:0] shiftreg_out;
  wire clk, scan_in, wrap_mode, en, rst;
  wire [7:0] shiftreg_out;
  wire [15:0] shiftreg;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_18, n_19, n_20, n_21, n_22, n_23, n_24;
  wire n_25, n_26, n_27, n_28, n_29, n_30, n_31, n_32;
  wire n_33, n_34, n_35, n_36, n_37, n_38, n_39, n_40;
  wire n_41, n_42, n_43, n_44, n_45, n_46, n_47, n_48;
  wire n_49, n_50, n_51, n_52;
  DFFSR \shiftreg_reg[0] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_52),
       .Q (shiftreg[0]));
  OAI21X1 g43(.A (n_19), .B (n_21), .C (n_0), .Y (n_52));
  DFFSR \shiftreg_reg[12] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_30),
       .Q (shiftreg[12]));
  DFFSR \shiftreg_reg[4] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_29),
       .Q (shiftreg[4]));
  DFFSR \shiftreg_reg[5] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_50),
       .Q (shiftreg[5]));
  DFFSR \shiftreg_reg[13] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_51),
       .Q (shiftreg[13]));
  DFFSR \shiftreg_reg[6] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_49),
       .Q (shiftreg[6]));
  DFFSR \shiftreg_reg[14] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_48),
       .Q (shiftreg[14]));
  DFFSR \shiftreg_reg[7] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_47),
       .Q (shiftreg[7]));
  DFFSR \shiftreg_reg[8] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_46),
       .Q (shiftreg[8]));
  DFFSR \shiftreg_reg[15] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_45),
       .Q (shiftreg[15]));
  DFFSR \shiftreg_reg[9] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_44),
       .Q (shiftreg[9]));
  DFFSR \shiftreg_reg[10] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_35),
       .Q (shiftreg[10]));
  DFFSR \shiftreg_reg[1] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_34),
       .Q (shiftreg[1]));
  DFFSR \shiftreg_reg[11] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_33),
       .Q (shiftreg[11]));
  DFFSR \shiftreg_reg[2] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_32),
       .Q (shiftreg[2]));
  DFFSR \shiftreg_reg[3] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_31),
       .Q (shiftreg[3]));
  INVX1 g59(.A (n_43), .Y (n_51));
  INVX1 g60(.A (n_42), .Y (n_50));
  INVX1 g61(.A (n_41), .Y (n_49));
  INVX1 g62(.A (n_40), .Y (n_48));
  INVX1 g63(.A (n_39), .Y (n_47));
  INVX1 g64(.A (n_38), .Y (n_46));
  INVX1 g65(.A (n_37), .Y (n_45));
  INVX1 g66(.A (n_36), .Y (n_44));
  MUX2X1 g67(.A (shiftreg_out[5]), .B (shiftreg_out[4]), .S (n_19), .Y
       (n_43));
  MUX2X1 g68(.A (n_8), .B (n_2), .S (en), .Y (n_42));
  MUX2X1 g69(.A (n_2), .B (n_5), .S (en), .Y (n_41));
  MUX2X1 g70(.A (shiftreg_out[6]), .B (shiftreg_out[5]), .S (n_19), .Y
       (n_40));
  MUX2X1 g71(.A (n_5), .B (n_4), .S (en), .Y (n_39));
  MUX2X1 g72(.A (n_4), .B (shiftreg_out[0]), .S (en), .Y (n_38));
  MUX2X1 g73(.A (shiftreg_out[7]), .B (shiftreg_out[6]), .S (n_19), .Y
       (n_37));
  MUX2X1 g74(.A (shiftreg_out[1]), .B (shiftreg_out[0]), .S (n_19), .Y
       (n_36));
  INVX1 g75(.A (n_28), .Y (n_35));
  INVX1 g76(.A (n_27), .Y (n_34));
  INVX1 g77(.A (n_26), .Y (n_33));
  INVX1 g78(.A (n_25), .Y (n_32));
  INVX1 g79(.A (n_24), .Y (n_31));
  INVX1 g80(.A (n_23), .Y (n_30));
  INVX1 g81(.A (n_22), .Y (n_29));
  MUX2X1 g82(.A (shiftreg_out[2]), .B (shiftreg_out[1]), .S (n_19), .Y
       (n_28));
  MUX2X1 g83(.A (n_1), .B (n_7), .S (en), .Y (n_27));
  MUX2X1 g84(.A (shiftreg_out[3]), .B (shiftreg_out[2]), .S (n_19), .Y
       (n_26));
  MUX2X1 g85(.A (n_7), .B (n_6), .S (en), .Y (n_25));
  MUX2X1 g86(.A (n_6), .B (n_3), .S (en), .Y (n_24));
  MUX2X1 g87(.A (shiftreg_out[4]), .B (shiftreg_out[3]), .S (n_19), .Y
       (n_23));
  MUX2X1 g88(.A (n_3), .B (n_8), .S (en), .Y (n_22));
  MUX2X1 g89(.A (shiftreg_out[7]), .B (scan_in), .S (wrap_mode), .Y
       (n_21));
  NAND2X1 g90(.A (n_19), .B (n_1), .Y (n_20));
  INVX1 g91(.A (en), .Y (n_19));
  INVX1 g92(.A (rst), .Y (n_18));
  BUFX2 drc_bufs156(.A (n_20), .Y (n_0));
  BUFX2 drc_bufs157(.A (shiftreg[0]), .Y (n_1));
  BUFX2 drc_bufs158(.A (shiftreg[10]), .Y (shiftreg_out[2]));
  BUFX2 drc_bufs159(.A (shiftreg[12]), .Y (shiftreg_out[4]));
  BUFX2 drc_bufs160(.A (shiftreg[8]), .Y (shiftreg_out[0]));
  BUFX2 drc_bufs161(.A (shiftreg[7]), .Y (n_4));
  BUFX2 drc_bufs162(.A (shiftreg[6]), .Y (n_5));
  BUFX2 drc_bufs163(.A (shiftreg[5]), .Y (n_2));
  BUFX2 drc_bufs164(.A (shiftreg[4]), .Y (n_8));
  BUFX2 drc_bufs165(.A (shiftreg[3]), .Y (n_3));
  BUFX2 drc_bufs166(.A (shiftreg[2]), .Y (n_6));
  BUFX2 drc_bufs167(.A (shiftreg[1]), .Y (n_7));
  BUFX2 drc_bufs168(.A (shiftreg[15]), .Y (shiftreg_out[7]));
  BUFX2 drc_bufs169(.A (shiftreg[14]), .Y (shiftreg_out[6]));
  BUFX2 drc_bufs170(.A (shiftreg[13]), .Y (shiftreg_out[5]));
  BUFX2 drc_bufs171(.A (shiftreg[9]), .Y (shiftreg_out[1]));
  BUFX2 drc_bufs172(.A (shiftreg[11]), .Y (shiftreg_out[3]));
endmodule

module shift_reg_16b_half_1(clk, scan_in, wrap_mode, en, rst,
     shiftreg_out);
  input clk, scan_in, wrap_mode, en, rst;
  output [7:0] shiftreg_out;
  wire clk, scan_in, wrap_mode, en, rst;
  wire [7:0] shiftreg_out;
  wire [15:0] shiftreg;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_18, n_19, n_20, n_21, n_22, n_23, n_24;
  wire n_25, n_26, n_27, n_28, n_29, n_30, n_31, n_32;
  wire n_33, n_34, n_35, n_36, n_37, n_38, n_39, n_40;
  wire n_41, n_42, n_43, n_44, n_45, n_46, n_47, n_48;
  wire n_49, n_50, n_51, n_52;
  DFFSR \shiftreg_reg[0] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_52),
       .Q (shiftreg[0]));
  OAI21X1 g43(.A (n_19), .B (n_21), .C (n_0), .Y (n_52));
  DFFSR \shiftreg_reg[12] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_30),
       .Q (shiftreg[12]));
  DFFSR \shiftreg_reg[4] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_29),
       .Q (shiftreg[4]));
  DFFSR \shiftreg_reg[5] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_50),
       .Q (shiftreg[5]));
  DFFSR \shiftreg_reg[13] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_51),
       .Q (shiftreg[13]));
  DFFSR \shiftreg_reg[6] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_49),
       .Q (shiftreg[6]));
  DFFSR \shiftreg_reg[14] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_48),
       .Q (shiftreg[14]));
  DFFSR \shiftreg_reg[7] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_47),
       .Q (shiftreg[7]));
  DFFSR \shiftreg_reg[8] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_46),
       .Q (shiftreg[8]));
  DFFSR \shiftreg_reg[15] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_45),
       .Q (shiftreg[15]));
  DFFSR \shiftreg_reg[9] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_44),
       .Q (shiftreg[9]));
  DFFSR \shiftreg_reg[10] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_35),
       .Q (shiftreg[10]));
  DFFSR \shiftreg_reg[1] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_34),
       .Q (shiftreg[1]));
  DFFSR \shiftreg_reg[11] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_33),
       .Q (shiftreg[11]));
  DFFSR \shiftreg_reg[2] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_32),
       .Q (shiftreg[2]));
  DFFSR \shiftreg_reg[3] (.R (n_18), .S (1'b1), .CLK (clk), .D (n_31),
       .Q (shiftreg[3]));
  INVX1 g59(.A (n_43), .Y (n_51));
  INVX1 g60(.A (n_42), .Y (n_50));
  INVX1 g61(.A (n_41), .Y (n_49));
  INVX1 g62(.A (n_40), .Y (n_48));
  INVX1 g63(.A (n_39), .Y (n_47));
  INVX1 g64(.A (n_38), .Y (n_46));
  INVX1 g65(.A (n_37), .Y (n_45));
  INVX1 g66(.A (n_36), .Y (n_44));
  MUX2X1 g67(.A (shiftreg_out[5]), .B (shiftreg_out[4]), .S (n_19), .Y
       (n_43));
  MUX2X1 g68(.A (n_8), .B (n_2), .S (en), .Y (n_42));
  MUX2X1 g69(.A (n_2), .B (n_5), .S (en), .Y (n_41));
  MUX2X1 g70(.A (shiftreg_out[6]), .B (shiftreg_out[5]), .S (n_19), .Y
       (n_40));
  MUX2X1 g71(.A (n_5), .B (n_4), .S (en), .Y (n_39));
  MUX2X1 g72(.A (n_4), .B (shiftreg_out[0]), .S (en), .Y (n_38));
  MUX2X1 g73(.A (shiftreg_out[7]), .B (shiftreg_out[6]), .S (n_19), .Y
       (n_37));
  MUX2X1 g74(.A (shiftreg_out[1]), .B (shiftreg_out[0]), .S (n_19), .Y
       (n_36));
  INVX1 g75(.A (n_28), .Y (n_35));
  INVX1 g76(.A (n_27), .Y (n_34));
  INVX1 g77(.A (n_26), .Y (n_33));
  INVX1 g78(.A (n_25), .Y (n_32));
  INVX1 g79(.A (n_24), .Y (n_31));
  INVX1 g80(.A (n_23), .Y (n_30));
  INVX1 g81(.A (n_22), .Y (n_29));
  MUX2X1 g82(.A (shiftreg_out[2]), .B (shiftreg_out[1]), .S (n_19), .Y
       (n_28));
  MUX2X1 g83(.A (n_1), .B (n_7), .S (en), .Y (n_27));
  MUX2X1 g84(.A (shiftreg_out[3]), .B (shiftreg_out[2]), .S (n_19), .Y
       (n_26));
  MUX2X1 g85(.A (n_7), .B (n_6), .S (en), .Y (n_25));
  MUX2X1 g86(.A (n_6), .B (n_3), .S (en), .Y (n_24));
  MUX2X1 g87(.A (shiftreg_out[4]), .B (shiftreg_out[3]), .S (n_19), .Y
       (n_23));
  MUX2X1 g88(.A (n_3), .B (n_8), .S (en), .Y (n_22));
  MUX2X1 g89(.A (shiftreg_out[7]), .B (scan_in), .S (wrap_mode), .Y
       (n_21));
  NAND2X1 g90(.A (n_19), .B (n_1), .Y (n_20));
  INVX1 g91(.A (en), .Y (n_19));
  INVX1 g92(.A (rst), .Y (n_18));
  BUFX2 drc_bufs156(.A (n_20), .Y (n_0));
  BUFX2 drc_bufs157(.A (shiftreg[0]), .Y (n_1));
  BUFX2 drc_bufs158(.A (shiftreg[10]), .Y (shiftreg_out[2]));
  BUFX2 drc_bufs159(.A (shiftreg[12]), .Y (shiftreg_out[4]));
  BUFX2 drc_bufs160(.A (shiftreg[8]), .Y (shiftreg_out[0]));
  BUFX2 drc_bufs161(.A (shiftreg[7]), .Y (n_4));
  BUFX2 drc_bufs162(.A (shiftreg[6]), .Y (n_5));
  BUFX2 drc_bufs163(.A (shiftreg[5]), .Y (n_2));
  BUFX2 drc_bufs164(.A (shiftreg[4]), .Y (n_8));
  BUFX2 drc_bufs165(.A (shiftreg[3]), .Y (n_3));
  BUFX2 drc_bufs166(.A (shiftreg[2]), .Y (n_6));
  BUFX2 drc_bufs167(.A (shiftreg[1]), .Y (n_7));
  BUFX2 drc_bufs168(.A (shiftreg[15]), .Y (shiftreg_out[7]));
  BUFX2 drc_bufs169(.A (shiftreg[14]), .Y (shiftreg_out[6]));
  BUFX2 drc_bufs170(.A (shiftreg[13]), .Y (shiftreg_out[5]));
  BUFX2 drc_bufs171(.A (shiftreg[9]), .Y (shiftreg_out[1]));
  BUFX2 drc_bufs172(.A (shiftreg[11]), .Y (shiftreg_out[3]));
endmodule

module pipe_mul_half_top(clk, rst, en, output_gate, input_bin_a,
     input_bin_b, input_bin_c, wrap_mode_a, wrap_mode_b, en_sr_a,
     en_sr_b, rst_out, bin_out);
  input clk, rst, en, output_gate, wrap_mode_a, wrap_mode_b, en_sr_a,
       en_sr_b, rst_out;
  input [3:0] input_bin_a, input_bin_b;
  input [7:0] input_bin_c;
  output [7:0] bin_out;
  wire clk, rst, en, output_gate, wrap_mode_a, wrap_mode_b, en_sr_a,
       en_sr_b, rst_out;
  wire [3:0] input_bin_a, input_bin_b;
  wire [7:0] input_bin_c;
  wire [7:0] bin_out;
  wire [7:0] sr_mul_out;
  wire [7:0] bin_out_int;
  wire [7:0] sr_out_a;
  wire [7:0] sr_out_b;
  wire UNCONNECTED1, UNCONNECTED2, UNCONNECTED3, UNCONNECTED4,
       UNCONNECTED5, UNCONNECTED6, UNCONNECTED7, UNCONNECTED8;
  wire UNCONNECTED9, UNCONNECTED10, UNCONNECTED11, UNCONNECTED12,
       UNCONNECTED13, UNCONNECTED14, UNCONNECTED15, UNCONNECTED16;
  wire UNCONNECTED17, UNCONNECTED18, UNCONNECTED19, UNCONNECTED20,
       UNCONNECTED21, UNCONNECTED22, UNCONNECTED23, UNCONNECTED24;
  wire UNCONNECTED25, ctr4_overflow_a, ctr4_overflow_b, n_1, n_2, n_3,
       n_4, n_5;
  wire n_6, n_7, sn_out_a, sn_out_b;
  ctr_out_bank_half dut_ctr_out(.clk (clk), .rst (rst_out), .en
       (output_gate), .mul_in (sr_mul_out), .bin_out ({UNCONNECTED24,
       UNCONNECTED23, UNCONNECTED22, UNCONNECTED21, UNCONNECTED20,
       UNCONNECTED19, UNCONNECTED18, UNCONNECTED17, UNCONNECTED16,
       UNCONNECTED15, UNCONNECTED14, UNCONNECTED13, UNCONNECTED12,
       UNCONNECTED11, UNCONNECTED10, UNCONNECTED9, UNCONNECTED8,
       UNCONNECTED7, UNCONNECTED6, UNCONNECTED5, UNCONNECTED4,
       UNCONNECTED3, UNCONNECTED2, UNCONNECTED1, bin_out_int}));
  pipe_mul_16b_half dut_pipe_mul(.a (sr_out_a), .b (sr_out_b), .y
       (sr_mul_out));
  prg_4b dut_prg4b_a(.clk (clk), .rst (rst), .en (en), .bin_in
       (input_bin_a), .sn_out (sn_out_a), .ctr_overflow
       (ctr4_overflow_a));
  prg_4b_1 dut_prg4b_b(.clk (clk), .rst (rst), .en (en), .bin_in
       (input_bin_b), .sn_out (sn_out_b), .ctr_overflow
       (ctr4_overflow_b));
  shift_reg_16b_half dut_sr_a(.clk (clk), .scan_in (sn_out_a),
       .wrap_mode (wrap_mode_a), .en (en_sr_a), .rst (rst),
       .shiftreg_out (sr_out_a));
  shift_reg_16b_half_1 dut_sr_b(.clk (clk), .scan_in (sn_out_b),
       .wrap_mode (wrap_mode_b), .en (en_sr_b), .rst (rst),
       .shiftreg_out (sr_out_b));
  FAX1 g444(.A (input_bin_c[6]), .B (bin_out_int[6]), .C (n_6), .YC
       (n_7), .YS (bin_out[6]));
  FAX1 g445(.A (input_bin_c[5]), .B (bin_out_int[5]), .C (n_5), .YC
       (n_6), .YS (bin_out[5]));
  FAX1 g446(.A (input_bin_c[4]), .B (bin_out_int[4]), .C (n_4), .YC
       (n_5), .YS (bin_out[4]));
  FAX1 g447(.A (input_bin_c[3]), .B (bin_out_int[3]), .C (n_3), .YC
       (n_4), .YS (bin_out[3]));
  FAX1 g448(.A (input_bin_c[2]), .B (bin_out_int[2]), .C (n_2), .YC
       (n_3), .YS (bin_out[2]));
  FAX1 g449(.A (input_bin_c[1]), .B (n_1), .C (bin_out_int[1]), .YC
       (n_2), .YS (bin_out[1]));
  HAX1 g450(.A (input_bin_c[0]), .B (bin_out_int[0]), .YC (n_1), .YS
       (bin_out[0]));
  FAX1 g2(.A (n_7), .B (bin_out_int[7]), .C (input_bin_c[7]), .YC
       (UNCONNECTED25), .YS (bin_out[7]));
endmodule

