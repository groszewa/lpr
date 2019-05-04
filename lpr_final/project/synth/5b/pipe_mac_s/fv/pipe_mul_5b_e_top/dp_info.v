module csa_tree_add_1256_40_group_25_GENERIC_REAL(in_0, in_1, in_2,
     in_3, out_0);
// synthesis_equation "assign out_0 = ( ( ( in_2 + in_3 )  + in_1 )  + in_0 )  ;"
  input [7:0] in_0, in_1, in_2, in_3;
  output [9:0] out_0;
  wire [7:0] in_0, in_1, in_2, in_3;
  wire [9:0] out_0;
  wire n_44, n_45, n_46, n_47, n_48, n_49, n_50, n_51;
  wire n_52, n_54, n_55, n_56, n_57, n_58, n_59, n_60;
  wire n_61, n_62, n_63, n_64, n_65, n_66, n_67, n_68;
  wire n_69, n_70, n_71, n_72, n_73, n_74, n_75, n_76;
  wire n_77, n_78, n_79, n_80, n_81, n_82, n_83, n_84;
  wire n_85, n_86, n_87, n_88, n_89, n_90, n_91, n_92;
  wire n_93, n_94, n_95, n_96, n_97, n_98, n_99, n_100;
  wire n_101, n_102, n_103, n_104, n_105, n_106, n_107, n_108;
  wire n_109, n_110, n_111, n_112, n_113, n_114, n_115, n_116;
  wire n_117, n_118, n_119, n_120, n_121, n_122, n_123, n_124;
  wire n_125, n_126, n_127, n_128, n_129, n_130, n_131, n_132;
  wire n_133, n_134, n_135, n_136, n_137, n_138, n_139, n_140;
  wire n_141, n_142, n_143, n_144, n_145, n_146, n_147, n_148;
  wire n_149, n_150, n_151, n_152, n_153, n_154, n_155, n_156;
  wire n_157, n_158, n_159, n_160, n_161, n_162, n_163, n_164;
  wire n_165, n_166, n_167, n_168, n_169, n_170;
  xor g1 (n_62, in_0[0], in_3[0]);
  and g16 (n_51, in_0[0], in_3[0]);
  xor g17 (n_64, in_0[1], in_1[1]);
  and g2 (n_65, in_0[1], in_1[1]);
  xor g18 (n_77, in_3[1], in_2[1]);
  xor g19 (n_61, n_77, n_64);
  nand g3 (n_78, in_3[1], in_2[1]);
  nand g20 (n_79, n_64, in_2[1]);
  nand g21 (n_80, in_3[1], n_64);
  nand g22 (n_50, n_78, n_79, n_80);
  xor g23 (n_81, in_0[2], in_1[2]);
  xor g24 (n_66, n_81, in_3[2]);
  nand g25 (n_82, in_0[2], in_1[2]);
  nand g4 (n_83, in_3[2], in_1[2]);
  nand g26 (n_84, in_0[2], in_3[2]);
  nand g27 (n_67, n_82, n_83, n_84);
  xor g28 (n_85, in_2[2], n_65);
  xor g29 (n_60, n_85, n_66);
  nand g30 (n_86, in_2[2], n_65);
  nand g31 (n_87, n_66, n_65);
  nand g5 (n_88, in_2[2], n_66);
  nand g32 (n_49, n_86, n_87, n_88);
  xor g33 (n_89, in_0[3], in_1[3]);
  xor g34 (n_68, n_89, in_3[3]);
  nand g35 (n_90, in_0[3], in_1[3]);
  nand g36 (n_91, in_3[3], in_1[3]);
  nand g37 (n_92, in_0[3], in_3[3]);
  nand g6 (n_69, n_90, n_91, n_92);
  xor g38 (n_93, in_2[3], n_67);
  xor g39 (n_59, n_93, n_68);
  nand g40 (n_94, in_2[3], n_67);
  nand g41 (n_95, n_68, n_67);
  nand g42 (n_96, in_2[3], n_68);
  nand g43 (n_48, n_94, n_95, n_96);
  xor g44 (n_97, in_0[4], in_1[4]);
  xor g45 (n_70, n_97, in_3[4]);
  nand g46 (n_98, in_0[4], in_1[4]);
  nand g47 (n_99, in_3[4], in_1[4]);
  nand g48 (n_100, in_0[4], in_3[4]);
  nand g49 (n_71, n_98, n_99, n_100);
  xor g50 (n_101, in_2[4], n_69);
  xor g51 (n_58, n_101, n_70);
  nand g52 (n_102, in_2[4], n_69);
  nand g53 (n_103, n_70, n_69);
  nand g54 (n_104, in_2[4], n_70);
  nand g55 (n_47, n_102, n_103, n_104);
  xor g56 (n_105, in_0[5], in_1[5]);
  xor g57 (n_72, n_105, in_3[5]);
  nand g58 (n_106, in_0[5], in_1[5]);
  nand g59 (n_107, in_3[5], in_1[5]);
  nand g60 (n_108, in_0[5], in_3[5]);
  nand g61 (n_73, n_106, n_107, n_108);
  xor g62 (n_109, in_2[5], n_71);
  xor g63 (n_57, n_109, n_72);
  nand g64 (n_110, in_2[5], n_71);
  nand g65 (n_111, n_72, n_71);
  nand g66 (n_112, in_2[5], n_72);
  nand g67 (n_46, n_110, n_111, n_112);
  xor g68 (n_113, in_0[6], in_1[6]);
  xor g69 (n_74, n_113, in_3[6]);
  nand g70 (n_114, in_0[6], in_1[6]);
  nand g71 (n_115, in_3[6], in_1[6]);
  nand g72 (n_116, in_0[6], in_3[6]);
  nand g73 (n_75, n_114, n_115, n_116);
  xor g74 (n_117, in_2[6], n_73);
  xor g75 (n_56, n_117, n_74);
  nand g76 (n_118, in_2[6], n_73);
  nand g77 (n_119, n_74, n_73);
  nand g78 (n_120, in_2[6], n_74);
  nand g79 (n_45, n_118, n_119, n_120);
  xor g80 (n_121, in_0[7], in_1[7]);
  xor g81 (n_76, n_121, in_3[7]);
  nand g82 (n_122, in_0[7], in_1[7]);
  nand g83 (n_123, in_3[7], in_1[7]);
  nand g84 (n_124, in_0[7], in_3[7]);
  nand g85 (n_44, n_122, n_123, n_124);
  xor g86 (n_125, in_2[7], n_75);
  xor g87 (n_55, n_125, n_76);
  nand g88 (n_126, in_2[7], n_75);
  nand g89 (n_127, n_76, n_75);
  nand g90 (n_128, in_2[7], n_76);
  nand g91 (n_54, n_126, n_127, n_128);
  nand g92 (n_129, in_1[0], n_62);
  nand g93 (n_130, in_1[0], in_2[0]);
  nand g94 (n_131, n_62, in_2[0]);
  nand g95 (n_133, n_129, n_130, n_131);
  xor g96 (n_132, in_1[0], n_62);
  xor g97 (out_0[0], in_2[0], n_132);
  nand g7 (n_134, n_51, n_61);
  nand g8 (n_135, n_51, n_133);
  nand g9 (n_136, n_61, n_133);
  nand g10 (n_138, n_134, n_135, n_136);
  xor g11 (n_137, n_51, n_61);
  xor g12 (out_0[1], n_133, n_137);
  nand g13 (n_139, n_50, n_60);
  nand g14 (n_140, n_50, n_138);
  nand g15 (n_141, n_60, n_138);
  nand g98 (n_143, n_139, n_140, n_141);
  xor g99 (n_142, n_50, n_60);
  xor g100 (out_0[2], n_138, n_142);
  nand g101 (n_144, n_49, n_59);
  nand g102 (n_145, n_49, n_143);
  nand g103 (n_146, n_59, n_143);
  nand g104 (n_148, n_144, n_145, n_146);
  xor g105 (n_147, n_49, n_59);
  xor g106 (out_0[3], n_143, n_147);
  nand g107 (n_52, n_48, n_58);
  nand g108 (n_149, n_48, n_148);
  nand g109 (n_150, n_58, n_148);
  nand g110 (n_152, n_52, n_149, n_150);
  xor g111 (n_151, n_48, n_58);
  xor g112 (out_0[4], n_148, n_151);
  nand g113 (n_153, n_47, n_57);
  nand g114 (n_154, n_47, n_152);
  nand g115 (n_155, n_57, n_152);
  nand g116 (n_157, n_153, n_154, n_155);
  xor g117 (n_156, n_47, n_57);
  xor g118 (out_0[5], n_152, n_156);
  nand g119 (n_158, n_46, n_56);
  nand g120 (n_63, n_46, n_157);
  nand g121 (n_159, n_56, n_157);
  nand g122 (n_161, n_158, n_63, n_159);
  xor g123 (n_160, n_46, n_56);
  xor g124 (out_0[6], n_157, n_160);
  nand g125 (n_162, n_45, n_55);
  nand g126 (n_163, n_45, n_161);
  nand g127 (n_164, n_55, n_161);
  nand g128 (n_166, n_162, n_163, n_164);
  xor g129 (n_165, n_45, n_55);
  xor g130 (out_0[7], n_161, n_165);
  nand g131 (n_167, n_44, n_54);
  nand g132 (n_168, n_44, n_166);
  nand g133 (n_169, n_54, n_166);
  nand g134 (out_0[9], n_167, n_168, n_169);
  xor g135 (n_170, n_44, n_54);
  xor g136 (out_0[8], n_166, n_170);
endmodule

module csa_tree_add_1256_40_group_25_GENERIC(in_0, in_1, in_2, in_3,
     out_0);
  input [7:0] in_0, in_1, in_2, in_3;
  output [9:0] out_0;
  wire [7:0] in_0, in_1, in_2, in_3;
  wire [9:0] out_0;
  csa_tree_add_1256_40_group_25_GENERIC_REAL g1(.in_0 (in_0), .in_1
       (in_1), .in_2 (in_2), .in_3 (in_3), .out_0 (out_0));
endmodule

