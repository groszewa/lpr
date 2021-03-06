module csa_tree_add_433_129_group_97_GENERIC_REAL(in_0, in_1, in_2,
     in_3, in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12,
     in_13, in_14, in_15, out_0);
// synthesis_equation "assign out_0 = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( in_14 + in_15 )  + in_13 )  + in_12 )  + in_11 )  + in_10 )  + in_9 )  + in_8 )  + in_7 )  + in_6 )  + in_5 )  + in_4 )  + in_3 )  + in_2 )  + in_1 )  + in_0 )  ;"
  input [3:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8,
       in_9, in_10, in_11, in_12, in_13, in_14, in_15;
  output [7:0] out_0;
  wire [3:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8,
       in_9, in_10, in_11, in_12, in_13, in_14, in_15;
  wire [7:0] out_0;
  wire n_74, n_75, n_76, n_77, n_78, n_79, n_80, n_82;
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
  wire n_235, n_236, n_237, n_238, n_239, n_240, n_241, n_242;
  wire n_243, n_244, n_245, n_246, n_247, n_248, n_249, n_250;
  wire n_251, n_252, n_253, n_254, n_255, n_256, n_257, n_258;
  wire n_259, n_260, n_261, n_262, n_263, n_264, n_265, n_266;
  wire n_267, n_268, n_269, n_270, n_271, n_272, n_273, n_274;
  wire n_275, n_276, n_277, n_278, n_279, n_280, n_281, n_282;
  wire n_283, n_284, n_285, n_286, n_287, n_288, n_289, n_290;
  wire n_291, n_292, n_293, n_294, n_295, n_296, n_297, n_298;
  wire n_299, n_300, n_301, n_302, n_303, n_304, n_305, n_306;
  wire n_307, n_308, n_309, n_310, n_311, n_312, n_313, n_314;
  wire n_315, n_316, n_317, n_318, n_319, n_320, n_321, n_322;
  wire n_323, n_324, n_325, n_326, n_327, n_328, n_329, n_330;
  wire n_331, n_332, n_333, n_334, n_335, n_336, n_337, n_338;
  wire n_339, n_340, n_341, n_342, n_343, n_344, n_345, n_346;
  wire n_347, n_348, n_349, n_350, n_351, n_352, n_353, n_354;
  wire n_355, n_356, n_357, n_358, n_359, n_360, n_361, n_362;
  wire n_363, n_364, n_365, n_366, n_367, n_368, n_369, n_370;
  wire n_371, n_372, n_373, n_374, n_375, n_376, n_377, n_378;
  wire n_379, n_380, n_381, n_382, n_383, n_384, n_385, n_386;
  wire n_387, n_388, n_389, n_390, n_391, n_392, n_393, n_394;
  wire n_395, n_396, n_397, n_398, n_399, n_400, n_401, n_402;
  wire n_403, n_404, n_405, n_406, n_407, n_408, n_409, n_410;
  xor g1 (n_90, in_0[0], in_15[0]);
  and g54 (n_94, in_0[0], in_15[0]);
  xor g55 (n_181, in_14[0], in_1[0]);
  xor g2 (n_91, n_181, in_13[0]);
  nand g56 (n_182, in_14[0], in_1[0]);
  nand g57 (n_183, in_13[0], in_1[0]);
  nand g58 (n_184, in_14[0], in_13[0]);
  nand g59 (n_97, n_182, n_183, n_184);
  xor g60 (n_185, in_12[0], in_3[0]);
  xor g61 (n_92, n_185, in_11[0]);
  nand g3 (n_186, in_12[0], in_3[0]);
  nand g62 (n_187, in_11[0], in_3[0]);
  nand g63 (n_188, in_12[0], in_11[0]);
  nand g64 (n_98, n_186, n_187, n_188);
  xor g65 (n_189, in_10[0], in_7[0]);
  xor g66 (n_93, n_189, in_9[0]);
  nand g67 (n_190, in_10[0], in_7[0]);
  nand g4 (n_191, in_9[0], in_7[0]);
  nand g68 (n_192, in_10[0], in_9[0]);
  nand g69 (n_99, n_190, n_191, n_192);
  xor g70 (n_193, in_8[0], in_4[0]);
  xor g71 (n_89, n_193, in_2[0]);
  nand g72 (n_194, in_8[0], in_4[0]);
  nand g73 (n_195, in_2[0], in_4[0]);
  nand g5 (n_196, in_8[0], in_2[0]);
  nand g74 (n_96, n_194, n_195, n_196);
  xor g75 (n_197, in_6[0], in_5[0]);
  xor g76 (n_80, n_197, n_90);
  nand g77 (n_198, in_6[0], in_5[0]);
  nand g78 (n_199, n_90, in_5[0]);
  nand g79 (n_200, in_6[0], n_90);
  nand g6 (n_105, n_198, n_199, n_200);
  xor g80 (n_201, n_91, n_92);
  xor g81 (n_88, n_201, n_93);
  nand g82 (n_202, n_91, n_92);
  nand g83 (n_203, n_93, n_92);
  nand g84 (n_204, n_91, n_93);
  nand g85 (n_107, n_202, n_203, n_204);
  xor g86 (n_95, in_0[1], in_1[1]);
  and g87 (n_110, in_0[1], in_1[1]);
  xor g88 (n_205, in_3[1], in_7[1]);
  xor g89 (n_100, n_205, in_15[1]);
  nand g90 (n_206, in_3[1], in_7[1]);
  nand g91 (n_207, in_15[1], in_7[1]);
  nand g92 (n_208, in_3[1], in_15[1]);
  nand g93 (n_112, n_206, n_207, n_208);
  xor g94 (n_209, in_8[1], in_4[1]);
  xor g95 (n_102, n_209, in_9[1]);
  nand g96 (n_210, in_8[1], in_4[1]);
  nand g97 (n_211, in_9[1], in_4[1]);
  nand g98 (n_212, in_8[1], in_9[1]);
  nand g99 (n_115, n_210, n_211, n_212);
  xor g100 (n_213, in_10[1], in_2[1]);
  xor g101 (n_103, n_213, in_5[1]);
  nand g102 (n_214, in_10[1], in_2[1]);
  nand g103 (n_215, in_5[1], in_2[1]);
  nand g104 (n_216, in_10[1], in_5[1]);
  nand g105 (n_113, n_214, n_215, n_216);
  xor g106 (n_217, in_11[1], in_12[1]);
  xor g107 (n_101, n_217, in_14[1]);
  nand g108 (n_218, in_11[1], in_12[1]);
  nand g109 (n_219, in_14[1], in_12[1]);
  nand g110 (n_220, in_11[1], in_14[1]);
  nand g111 (n_114, n_218, n_219, n_220);
  xor g112 (n_221, in_6[1], in_13[1]);
  xor g113 (n_104, n_221, n_94);
  nand g114 (n_222, in_6[1], in_13[1]);
  nand g115 (n_223, n_94, in_13[1]);
  nand g116 (n_224, in_6[1], n_94);
  nand g117 (n_121, n_222, n_223, n_224);
  xor g118 (n_225, n_95, n_96);
  xor g119 (n_106, n_225, n_97);
  nand g120 (n_226, n_95, n_96);
  nand g121 (n_227, n_97, n_96);
  nand g122 (n_228, n_95, n_97);
  nand g123 (n_122, n_226, n_227, n_228);
  xor g124 (n_229, n_98, n_99);
  xor g125 (n_108, n_229, n_100);
  nand g126 (n_230, n_98, n_99);
  nand g127 (n_231, n_100, n_99);
  nand g128 (n_232, n_98, n_100);
  nand g129 (n_123, n_230, n_231, n_232);
  xor g130 (n_233, n_101, n_102);
  xor g131 (n_109, n_233, n_103);
  nand g132 (n_234, n_101, n_102);
  nand g133 (n_235, n_103, n_102);
  nand g134 (n_236, n_101, n_103);
  nand g135 (n_124, n_234, n_235, n_236);
  xor g136 (n_237, n_104, n_105);
  xor g137 (n_79, n_237, n_106);
  nand g138 (n_238, n_104, n_105);
  nand g139 (n_239, n_106, n_105);
  nand g140 (n_240, n_104, n_106);
  nand g141 (n_129, n_238, n_239, n_240);
  xor g142 (n_241, n_107, n_108);
  xor g143 (n_87, n_241, n_109);
  nand g144 (n_242, n_107, n_108);
  nand g145 (n_243, n_109, n_108);
  nand g146 (n_244, n_107, n_109);
  nand g147 (n_130, n_242, n_243, n_244);
  xor g148 (n_111, in_0[2], in_1[2]);
  and g149 (n_132, in_0[2], in_1[2]);
  xor g150 (n_245, in_3[2], in_7[2]);
  xor g151 (n_117, n_245, in_15[2]);
  nand g152 (n_246, in_3[2], in_7[2]);
  nand g153 (n_247, in_15[2], in_7[2]);
  nand g154 (n_248, in_3[2], in_15[2]);
  nand g155 (n_135, n_246, n_247, n_248);
  xor g156 (n_249, in_8[2], in_4[2]);
  xor g157 (n_118, n_249, in_9[2]);
  nand g158 (n_250, in_8[2], in_4[2]);
  nand g159 (n_251, in_9[2], in_4[2]);
  nand g160 (n_252, in_8[2], in_9[2]);
  nand g161 (n_134, n_250, n_251, n_252);
  xor g162 (n_253, in_10[2], in_2[2]);
  xor g163 (n_116, n_253, in_5[2]);
  nand g164 (n_254, in_10[2], in_2[2]);
  nand g165 (n_255, in_5[2], in_2[2]);
  nand g166 (n_256, in_10[2], in_5[2]);
  nand g167 (n_136, n_254, n_255, n_256);
  xor g168 (n_257, in_11[2], in_12[2]);
  xor g169 (n_119, n_257, in_6[2]);
  nand g170 (n_258, in_11[2], in_12[2]);
  nand g171 (n_259, in_6[2], in_12[2]);
  nand g172 (n_260, in_11[2], in_6[2]);
  nand g173 (n_137, n_258, n_259, n_260);
  xor g174 (n_261, in_13[2], in_14[2]);
  xor g175 (n_120, n_261, n_110);
  nand g176 (n_262, in_13[2], in_14[2]);
  nand g177 (n_263, n_110, in_14[2]);
  nand g178 (n_264, in_13[2], n_110);
  nand g179 (n_143, n_262, n_263, n_264);
  xor g180 (n_265, n_111, n_112);
  xor g181 (n_126, n_265, n_113);
  nand g182 (n_266, n_111, n_112);
  nand g183 (n_267, n_113, n_112);
  nand g184 (n_268, n_111, n_113);
  nand g185 (n_144, n_266, n_267, n_268);
  xor g186 (n_269, n_114, n_115);
  xor g187 (n_125, n_269, n_116);
  nand g188 (n_270, n_114, n_115);
  nand g189 (n_271, n_116, n_115);
  nand g190 (n_272, n_114, n_116);
  nand g191 (n_147, n_270, n_271, n_272);
  xor g192 (n_273, n_117, n_118);
  xor g193 (n_127, n_273, n_119);
  nand g194 (n_274, n_117, n_118);
  nand g195 (n_275, n_119, n_118);
  nand g196 (n_276, n_117, n_119);
  nand g197 (n_145, n_274, n_275, n_276);
  xor g198 (n_277, n_120, n_121);
  xor g199 (n_128, n_277, n_122);
  nand g200 (n_278, n_120, n_121);
  nand g201 (n_279, n_122, n_121);
  nand g202 (n_280, n_120, n_122);
  nand g203 (n_150, n_278, n_279, n_280);
  xor g204 (n_281, n_123, n_124);
  xor g205 (n_131, n_281, n_125);
  nand g206 (n_282, n_123, n_124);
  nand g207 (n_283, n_125, n_124);
  nand g208 (n_284, n_123, n_125);
  nand g209 (n_152, n_282, n_283, n_284);
  xor g210 (n_285, n_126, n_127);
  xor g211 (n_78, n_285, n_128);
  nand g212 (n_286, n_126, n_127);
  nand g213 (n_287, n_128, n_127);
  nand g214 (n_288, n_126, n_128);
  nand g215 (n_154, n_286, n_287, n_288);
  xor g216 (n_289, n_129, n_130);
  xor g217 (n_86, n_289, n_131);
  nand g218 (n_290, n_129, n_130);
  nand g219 (n_291, n_131, n_130);
  nand g220 (n_292, n_129, n_131);
  nand g221 (n_156, n_290, n_291, n_292);
  xor g222 (n_133, in_0[3], in_1[3]);
  and g223 (n_157, in_0[3], in_1[3]);
  xor g224 (n_293, in_3[3], in_7[3]);
  xor g225 (n_138, n_293, in_15[3]);
  nand g226 (n_294, in_3[3], in_7[3]);
  nand g227 (n_295, in_15[3], in_7[3]);
  nand g228 (n_296, in_3[3], in_15[3]);
  nand g229 (n_158, n_294, n_295, n_296);
  xor g230 (n_297, in_8[3], in_4[3]);
  xor g231 (n_140, n_297, in_9[3]);
  nand g232 (n_298, in_8[3], in_4[3]);
  nand g233 (n_299, in_9[3], in_4[3]);
  nand g234 (n_300, in_8[3], in_9[3]);
  nand g235 (n_161, n_298, n_299, n_300);
  xor g236 (n_301, in_10[3], in_2[3]);
  xor g237 (n_141, n_301, in_5[3]);
  nand g238 (n_302, in_10[3], in_2[3]);
  nand g239 (n_303, in_5[3], in_2[3]);
  nand g240 (n_304, in_10[3], in_5[3]);
  nand g241 (n_159, n_302, n_303, n_304);
  xor g242 (n_305, in_11[3], in_12[3]);
  xor g243 (n_139, n_305, in_6[3]);
  nand g244 (n_306, in_11[3], in_12[3]);
  nand g245 (n_307, in_6[3], in_12[3]);
  nand g246 (n_308, in_11[3], in_6[3]);
  nand g247 (n_160, n_306, n_307, n_308);
  xor g248 (n_309, in_13[3], in_14[3]);
  xor g249 (n_142, n_309, n_132);
  nand g250 (n_310, in_13[3], in_14[3]);
  nand g251 (n_311, n_132, in_14[3]);
  nand g252 (n_312, in_13[3], n_132);
  nand g253 (n_162, n_310, n_311, n_312);
  xor g254 (n_313, n_133, n_134);
  xor g255 (n_146, n_313, n_135);
  nand g256 (n_314, n_133, n_134);
  nand g257 (n_315, n_135, n_134);
  nand g258 (n_316, n_133, n_135);
  nand g259 (n_163, n_314, n_315, n_316);
  xor g260 (n_317, n_136, n_137);
  xor g261 (n_148, n_317, n_138);
  nand g262 (n_318, n_136, n_137);
  nand g263 (n_319, n_138, n_137);
  nand g264 (n_320, n_136, n_138);
  nand g265 (n_164, n_318, n_319, n_320);
  xor g266 (n_321, n_139, n_140);
  xor g267 (n_149, n_321, n_141);
  nand g268 (n_322, n_139, n_140);
  nand g269 (n_323, n_141, n_140);
  nand g270 (n_324, n_139, n_141);
  nand g271 (n_165, n_322, n_323, n_324);
  xor g272 (n_325, n_142, n_143);
  xor g273 (n_151, n_325, n_144);
  nand g274 (n_326, n_142, n_143);
  nand g275 (n_327, n_144, n_143);
  nand g276 (n_328, n_142, n_144);
  nand g277 (n_168, n_326, n_327, n_328);
  xor g278 (n_329, n_145, n_146);
  xor g279 (n_153, n_329, n_147);
  nand g280 (n_330, n_145, n_146);
  nand g281 (n_331, n_147, n_146);
  nand g282 (n_332, n_145, n_147);
  nand g283 (n_169, n_330, n_331, n_332);
  xor g284 (n_333, n_148, n_149);
  xor g285 (n_155, n_333, n_150);
  nand g286 (n_334, n_148, n_149);
  nand g287 (n_335, n_150, n_149);
  nand g288 (n_336, n_148, n_150);
  nand g289 (n_171, n_334, n_335, n_336);
  xor g290 (n_337, n_151, n_152);
  xor g291 (n_77, n_337, n_153);
  nand g292 (n_338, n_151, n_152);
  nand g293 (n_339, n_153, n_152);
  nand g294 (n_340, n_151, n_153);
  nand g295 (n_173, n_338, n_339, n_340);
  xor g296 (n_341, n_154, n_155);
  xor g297 (n_85, n_341, n_156);
  nand g298 (n_342, n_154, n_155);
  nand g299 (n_343, n_156, n_155);
  nand g300 (n_344, n_154, n_156);
  nand g301 (n_76, n_342, n_343, n_344);
  xor g302 (n_345, n_157, n_158);
  xor g303 (n_166, n_345, n_159);
  nand g304 (n_346, n_157, n_158);
  nand g305 (n_347, n_159, n_158);
  nand g306 (n_348, n_157, n_159);
  nand g307 (n_175, n_346, n_347, n_348);
  xor g308 (n_349, n_160, n_161);
  xor g309 (n_167, n_349, n_162);
  nand g310 (n_350, n_160, n_161);
  nand g311 (n_351, n_162, n_161);
  nand g312 (n_352, n_160, n_162);
  nand g313 (n_176, n_350, n_351, n_352);
  xor g314 (n_353, n_163, n_164);
  xor g315 (n_170, n_353, n_165);
  nand g316 (n_354, n_163, n_164);
  nand g317 (n_355, n_165, n_164);
  nand g318 (n_356, n_163, n_165);
  nand g319 (n_177, n_354, n_355, n_356);
  xor g320 (n_357, n_166, n_167);
  xor g321 (n_172, n_357, n_168);
  nand g322 (n_358, n_166, n_167);
  nand g323 (n_359, n_168, n_167);
  nand g324 (n_360, n_166, n_168);
  nand g325 (n_178, n_358, n_359, n_360);
  xor g326 (n_361, n_169, n_170);
  xor g327 (n_174, n_361, n_171);
  nand g328 (n_362, n_169, n_170);
  nand g329 (n_363, n_171, n_170);
  nand g330 (n_364, n_169, n_171);
  nand g331 (n_180, n_362, n_363, n_364);
  xor g332 (n_365, n_172, n_173);
  xor g333 (n_84, n_365, n_174);
  nand g334 (n_366, n_172, n_173);
  nand g335 (n_367, n_174, n_173);
  nand g336 (n_368, n_172, n_174);
  nand g337 (n_75, n_366, n_367, n_368);
  xor g338 (n_369, n_175, n_176);
  xor g339 (n_179, n_369, n_177);
  nand g340 (n_370, n_175, n_176);
  nand g341 (n_371, n_177, n_176);
  nand g342 (n_372, n_175, n_177);
  nand g343 (n_74, n_370, n_371, n_372);
  xor g344 (n_373, n_178, n_179);
  xor g345 (n_83, n_373, n_180);
  nand g346 (n_374, n_178, n_179);
  nand g347 (n_375, n_180, n_179);
  nand g348 (n_376, n_178, n_180);
  nand g349 (n_82, n_374, n_375, n_376);
  nand g350 (n_377, n_80, n_88);
  nand g351 (n_378, n_80, n_89);
  nand g352 (n_379, n_88, n_89);
  nand g353 (n_381, n_377, n_378, n_379);
  xor g354 (n_380, n_80, n_88);
  xor g355 (out_0[0], n_89, n_380);
  nand g7 (n_382, n_79, n_87);
  nand g8 (n_383, n_79, n_381);
  nand g9 (n_384, n_87, n_381);
  nand g10 (n_386, n_382, n_383, n_384);
  xor g11 (n_385, n_79, n_87);
  xor g12 (out_0[1], n_381, n_385);
  nand g13 (n_387, n_78, n_86);
  nand g14 (n_388, n_78, n_386);
  nand g15 (n_389, n_86, n_386);
  nand g16 (n_391, n_387, n_388, n_389);
  xor g17 (n_390, n_78, n_86);
  xor g18 (out_0[2], n_386, n_390);
  nand g19 (n_392, n_77, n_85);
  nand g20 (n_393, n_77, n_391);
  nand g21 (n_394, n_85, n_391);
  nand g22 (n_396, n_392, n_393, n_394);
  xor g23 (n_395, n_77, n_85);
  xor g24 (out_0[3], n_391, n_395);
  nand g25 (n_397, n_76, n_84);
  nand g26 (n_398, n_76, n_396);
  nand g27 (n_399, n_84, n_396);
  nand g28 (n_401, n_397, n_398, n_399);
  xor g29 (n_400, n_76, n_84);
  xor g30 (out_0[4], n_396, n_400);
  nand g31 (n_402, n_75, n_83);
  nand g32 (n_403, n_75, n_401);
  nand g33 (n_404, n_83, n_401);
  nand g34 (n_406, n_402, n_403, n_404);
  xor g35 (n_405, n_75, n_83);
  xor g36 (out_0[5], n_401, n_405);
  nand g37 (n_407, n_74, n_82);
  nand g38 (n_408, n_74, n_406);
  nand g39 (n_409, n_82, n_406);
  nand g40 (out_0[7], n_407, n_408, n_409);
  xor g41 (n_410, n_74, n_82);
  xor g42 (out_0[6], n_406, n_410);
endmodule

module csa_tree_add_433_129_group_97_GENERIC(in_0, in_1, in_2, in_3,
     in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12, in_13,
     in_14, in_15, out_0);
  input [3:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8,
       in_9, in_10, in_11, in_12, in_13, in_14, in_15;
  output [7:0] out_0;
  wire [3:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8,
       in_9, in_10, in_11, in_12, in_13, in_14, in_15;
  wire [7:0] out_0;
  csa_tree_add_433_129_group_97_GENERIC_REAL g1(.in_0 (in_0), .in_1
       (in_1), .in_2 (in_2), .in_3 (in_3), .in_4 (in_4), .in_5 (in_5),
       .in_6 (in_6), .in_7 (in_7), .in_8 (in_8), .in_9 (in_9), .in_10
       (in_10), .in_11 (in_11), .in_12 (in_12), .in_13 (in_13), .in_14
       (in_14), .in_15 (in_15), .out_0 (out_0));
endmodule

