module csa_tree_add_1180_68_group_61_GENERIC_REAL(in_0, in_1, in_2,
     in_3, in_4, in_5, in_6, in_7, out_0);
// synthesis_equation "assign out_0 = ( ( ( ( ( ( ( in_6 + in_7 )  + in_5 )  + in_4 )  + in_3 )  + in_2 )  + in_1 )  + in_0 )  ;"
  input [5:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  output [8:0] out_0;
  wire [5:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  wire [8:0] out_0;
  wire n_59, n_60, n_61, n_62, n_63, n_64, n_65, n_66;
  wire n_68, n_69, n_70, n_71, n_72, n_73, n_74, n_75;
  wire n_76, n_77, n_78, n_79, n_80, n_81, n_82, n_83;
  wire n_84, n_85, n_86, n_87, n_88, n_89, n_90, n_91;
  wire n_92, n_93, n_94, n_95, n_96, n_97, n_98, n_99;
  wire n_100, n_101, n_102, n_103, n_104, n_105, n_106, n_107;
  wire n_108, n_109, n_110, n_111, n_112, n_113, n_114, n_115;
  wire n_116, n_117, n_118, n_119, n_120, n_121, n_122, n_123;
  wire n_124, n_125, n_126, n_127, n_128, n_129, n_130, n_131;
  wire n_132, n_133, n_134, n_135, n_136, n_137, n_138, n_139;
  wire n_140, n_141, n_142, n_143, n_144, n_145, n_146, n_147;
  wire n_148, n_149, n_150, n_151, n_152, n_153, n_154, n_155;
  wire n_156, n_157, n_158, n_159, n_160, n_161, n_162, n_163;
  wire n_164, n_165, n_166, n_167, n_168, n_169, n_170, n_171;
  wire n_172, n_173, n_174, n_175, n_176, n_177, n_178, n_179;
  wire n_180, n_181, n_182, n_183, n_184, n_185, n_186, n_187;
  wire n_188, n_189, n_190, n_191, n_192, n_193, n_194, n_195;
  wire n_196, n_197, n_198, n_199, n_200, n_201, n_202, n_203;
  wire n_204, n_205, n_206, n_207, n_208, n_209, n_210, n_211;
  wire n_212, n_213, n_214, n_215, n_216, n_217, n_218, n_219;
  wire n_220, n_221, n_222, n_223, n_224, n_225, n_226, n_227;
  wire n_228, n_229, n_230, n_231, n_232, n_233, n_234, n_235;
  wire n_236, n_237, n_238, n_239, n_240, n_241, n_242, n_243;
  wire n_244, n_245, n_246, n_247, n_248, n_249, n_250, n_251;
  wire n_252, n_253, n_254, n_255, n_256, n_257, n_258, n_259;
  wire n_260, n_261, n_262, n_263, n_264, n_265, n_266, n_267;
  wire n_268, n_269, n_270, n_271, n_272, n_273, n_274, n_275;
  wire n_276, n_277, n_278, n_279, n_280, n_281, n_282, n_283;
  wire n_284, n_285, n_286, n_287, n_288, n_289, n_290;
  xor g1 (n_76, in_0[0], in_7[0]);
  and g35 (n_77, in_0[0], in_7[0]);
  xor g36 (n_128, in_6[0], in_1[0]);
  xor g2 (n_75, n_128, in_5[0]);
  nand g37 (n_129, in_6[0], in_1[0]);
  nand g38 (n_130, in_5[0], in_1[0]);
  nand g39 (n_131, in_6[0], in_5[0]);
  nand g40 (n_79, n_129, n_130, n_131);
  xor g41 (n_132, in_4[0], in_3[0]);
  xor g42 (n_66, n_132, in_2[0]);
  nand g3 (n_133, in_4[0], in_3[0]);
  nand g43 (n_134, in_2[0], in_3[0]);
  nand g44 (n_135, in_4[0], in_2[0]);
  nand g45 (n_80, n_133, n_134, n_135);
  xor g46 (n_78, in_0[1], in_1[1]);
  and g47 (n_83, in_0[1], in_1[1]);
  xor g48 (n_136, in_3[1], in_7[1]);
  xor g49 (n_81, n_136, in_4[1]);
  nand g50 (n_137, in_3[1], in_7[1]);
  nand g4 (n_138, in_4[1], in_7[1]);
  nand g5 (n_139, in_3[1], in_4[1]);
  nand g51 (n_86, n_137, n_138, n_139);
  xor g52 (n_140, in_2[1], in_5[1]);
  xor g53 (n_82, n_140, in_6[1]);
  nand g54 (n_141, in_2[1], in_5[1]);
  nand g55 (n_142, in_6[1], in_5[1]);
  nand g56 (n_143, in_2[1], in_6[1]);
  nand g6 (n_85, n_141, n_142, n_143);
  xor g57 (n_144, n_77, n_78);
  xor g58 (n_65, n_144, n_79);
  nand g59 (n_145, n_77, n_78);
  nand g60 (n_146, n_79, n_78);
  nand g61 (n_147, n_77, n_79);
  nand g62 (n_90, n_145, n_146, n_147);
  xor g63 (n_148, n_80, n_81);
  xor g64 (n_74, n_148, n_82);
  nand g65 (n_149, n_80, n_81);
  nand g66 (n_150, n_82, n_81);
  nand g67 (n_151, n_80, n_82);
  nand g68 (n_91, n_149, n_150, n_151);
  xor g69 (n_84, in_0[2], in_1[2]);
  and g70 (n_92, in_0[2], in_1[2]);
  xor g71 (n_152, in_3[2], in_7[2]);
  xor g72 (n_87, n_152, in_4[2]);
  nand g73 (n_153, in_3[2], in_7[2]);
  nand g74 (n_154, in_4[2], in_7[2]);
  nand g75 (n_155, in_3[2], in_4[2]);
  nand g76 (n_93, n_153, n_154, n_155);
  xor g77 (n_156, in_2[2], in_5[2]);
  xor g78 (n_88, n_156, in_6[2]);
  nand g79 (n_157, in_2[2], in_5[2]);
  nand g80 (n_158, in_6[2], in_5[2]);
  nand g81 (n_159, in_2[2], in_6[2]);
  nand g82 (n_94, n_157, n_158, n_159);
  xor g83 (n_160, n_83, n_84);
  xor g84 (n_89, n_160, n_85);
  nand g85 (n_161, n_83, n_84);
  nand g86 (n_162, n_85, n_84);
  nand g87 (n_163, n_83, n_85);
  nand g88 (n_98, n_161, n_162, n_163);
  xor g89 (n_164, n_86, n_87);
  xor g90 (n_64, n_164, n_88);
  nand g91 (n_165, n_86, n_87);
  nand g92 (n_166, n_88, n_87);
  nand g93 (n_167, n_86, n_88);
  nand g94 (n_99, n_165, n_166, n_167);
  xor g95 (n_168, n_89, n_90);
  xor g96 (n_73, n_168, n_91);
  nand g97 (n_169, n_89, n_90);
  nand g98 (n_170, n_91, n_90);
  nand g99 (n_171, n_89, n_91);
  nand g100 (n_63, n_169, n_170, n_171);
  xor g101 (n_172, in_0[3], in_1[3]);
  xor g102 (n_95, n_172, in_3[3]);
  nand g103 (n_173, in_0[3], in_1[3]);
  nand g104 (n_174, in_3[3], in_1[3]);
  nand g105 (n_175, in_0[3], in_3[3]);
  nand g106 (n_102, n_173, n_174, n_175);
  xor g107 (n_176, in_7[3], in_4[3]);
  xor g108 (n_96, n_176, in_2[3]);
  nand g109 (n_177, in_7[3], in_4[3]);
  nand g110 (n_178, in_2[3], in_4[3]);
  nand g111 (n_179, in_7[3], in_2[3]);
  nand g112 (n_103, n_177, n_178, n_179);
  xor g113 (n_180, in_5[3], in_6[3]);
  xor g114 (n_97, n_180, n_92);
  nand g115 (n_181, in_5[3], in_6[3]);
  nand g116 (n_182, n_92, in_6[3]);
  nand g117 (n_183, in_5[3], n_92);
  nand g118 (n_106, n_181, n_182, n_183);
  xor g119 (n_184, n_93, n_94);
  xor g120 (n_100, n_184, n_95);
  nand g121 (n_185, n_93, n_94);
  nand g122 (n_186, n_95, n_94);
  nand g123 (n_187, n_93, n_95);
  nand g124 (n_108, n_185, n_186, n_187);
  xor g125 (n_188, n_96, n_97);
  xor g126 (n_101, n_188, n_98);
  nand g127 (n_189, n_96, n_97);
  nand g128 (n_190, n_98, n_97);
  nand g129 (n_191, n_96, n_98);
  nand g130 (n_110, n_189, n_190, n_191);
  xor g131 (n_192, n_99, n_100);
  xor g132 (n_72, n_192, n_101);
  nand g133 (n_193, n_99, n_100);
  nand g134 (n_194, n_101, n_100);
  nand g135 (n_195, n_99, n_101);
  nand g136 (n_62, n_193, n_194, n_195);
  xor g137 (n_196, in_0[4], in_1[4]);
  xor g138 (n_104, n_196, in_3[4]);
  nand g139 (n_197, in_0[4], in_1[4]);
  nand g140 (n_198, in_3[4], in_1[4]);
  nand g141 (n_199, in_0[4], in_3[4]);
  nand g142 (n_112, n_197, n_198, n_199);
  xor g143 (n_200, in_7[4], in_4[4]);
  xor g144 (n_105, n_200, in_2[4]);
  nand g145 (n_201, in_7[4], in_4[4]);
  nand g146 (n_202, in_2[4], in_4[4]);
  nand g147 (n_203, in_7[4], in_2[4]);
  nand g148 (n_113, n_201, n_202, n_203);
  xor g149 (n_204, in_5[4], in_6[4]);
  xor g150 (n_107, n_204, n_102);
  nand g151 (n_205, in_5[4], in_6[4]);
  nand g152 (n_206, n_102, in_6[4]);
  nand g153 (n_207, in_5[4], n_102);
  nand g154 (n_117, n_205, n_206, n_207);
  xor g155 (n_208, n_103, n_104);
  xor g156 (n_109, n_208, n_105);
  nand g157 (n_209, n_103, n_104);
  nand g158 (n_210, n_105, n_104);
  nand g159 (n_211, n_103, n_105);
  nand g160 (n_118, n_209, n_210, n_211);
  xor g161 (n_212, n_106, n_107);
  xor g162 (n_111, n_212, n_108);
  nand g163 (n_213, n_106, n_107);
  nand g164 (n_214, n_108, n_107);
  nand g165 (n_215, n_106, n_108);
  nand g166 (n_121, n_213, n_214, n_215);
  xor g167 (n_216, n_109, n_110);
  xor g168 (n_71, n_216, n_111);
  nand g169 (n_217, n_109, n_110);
  nand g170 (n_218, n_111, n_110);
  nand g171 (n_219, n_109, n_111);
  nand g172 (n_61, n_217, n_218, n_219);
  xor g173 (n_220, in_0[5], in_1[5]);
  xor g174 (n_114, n_220, in_3[5]);
  nand g175 (n_221, in_0[5], in_1[5]);
  nand g176 (n_222, in_3[5], in_1[5]);
  nand g177 (n_223, in_0[5], in_3[5]);
  nand g178 (n_122, n_221, n_222, n_223);
  xor g179 (n_224, in_7[5], in_4[5]);
  xor g180 (n_115, n_224, in_2[5]);
  nand g181 (n_225, in_7[5], in_4[5]);
  nand g182 (n_226, in_2[5], in_4[5]);
  nand g183 (n_227, in_7[5], in_2[5]);
  nand g184 (n_123, n_225, n_226, n_227);
  xor g185 (n_228, in_5[5], in_6[5]);
  xor g186 (n_116, n_228, n_112);
  nand g187 (n_229, in_5[5], in_6[5]);
  nand g188 (n_230, n_112, in_6[5]);
  nand g189 (n_231, in_5[5], n_112);
  nand g190 (n_124, n_229, n_230, n_231);
  xor g191 (n_232, n_113, n_114);
  xor g192 (n_119, n_232, n_115);
  nand g193 (n_233, n_113, n_114);
  nand g194 (n_234, n_115, n_114);
  nand g195 (n_235, n_113, n_115);
  nand g196 (n_125, n_233, n_234, n_235);
  xor g197 (n_236, n_116, n_117);
  xor g198 (n_120, n_236, n_118);
  nand g199 (n_237, n_116, n_117);
  nand g200 (n_238, n_118, n_117);
  nand g201 (n_239, n_116, n_118);
  nand g202 (n_127, n_237, n_238, n_239);
  xor g203 (n_240, n_119, n_120);
  xor g204 (n_70, n_240, n_121);
  nand g205 (n_241, n_119, n_120);
  nand g206 (n_242, n_121, n_120);
  nand g207 (n_243, n_119, n_121);
  nand g208 (n_60, n_241, n_242, n_243);
  xor g209 (n_244, n_122, n_123);
  xor g210 (n_126, n_244, n_124);
  nand g211 (n_245, n_122, n_123);
  nand g212 (n_246, n_124, n_123);
  nand g213 (n_247, n_122, n_124);
  nand g214 (n_59, n_245, n_246, n_247);
  xor g215 (n_248, n_125, n_126);
  xor g216 (n_69, n_248, n_127);
  nand g217 (n_249, n_125, n_126);
  nand g218 (n_250, n_127, n_126);
  nand g219 (n_251, n_125, n_127);
  nand g220 (n_68, n_249, n_250, n_251);
  nand g221 (n_252, n_66, n_75);
  nand g222 (n_253, n_66, n_76);
  nand g223 (n_254, n_75, n_76);
  nand g224 (n_256, n_252, n_253, n_254);
  xor g225 (n_255, n_66, n_75);
  xor g226 (out_0[0], n_76, n_255);
  nand g7 (n_257, n_65, n_74);
  nand g8 (n_258, n_65, n_256);
  nand g9 (n_259, n_74, n_256);
  nand g10 (n_261, n_257, n_258, n_259);
  xor g11 (n_260, n_65, n_74);
  xor g12 (out_0[1], n_256, n_260);
  nand g13 (n_262, n_64, n_73);
  nand g14 (n_263, n_64, n_261);
  nand g15 (n_264, n_73, n_261);
  nand g16 (n_266, n_262, n_263, n_264);
  xor g17 (n_265, n_64, n_73);
  xor g18 (out_0[2], n_261, n_265);
  nand g19 (n_267, n_63, n_72);
  nand g20 (n_268, n_63, n_266);
  nand g21 (n_269, n_72, n_266);
  nand g22 (n_271, n_267, n_268, n_269);
  xor g23 (n_270, n_63, n_72);
  xor g24 (out_0[3], n_266, n_270);
  nand g25 (n_272, n_62, n_71);
  nand g26 (n_273, n_62, n_271);
  nand g27 (n_274, n_71, n_271);
  nand g28 (n_276, n_272, n_273, n_274);
  xor g29 (n_275, n_62, n_71);
  xor g30 (out_0[4], n_271, n_275);
  nand g31 (n_277, n_61, n_70);
  nand g32 (n_278, n_61, n_276);
  nand g33 (n_279, n_70, n_276);
  nand g34 (n_281, n_277, n_278, n_279);
  xor g227 (n_280, n_61, n_70);
  xor g228 (out_0[5], n_276, n_280);
  nand g229 (n_282, n_60, n_69);
  nand g230 (n_283, n_60, n_281);
  nand g231 (n_284, n_69, n_281);
  nand g232 (n_286, n_282, n_283, n_284);
  xor g233 (n_285, n_60, n_69);
  xor g234 (out_0[6], n_281, n_285);
  nand g235 (n_287, n_59, n_68);
  nand g236 (n_288, n_59, n_286);
  nand g237 (n_289, n_68, n_286);
  nand g238 (out_0[8], n_287, n_288, n_289);
  xor g239 (n_290, n_59, n_68);
  xor g240 (out_0[7], n_286, n_290);
endmodule

module csa_tree_add_1180_68_group_61_GENERIC(in_0, in_1, in_2, in_3,
     in_4, in_5, in_6, in_7, out_0);
  input [5:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  output [8:0] out_0;
  wire [5:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  wire [8:0] out_0;
  csa_tree_add_1180_68_group_61_GENERIC_REAL g1(.in_0 (in_0), .in_1
       (in_1), .in_2 (in_2), .in_3 (in_3), .in_4 (in_4), .in_5 (in_5),
       .in_6 (in_6), .in_7 (in_7), .out_0 (out_0));
endmodule
