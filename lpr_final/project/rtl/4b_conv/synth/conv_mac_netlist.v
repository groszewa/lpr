
// Generated by Cadence Encounter(R) RTL Compiler RC14.28 - v14.20-s067_1

// Verification Directory fv/conv_mac 

module fulladder(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  HAX1 g22(.A (c), .B (b), .YC (ca), .YS (s));
endmodule

module fulladder_1(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  HAX1 g22(.A (c), .B (b), .YC (ca), .YS (s));
endmodule

module fulladder_2(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  HAX1 g22(.A (c), .B (b), .YC (ca), .YS (s));
endmodule

module fulladder_3(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (a), .B (b), .C (c), .YC (ca), .YS (s));
endmodule

module fulladder_4(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (a), .B (b), .C (c), .YC (ca), .YS (s));
endmodule

module fulladder_5(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (a), .B (b), .C (c), .YC (ca), .YS (s));
endmodule

module fulladder_6(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (a), .B (b), .C (c), .YC (ca), .YS (s));
endmodule

module fulladder_7(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (a), .B (b), .C (c), .YC (ca), .YS (s));
endmodule

module fulladder_8(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (a), .B (b), .C (c), .YC (ca), .YS (s));
endmodule

module fulladder_9(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  HAX1 g22(.A (b), .B (c), .YC (ca), .YS (s));
endmodule

module fulladder_10(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (b), .B (a), .C (c), .YC (ca), .YS (s));
endmodule

module fulladder_11(a, b, c, s, ca);
  input a, b, c;
  output s, ca;
  wire a, b, c;
  wire s, ca;
  FAX1 g63(.A (a), .B (b), .C (c), .YC (ca), .YS (s));
endmodule

module array4x4(a, b, p);
  input [3:0] a, b;
  output [7:0] p;
  wire [3:0] a, b;
  wire [7:0] p;
  wire [39:0] w;
  wire UNCONNECTED_HIER_Z, UNCONNECTED_HIER_Z0, UNCONNECTED_HIER_Z1,
       UNCONNECTED_HIER_Z2;
  fulladder a17(UNCONNECTED_HIER_Z, w[1], w[4], p[1], w[17]);
  fulladder_1 a18(UNCONNECTED_HIER_Z0, w[2], w[5], w[18], w[19]);
  fulladder_2 a19(UNCONNECTED_HIER_Z1, w[3], w[6], w[20], w[21]);
  fulladder_3 a20(w[8], w[17], w[18], p[2], w[23]);
  fulladder_4 a21(w[9], w[19], w[20], w[24], w[25]);
  fulladder_5 a22(w[10], w[7], w[21], w[26], w[27]);
  fulladder_6 a23(w[12], w[23], w[24], p[3], w[29]);
  fulladder_7 a24(w[13], w[25], w[26], w[30], w[31]);
  fulladder_8 a25(w[14], w[11], w[27], w[32], w[33]);
  fulladder_9 a26(UNCONNECTED_HIER_Z2, w[29], w[30], p[4], w[35]);
  fulladder_10 a27(w[31], w[32], w[35], p[5], w[37]);
  fulladder_11 a28(w[15], w[33], w[37], p[6], p[7]);
  AND2X1 g97(.A (a[0]), .B (b[0]), .Y (p[0]));
  AND2X1 g98(.A (a[1]), .B (b[2]), .Y (w[9]));
  AND2X1 g99(.A (a[3]), .B (b[2]), .Y (w[11]));
  AND2X1 g100(.A (a[3]), .B (b[1]), .Y (w[7]));
  AND2X1 g101(.A (a[1]), .B (b[0]), .Y (w[1]));
  AND2X1 g102(.A (a[2]), .B (b[0]), .Y (w[2]));
  AND2X1 g103(.A (a[3]), .B (b[0]), .Y (w[3]));
  AND2X1 g104(.A (a[0]), .B (b[1]), .Y (w[4]));
  AND2X1 g105(.A (a[0]), .B (b[3]), .Y (w[12]));
  AND2X1 g106(.A (a[1]), .B (b[1]), .Y (w[5]));
  AND2X1 g107(.A (a[2]), .B (b[1]), .Y (w[6]));
  AND2X1 g108(.A (a[3]), .B (b[3]), .Y (w[15]));
  AND2X1 g109(.A (a[2]), .B (b[2]), .Y (w[10]));
  AND2X1 g110(.A (a[1]), .B (b[3]), .Y (w[13]));
  AND2X1 g111(.A (a[0]), .B (b[2]), .Y (w[8]));
  AND2X1 g112(.A (a[2]), .B (b[3]), .Y (w[14]));
endmodule

module conv_mac(a, b, c, z);
  input [3:0] a, b;
  input [7:0] c;
  output [7:0] z;
  wire [3:0] a, b;
  wire [7:0] c;
  wire [7:0] z;
  wire [7:0] mul_int;
  wire UNCONNECTED, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  array4x4 multiplier(.a (a), .b (b), .p (mul_int));
  FAX1 g444(.A (c[6]), .B (mul_int[6]), .C (n_6), .YC (n_7), .YS
       (z[6]));
  FAX1 g445(.A (c[5]), .B (mul_int[5]), .C (n_5), .YC (n_6), .YS
       (z[5]));
  FAX1 g446(.A (c[4]), .B (mul_int[4]), .C (n_4), .YC (n_5), .YS
       (z[4]));
  FAX1 g447(.A (c[3]), .B (n_3), .C (mul_int[3]), .YC (n_4), .YS
       (z[3]));
  FAX1 g448(.A (c[2]), .B (mul_int[2]), .C (n_2), .YC (n_3), .YS
       (z[2]));
  FAX1 g449(.A (c[1]), .B (n_1), .C (mul_int[1]), .YC (n_2), .YS
       (z[1]));
  HAX1 g450(.A (c[0]), .B (mul_int[0]), .YC (n_1), .YS (z[0]));
  FAX1 g2(.A (n_7), .B (mul_int[7]), .C (c[7]), .YC (UNCONNECTED), .YS
       (z[7]));
endmodule

