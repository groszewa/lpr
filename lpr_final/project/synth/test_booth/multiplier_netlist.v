
// Generated by Cadence Encounter(R) RTL Compiler RC14.28 - v14.20-s067_1

// Verification Directory fv/multiplier 

module alu(out, a, b, cin);
  input [7:0] a, b;
  input cin;
  output [7:0] out;
  wire [7:0] a, b;
  wire cin;
  wire [7:0] out;
  wire UNCONNECTED, n_1, n_3, n_5, n_7, n_9, n_11, n_13;
  FAX1 g434(.A (b[6]), .B (a[6]), .C (n_11), .YC (n_13), .YS (out[6]));
  FAX1 g435(.A (a[5]), .B (b[5]), .C (n_9), .YC (n_11), .YS (out[5]));
  FAX1 g436(.A (a[4]), .B (b[4]), .C (n_7), .YC (n_9), .YS (out[4]));
  FAX1 g437(.A (a[3]), .B (b[3]), .C (n_5), .YC (n_7), .YS (out[3]));
  FAX1 g438(.A (a[2]), .B (b[2]), .C (n_3), .YC (n_5), .YS (out[2]));
  FAX1 g439(.A (a[1]), .B (b[1]), .C (n_1), .YC (n_3), .YS (out[1]));
  HAX1 g440(.A (b[0]), .B (a[0]), .YC (n_1), .YS (out[0]));
  FAX1 g2(.A (n_13), .B (a[6]), .C (b[7]), .YC (UNCONNECTED), .YS
       (out[7]));
endmodule

module alu_1(out, a, b, cin);
  input [7:0] a, b;
  input cin;
  output [7:0] out;
  wire [7:0] a, b;
  wire cin;
  wire [7:0] out;
  wire UNCONNECTED0, n_0, n_2, n_3, n_4, n_5, n_6, n_7;
  XNOR2X1 g107(.A (a[0]), .B (b[0]), .Y (out[0]));
  FAX1 g427(.A (b[6]), .B (a[6]), .C (n_6), .YC (n_7), .YS (out[6]));
  FAX1 g428(.A (a[5]), .B (b[5]), .C (n_5), .YC (n_6), .YS (out[5]));
  FAX1 g429(.A (a[4]), .B (b[4]), .C (n_4), .YC (n_5), .YS (out[4]));
  FAX1 g430(.A (a[3]), .B (b[3]), .C (n_3), .YC (n_4), .YS (out[3]));
  FAX1 g431(.A (a[2]), .B (b[2]), .C (n_2), .YC (n_3), .YS (out[2]));
  FAX1 g432(.A (a[1]), .B (b[1]), .C (n_0), .YC (n_2), .YS (out[1]));
  OR2X1 g434(.A (b[0]), .B (a[0]), .Y (n_0));
  FAX1 g2(.A (n_7), .B (a[6]), .C (b[7]), .YC (UNCONNECTED0), .YS
       (out[7]));
endmodule

