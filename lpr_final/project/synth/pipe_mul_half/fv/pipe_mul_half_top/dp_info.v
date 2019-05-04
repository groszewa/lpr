module csa_tree_add_628_68_group_49_GENERIC_REAL(in_0, in_1, in_2,
     in_3, in_4, in_5, in_6, in_7, out_0);
// synthesis_equation "assign out_0 = ( ( ( ( ( ( ( in_6 + in_7 )  + in_5 )  + in_4 )  + in_3 )  + in_2 )  + in_1 )  + in_0 )  ;"
  input [4:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  output [7:0] out_0;
  wire [4:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  wire [7:0] out_0;
  wire n_50, n_51, n_52, n_53, n_54, n_55, n_56, n_58;
  wire n_59, n_60, n_61, n_62, n_63, n_64, n_65, n_66;
  wire n_67, n_68, n_69, n_70, n_71, n_72, n_73, n_74;
  wire n_75, n_76, n_77, n_78, n_79, n_80, n_81, n_82;
  wire n_83, n_84, n_85, n_86, n_87, n_88, n_89, n_90;
  wire n_91, n_92, n_93, n_94, n_95, n_96, n_97, n_98;
  wire n_99, n_100, n_101, n_102, n_103, n_104, n_105, n_106;
  wire n_107, n_108, n_109, n_110, n_111, n_112, n_113, n_114;
  wire n_115, n_116, n_117, n_118, n_119, n_120, n_121, n_122;
  wire n_123, n_124, n_125, n_126, n_127, n_128, n_129, n_130;
  wire n_131, n_132, n_133, n_134, n_135, n_136, n_137, n_138;
  wire n_139, n_140, n_141, n_142, n_143, n_144, n_145, n_146;
  wire n_147, n_148, n_149, n_150, n_151, n_152, n_153, n_154;
  wire n_155, n_156, n_157, n_158, n_159, n_160, n_161, n_162;
  wire n_163, n_164, n_165, n_166, n_167, n_168, n_169, n_170;
  wire n_171, n_172, n_173, n_174, n_175, n_176, n_177, n_178;
  wire n_179, n_180, n_181, n_182, n_183, n_184, n_185, n_186;
  wire n_187, n_188, n_189, n_190, n_191, n_192, n_193, n_194;
  wire n_195, n_196, n_197, n_198, n_199, n_200, n_201, n_202;
  wire n_203, n_204, n_205, n_206, n_207, n_208, n_209, n_210;
  wire n_211, n_212, n_213, n_214, n_215, n_216, n_217, n_218;
  wire n_219, n_220, n_221, n_222, n_223, n_224, n_225, n_226;
  wire n_227, n_228, n_229, n_230, n_231, n_232, n_233, n_234;
  wire n_235, n_236, n_237, n_238, n_239, n_240;
  xor g1 (n_65, in_0[0], in_7[0]);
  and g29 (n_66, in_0[0], in_7[0]);
  xor g30 (n_107, in_6[0], in_1[0]);
  xor g2 (n_64, n_107, in_5[0]);
  nand g31 (n_108, in_6[0], in_1[0]);
  nand g32 (n_109, in_5[0], in_1[0]);
  nand g33 (n_110, in_6[0], in_5[0]);
  nand g34 (n_68, n_108, n_109, n_110);
  xor g35 (n_111, in_4[0], in_3[0]);
  xor g36 (n_56, n_111, in_2[0]);
  nand g3 (n_112, in_4[0], in_3[0]);
  nand g37 (n_113, in_2[0], in_3[0]);
  nand g38 (n_114, in_4[0], in_2[0]);
  nand g39 (n_69, n_112, n_113, n_114);
  xor g40 (n_67, in_0[1], in_1[1]);
  and g41 (n_72, in_0[1], in_1[1]);
  xor g42 (n_115, in_3[1], in_7[1]);
  xor g43 (n_70, n_115, in_4[1]);
  nand g44 (n_116, in_3[1], in_7[1]);
  nand g4 (n_117, in_4[1], in_7[1]);
  nand g5 (n_118, in_3[1], in_4[1]);
  nand g45 (n_75, n_116, n_117, n_118);
  xor g46 (n_119, in_2[1], in_5[1]);
  xor g47 (n_71, n_119, in_6[1]);
  nand g48 (n_120, in_2[1], in_5[1]);
  nand g49 (n_121, in_6[1], in_5[1]);
  nand g50 (n_122, in_2[1], in_6[1]);
  nand g6 (n_74, n_120, n_121, n_122);
  xor g51 (n_123, n_66, n_67);
  xor g52 (n_55, n_123, n_68);
  nand g53 (n_124, n_66, n_67);
  nand g54 (n_125, n_68, n_67);
  nand g55 (n_126, n_66, n_68);
  nand g56 (n_79, n_124, n_125, n_126);
  xor g57 (n_127, n_69, n_70);
  xor g58 (n_63, n_127, n_71);
  nand g59 (n_128, n_69, n_70);
  nand g60 (n_129, n_71, n_70);
  nand g61 (n_130, n_69, n_71);
  nand g62 (n_80, n_128, n_129, n_130);
  xor g63 (n_73, in_0[2], in_1[2]);
  and g64 (n_81, in_0[2], in_1[2]);
  xor g65 (n_131, in_3[2], in_7[2]);
  xor g66 (n_76, n_131, in_4[2]);
  nand g67 (n_132, in_3[2], in_7[2]);
  nand g68 (n_133, in_4[2], in_7[2]);
  nand g69 (n_134, in_3[2], in_4[2]);
  nand g70 (n_82, n_132, n_133, n_134);
  xor g71 (n_135, in_2[2], in_5[2]);
  xor g72 (n_77, n_135, in_6[2]);
  nand g73 (n_136, in_2[2], in_5[2]);
  nand g74 (n_137, in_6[2], in_5[2]);
  nand g75 (n_138, in_2[2], in_6[2]);
  nand g76 (n_83, n_136, n_137, n_138);
  xor g77 (n_139, n_72, n_73);
  xor g78 (n_78, n_139, n_74);
  nand g79 (n_140, n_72, n_73);
  nand g80 (n_141, n_74, n_73);
  nand g81 (n_142, n_72, n_74);
  nand g82 (n_87, n_140, n_141, n_142);
  xor g83 (n_143, n_75, n_76);
  xor g84 (n_54, n_143, n_77);
  nand g85 (n_144, n_75, n_76);
  nand g86 (n_145, n_77, n_76);
  nand g87 (n_146, n_75, n_77);
  nand g88 (n_88, n_144, n_145, n_146);
  xor g89 (n_147, n_78, n_79);
  xor g90 (n_62, n_147, n_80);
  nand g91 (n_148, n_78, n_79);
  nand g92 (n_149, n_80, n_79);
  nand g93 (n_150, n_78, n_80);
  nand g94 (n_53, n_148, n_149, n_150);
  xor g95 (n_151, in_0[3], in_1[3]);
  xor g96 (n_84, n_151, in_3[3]);
  nand g97 (n_152, in_0[3], in_1[3]);
  nand g98 (n_153, in_3[3], in_1[3]);
  nand g99 (n_154, in_0[3], in_3[3]);
  nand g100 (n_91, n_152, n_153, n_154);
  xor g101 (n_155, in_7[3], in_4[3]);
  xor g102 (n_85, n_155, in_2[3]);
  nand g103 (n_156, in_7[3], in_4[3]);
  nand g104 (n_157, in_2[3], in_4[3]);
  nand g105 (n_158, in_7[3], in_2[3]);
  nand g106 (n_92, n_156, n_157, n_158);
  xor g107 (n_159, in_5[3], in_6[3]);
  xor g108 (n_86, n_159, n_81);
  nand g109 (n_160, in_5[3], in_6[3]);
  nand g110 (n_161, n_81, in_6[3]);
  nand g111 (n_162, in_5[3], n_81);
  nand g112 (n_95, n_160, n_161, n_162);
  xor g113 (n_163, n_82, n_83);
  xor g114 (n_89, n_163, n_84);
  nand g115 (n_164, n_82, n_83);
  nand g116 (n_165, n_84, n_83);
  nand g117 (n_166, n_82, n_84);
  nand g118 (n_97, n_164, n_165, n_166);
  xor g119 (n_167, n_85, n_86);
  xor g120 (n_90, n_167, n_87);
  nand g121 (n_168, n_85, n_86);
  nand g122 (n_169, n_87, n_86);
  nand g123 (n_170, n_85, n_87);
  nand g124 (n_99, n_168, n_169, n_170);
  xor g125 (n_171, n_88, n_89);
  xor g126 (n_61, n_171, n_90);
  nand g127 (n_172, n_88, n_89);
  nand g128 (n_173, n_90, n_89);
  nand g129 (n_174, n_88, n_90);
  nand g130 (n_52, n_172, n_173, n_174);
  xor g131 (n_175, in_0[4], in_1[4]);
  xor g132 (n_93, n_175, in_3[4]);
  nand g133 (n_176, in_0[4], in_1[4]);
  nand g134 (n_177, in_3[4], in_1[4]);
  nand g135 (n_178, in_0[4], in_3[4]);
  nand g136 (n_101, n_176, n_177, n_178);
  xor g137 (n_179, in_7[4], in_4[4]);
  xor g138 (n_94, n_179, in_2[4]);
  nand g139 (n_180, in_7[4], in_4[4]);
  nand g140 (n_181, in_2[4], in_4[4]);
  nand g141 (n_182, in_7[4], in_2[4]);
  nand g142 (n_102, n_180, n_181, n_182);
  xor g143 (n_183, in_5[4], in_6[4]);
  xor g144 (n_96, n_183, n_91);
  nand g145 (n_184, in_5[4], in_6[4]);
  nand g146 (n_185, n_91, in_6[4]);
  nand g147 (n_186, in_5[4], n_91);
  nand g148 (n_103, n_184, n_185, n_186);
  xor g149 (n_187, n_92, n_93);
  xor g150 (n_98, n_187, n_94);
  nand g151 (n_188, n_92, n_93);
  nand g152 (n_189, n_94, n_93);
  nand g153 (n_190, n_92, n_94);
  nand g154 (n_104, n_188, n_189, n_190);
  xor g155 (n_191, n_95, n_96);
  xor g156 (n_100, n_191, n_97);
  nand g157 (n_192, n_95, n_96);
  nand g158 (n_193, n_97, n_96);
  nand g159 (n_194, n_95, n_97);
  nand g160 (n_106, n_192, n_193, n_194);
  xor g161 (n_195, n_98, n_99);
  xor g162 (n_60, n_195, n_100);
  nand g163 (n_196, n_98, n_99);
  nand g164 (n_197, n_100, n_99);
  nand g165 (n_198, n_98, n_100);
  nand g166 (n_51, n_196, n_197, n_198);
  xor g167 (n_199, n_101, n_102);
  xor g168 (n_105, n_199, n_103);
  nand g169 (n_200, n_101, n_102);
  nand g170 (n_201, n_103, n_102);
  nand g171 (n_202, n_101, n_103);
  nand g172 (n_50, n_200, n_201, n_202);
  xor g173 (n_203, n_104, n_105);
  xor g174 (n_59, n_203, n_106);
  nand g175 (n_204, n_104, n_105);
  nand g176 (n_205, n_106, n_105);
  nand g177 (n_206, n_104, n_106);
  nand g178 (n_58, n_204, n_205, n_206);
  nand g179 (n_207, n_56, n_64);
  nand g180 (n_208, n_56, n_65);
  nand g181 (n_209, n_64, n_65);
  nand g182 (n_211, n_207, n_208, n_209);
  xor g183 (n_210, n_56, n_64);
  xor g184 (out_0[0], n_65, n_210);
  nand g7 (n_212, n_55, n_63);
  nand g8 (n_213, n_55, n_211);
  nand g9 (n_214, n_63, n_211);
  nand g10 (n_216, n_212, n_213, n_214);
  xor g11 (n_215, n_55, n_63);
  xor g12 (out_0[1], n_211, n_215);
  nand g13 (n_217, n_54, n_62);
  nand g14 (n_218, n_54, n_216);
  nand g15 (n_219, n_62, n_216);
  nand g16 (n_221, n_217, n_218, n_219);
  xor g17 (n_220, n_54, n_62);
  xor g18 (out_0[2], n_216, n_220);
  nand g19 (n_222, n_53, n_61);
  nand g20 (n_223, n_53, n_221);
  nand g21 (n_224, n_61, n_221);
  nand g22 (n_226, n_222, n_223, n_224);
  xor g23 (n_225, n_53, n_61);
  xor g24 (out_0[3], n_221, n_225);
  nand g25 (n_227, n_52, n_60);
  nand g26 (n_228, n_52, n_226);
  nand g27 (n_229, n_60, n_226);
  nand g28 (n_231, n_227, n_228, n_229);
  xor g185 (n_230, n_52, n_60);
  xor g186 (out_0[4], n_226, n_230);
  nand g187 (n_232, n_51, n_59);
  nand g188 (n_233, n_51, n_231);
  nand g189 (n_234, n_59, n_231);
  nand g190 (n_236, n_232, n_233, n_234);
  xor g191 (n_235, n_51, n_59);
  xor g192 (out_0[5], n_231, n_235);
  nand g193 (n_237, n_50, n_58);
  nand g194 (n_238, n_50, n_236);
  nand g195 (n_239, n_58, n_236);
  nand g196 (out_0[7], n_237, n_238, n_239);
  xor g197 (n_240, n_50, n_58);
  xor g198 (out_0[6], n_236, n_240);
endmodule

module csa_tree_add_628_68_group_49_GENERIC(in_0, in_1, in_2, in_3,
     in_4, in_5, in_6, in_7, out_0);
  input [4:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  output [7:0] out_0;
  wire [4:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  wire [7:0] out_0;
  csa_tree_add_628_68_group_49_GENERIC_REAL g1(.in_0 (in_0), .in_1
       (in_1), .in_2 (in_2), .in_3 (in_3), .in_4 (in_4), .in_5 (in_5),
       .in_6 (in_6), .in_7 (in_7), .out_0 (out_0));
endmodule