module multiplier(prod, busy, mc, mp, clk, start);
  input [7:0] mc, mp;
  input clk, start;
  output [15:0] prod;
  output busy;
  wire [7:0] mc, mp;
  wire clk, start;
  wire [15:0] prod;
  wire busy;
  wire [7:0] M;
  wire [7:0] sum;
  wire [7:0] difference;
  wire [3:0] count;
  wire Q_1, UNCONNECTED_HIER_Z, UNCONNECTED_HIER_Z0,
       UNCONNECTED_HIER_Z1, n_0, n_1, n_2, n_3;
  wire n_4, n_5, n_6, n_7, n_8, n_9, n_10, n_11;
  wire n_12, n_13, n_14, n_15, n_16, n_17, n_18, n_19;
  wire n_20, n_21, n_22, n_23, n_24, n_25, n_26, n_27;
  wire n_28, n_29, n_30, n_31, n_32, n_33, n_34, n_35;
  wire n_36, n_37, n_38, n_39, n_40, n_41, n_42, n_43;
  wire n_44, n_45, n_46, n_47, n_48, n_49, n_50, n_51;
  wire n_52, n_53, n_54, n_55, n_56, n_57, n_58, n_59;
  wire n_60, n_61, n_62, n_63, n_64, n_65, n_66, n_67;
  wire n_68, n_69, n_70, n_71, n_72, n_73, n_74, n_75;
  wire n_76, n_78, n_79, n_80, n_81, n_82, n_83, n_84;
  wire n_85, n_86, n_87, n_88, n_89, n_90, n_91, n_92;
  wire n_93, n_94, n_99, n_100, n_101, n_102, n_103, n_104;
  wire n_105, n_106, n_115, n_116, n_117;
  assign prod[14] = prod[15];
  alu adder(sum, {UNCONNECTED_HIER_Z, prod[15], prod[13:8]}, M,
       UNCONNECTED_HIER_Z0);
  alu_1 subtracter(difference, {UNCONNECTED_HIER_Z1, prod[15],
       prod[13:8]}, {n_99, n_100, n_101, n_102, n_103, n_104, n_105,
       n_106}, 1'b1);
  INVX1 g121(.A (count[3]), .Y (busy));
  INVX1 g120(.A (M[0]), .Y (n_106));
  DFFPOSX1 \Q_reg[1] (.CLK (clk), .D (n_94), .Q (prod[1]));
  INVX1 g307(.A (n_93), .Y (n_94));
  MUX2X1 g308(.A (mp[1]), .B (prod[2]), .S (start), .Y (n_93));
  DFFPOSX1 \Q_reg[2] (.CLK (clk), .D (n_92), .Q (prod[2]));
  INVX1 g310(.A (n_91), .Y (n_92));
  MUX2X1 g311(.A (mp[2]), .B (prod[3]), .S (start), .Y (n_91));
  DFFPOSX1 \Q_reg[3] (.CLK (clk), .D (n_90), .Q (prod[3]));
  INVX1 g313(.A (n_89), .Y (n_90));
  MUX2X1 g314(.A (mp[3]), .B (prod[4]), .S (start), .Y (n_89));
  DFFPOSX1 \Q_reg[4] (.CLK (clk), .D (n_88), .Q (prod[4]));
  INVX1 g316(.A (n_87), .Y (n_88));
  MUX2X1 g317(.A (mp[4]), .B (prod[5]), .S (start), .Y (n_87));
  DFFPOSX1 \Q_reg[5] (.CLK (clk), .D (n_86), .Q (prod[5]));
  INVX1 g319(.A (n_85), .Y (n_86));
  MUX2X1 g320(.A (mp[5]), .B (prod[6]), .S (start), .Y (n_85));
  DFFPOSX1 \Q_reg[6] (.CLK (clk), .D (n_84), .Q (prod[6]));
  INVX1 g322(.A (n_83), .Y (n_84));
  MUX2X1 g323(.A (mp[6]), .B (prod[7]), .S (start), .Y (n_83));
  DFFPOSX1 \Q_reg[7] (.CLK (clk), .D (n_72), .Q (prod[7]));
  NAND2X1 g325(.A (n_74), .B (n_73), .Y (n_82));
  AOI22X1 g326(.A (n_117), .B (prod[8]), .C (sum[0]), .D (n_116), .Y
       (n_81));
  AOI22X1 g327(.A (difference[0]), .B (n_115), .C (start), .D (mp[7]),
       .Y (n_80));
  NOR3X1 g328(.A (start), .B (n_79), .C (n_78), .Y (n_117));
  AND2X1 g329(.A (n_79), .B (n_22), .Y (n_115));
  AND2X1 g330(.A (n_78), .B (n_22), .Y (n_116));
  AND2X1 g331(.A (n_76), .B (prod[0]), .Y (n_79));
  AND2X1 g332(.A (n_75), .B (Q_1), .Y (n_78));
  INVX1 g333(.A (M[5]), .Y (n_101));
  INVX1 g334(.A (M[7]), .Y (n_99));
  INVX1 g335(.A (M[1]), .Y (n_105));
  INVX1 g337(.A (Q_1), .Y (n_76));
  INVX1 g338(.A (M[3]), .Y (n_103));
  INVX1 g339(.A (prod[0]), .Y (n_75));
  INVX1 g340(.A (M[4]), .Y (n_102));
  INVX1 g341(.A (M[2]), .Y (n_104));
  INVX1 g342(.A (M[6]), .Y (n_100));
  BUFX2 drc_bufs(.A (n_80), .Y (n_74));
  BUFX2 drc_bufs343(.A (n_81), .Y (n_73));
  BUFX2 drc_bufs344(.A (n_82), .Y (n_72));
  DFFPOSX1 \count_reg[3] (.CLK (clk), .D (n_71), .Q (count[3]));
  AND2X1 g406(.A (n_70), .B (n_22), .Y (n_71));
  DFFPOSX1 \count_reg[2] (.CLK (clk), .D (n_69), .Q (count[2]));
  XOR2X1 g408(.A (n_67), .B (count[3]), .Y (n_70));
  AND2X1 g409(.A (n_68), .B (n_22), .Y (n_69));
  HAX1 g410(.A (count[2]), .B (n_57), .YC (n_67), .YS (n_68));
  DFFPOSX1 \count_reg[1] (.CLK (clk), .D (n_66), .Q (count[1]));
  DFFPOSX1 \A_reg[0] (.CLK (clk), .D (n_6), .Q (prod[8]));
  DFFPOSX1 \A_reg[3] (.CLK (clk), .D (n_0), .Q (prod[11]));
  DFFPOSX1 \A_reg[2] (.CLK (clk), .D (n_4), .Q (prod[10]));
  DFFPOSX1 \A_reg[4] (.CLK (clk), .D (n_5), .Q (prod[12]));
  DFFPOSX1 \A_reg[5] (.CLK (clk), .D (n_1), .Q (prod[13]));
  DFFPOSX1 \A_reg[6] (.CLK (clk), .D (n_2), .Q (prod[15]));
  DFFPOSX1 \A_reg[1] (.CLK (clk), .D (n_7), .Q (prod[9]));
  AND2X1 g419(.A (n_58), .B (n_22), .Y (n_66));
  DFFPOSX1 \M_reg[0] (.CLK (clk), .D (n_56), .Q (M[0]));
  DFFPOSX1 \M_reg[1] (.CLK (clk), .D (n_55), .Q (M[1]));
  DFFPOSX1 \M_reg[2] (.CLK (clk), .D (n_54), .Q (M[2]));
  DFFPOSX1 \M_reg[3] (.CLK (clk), .D (n_53), .Q (M[3]));
  DFFPOSX1 \M_reg[4] (.CLK (clk), .D (n_52), .Q (M[4]));
  DFFPOSX1 \M_reg[5] (.CLK (clk), .D (n_51), .Q (M[5]));
  DFFPOSX1 \M_reg[6] (.CLK (clk), .D (n_44), .Q (M[6]));
  DFFPOSX1 \M_reg[7] (.CLK (clk), .D (n_43), .Q (M[7]));
  DFFPOSX1 \Q_reg[0] (.CLK (clk), .D (n_42), .Q (prod[0]));
  NAND2X1 g429(.A (n_21), .B (n_12), .Y (n_65));
  NAND2X1 g430(.A (n_17), .B (n_13), .Y (n_64));
  NAND2X1 g431(.A (n_18), .B (n_10), .Y (n_63));
  NAND2X1 g432(.A (n_15), .B (n_8), .Y (n_62));
  NAND2X1 g433(.A (n_16), .B (n_11), .Y (n_61));
  NAND2X1 g434(.A (n_14), .B (n_9), .Y (n_60));
  NAND3X1 g435(.A (n_21), .B (n_19), .C (n_20), .Y (n_59));
  HAX1 g436(.A (count[1]), .B (count[0]), .YC (n_57), .YS (n_58));
  INVX1 g437(.A (n_50), .Y (n_56));
  INVX1 g438(.A (n_49), .Y (n_55));
  INVX1 g439(.A (n_48), .Y (n_54));
  INVX1 g440(.A (n_47), .Y (n_53));
  INVX1 g441(.A (n_46), .Y (n_52));
  INVX1 g442(.A (n_45), .Y (n_51));
  DFFPOSX1 Q_1_reg(.CLK (clk), .D (n_32), .Q (Q_1));
  DFFPOSX1 \count_reg[0] (.CLK (clk), .D (n_3), .Q (count[0]));
  MUX2X1 g445(.A (mc[0]), .B (M[0]), .S (start), .Y (n_50));
  MUX2X1 g446(.A (mc[1]), .B (M[1]), .S (start), .Y (n_49));
  MUX2X1 g447(.A (mc[2]), .B (M[2]), .S (start), .Y (n_48));
  MUX2X1 g448(.A (mc[3]), .B (M[3]), .S (start), .Y (n_47));
  MUX2X1 g449(.A (mc[4]), .B (M[4]), .S (start), .Y (n_46));
  MUX2X1 g450(.A (mc[5]), .B (M[5]), .S (start), .Y (n_45));
  INVX1 g451(.A (n_41), .Y (n_44));
  INVX1 g452(.A (n_40), .Y (n_43));
  INVX1 g453(.A (n_39), .Y (n_42));
  MUX2X1 g454(.A (mc[6]), .B (M[6]), .S (start), .Y (n_41));
  MUX2X1 g455(.A (mc[7]), .B (M[7]), .S (start), .Y (n_40));
  MUX2X1 g456(.A (mp[0]), .B (prod[1]), .S (start), .Y (n_39));
  AOI22X1 g457(.A (sum[4]), .B (n_116), .C (prod[12]), .D (n_117), .Y
       (n_38));
  AOI22X1 g458(.A (difference[5]), .B (n_115), .C (prod[13]), .D
       (n_117), .Y (n_37));
  AOI22X1 g459(.A (difference[6]), .B (n_115), .C (n_116), .D (sum[6]),
       .Y (n_36));
  AOI22X1 g460(.A (difference[1]), .B (n_115), .C (n_116), .D (sum[1]),
       .Y (n_35));
  AOI22X1 g461(.A (sum[2]), .B (n_116), .C (prod[10]), .D (n_117), .Y
       (n_34));
  AOI22X1 g462(.A (difference[3]), .B (n_115), .C (prod[11]), .D
       (n_117), .Y (n_33));
  AND2X1 g463(.A (prod[0]), .B (n_22), .Y (n_32));
  NOR2X1 g464(.A (start), .B (count[0]), .Y (n_31));
  NAND2X1 g465(.A (n_115), .B (difference[4]), .Y (n_30));
  NAND2X1 g466(.A (n_116), .B (sum[5]), .Y (n_29));
  NAND2X1 g467(.A (prod[15]), .B (n_117), .Y (n_28));
  NAND2X1 g468(.A (n_116), .B (sum[7]), .Y (n_27));
  NAND2X1 g469(.A (n_115), .B (difference[7]), .Y (n_26));
  NAND2X1 g470(.A (prod[9]), .B (n_117), .Y (n_25));
  NAND2X1 g471(.A (n_115), .B (difference[2]), .Y (n_24));
  NAND2X1 g472(.A (n_116), .B (sum[3]), .Y (n_23));
  INVX1 g473(.A (start), .Y (n_22));
  BUFX2 drc_bufs477(.A (n_26), .Y (n_20));
  BUFX2 drc_bufs478(.A (n_27), .Y (n_19));
  BUFX2 drc_bufs479(.A (n_30), .Y (n_18));
  BUFX2 drc_bufs480(.A (n_29), .Y (n_17));
  BUFX2 drc_bufs481(.A (n_25), .Y (n_16));
  BUFX2 drc_bufs482(.A (n_24), .Y (n_15));
  BUFX2 drc_bufs483(.A (n_23), .Y (n_14));
  BUFX2 drc_bufs484(.A (n_37), .Y (n_13));
  BUFX2 drc_bufs485(.A (n_36), .Y (n_12));
  BUFX2 drc_bufs486(.A (n_35), .Y (n_11));
  BUFX2 drc_bufs487(.A (n_38), .Y (n_10));
  BUFX2 drc_bufs488(.A (n_33), .Y (n_9));
  BUFX2 drc_bufs489(.A (n_34), .Y (n_8));
  BUFX2 drc_bufs490(.A (n_62), .Y (n_7));
  BUFX2 drc_bufs491(.A (n_61), .Y (n_6));
  BUFX2 drc_bufs492(.A (n_64), .Y (n_5));
  BUFX2 drc_bufs493(.A (n_60), .Y (n_4));
  BUFX2 drc_bufs494(.A (n_31), .Y (n_3));
  BUFX2 drc_bufs495(.A (n_59), .Y (n_2));
  BUFX2 drc_bufs496(.A (n_65), .Y (n_1));
  BUFX2 drc_bufs497(.A (n_63), .Y (n_0));
  BUFX2 drc_bufs498(.A (n_28), .Y (n_21));
endmodule

