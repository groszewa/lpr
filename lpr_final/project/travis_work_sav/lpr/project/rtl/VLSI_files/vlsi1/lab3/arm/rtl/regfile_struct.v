//
// regfile_struct.v
//
// David Van Campenhout
//
// structural elements of regfile
//

`define group_regfile 	"group_regfile"
`define group_mode		"group_mode"
`define group_mask		"group_mask"
`define group_stat		"group_stat"
`define group_pc		"group_pc"
`define dptype 		1
`define stdcelltype 	0

module 
regfile_struct( phi1, phi2, clear, test, scanin, scanout,
			W, INCin, MODEin, MASKin, CONDin, 
			mrA, mrB, mwA, 
			sel_A, sel_B, sel_stat, sel_mask, sel_inc, sel_mode, 
			en_regfile, en_IRQ13, en_SVC13, 
			en_stat, en_mask, en_pcAddr, en_mode,
			A, B, PCaddr, MODEout, MASKout, CONDout);

  input		phi1;
  input		phi2;	// clock used for writing
  input		clear;
  input		test;
  input		scanin;
  output		scanout;

  input [31:0]	W;		// general write port
  input [25:0]	INCin;	// write port to PC for incremented address reg
  input [1:0]	MODEin;	// write port to MODE part of PC
  input [1:0]	MASKin; 	// write port to interrupt mask part of PC
  input [3:0]	CONDin; 	// write port to datapath  flags

  input [4:0]	mrA;		// mapped rA
  input [4:0]	mrB;		// mapped rB
  input [4:0]	mwA;		// mapped wA

  input [1:0]	sel_A;
  input [1:0]	sel_B;
  input		sel_stat;
  input		sel_mask;
  input		sel_inc;
  input		sel_mode;

  input		en_regfile;
  input		en_IRQ13;
  input		en_SVC13;
  input		en_stat;
  input		en_mask;
  input		en_pcAddr;
  input		en_mode;

  output [31:0]	A;	// read port A
  output [31:0]	B;	// read port A
  output [25:0]	PCaddr; // { PC[25:0], 2'b0 }
  output [1:0]	MODEout;// MODE read port
  output [1:0]	MASKout;// interrupt mask read port
  output [3:0]	CONDout;// datapath status read port
 
  wire [31:0]	Aport;
  wire [31:0]	Bport;
  wire [31:0]	regfile_A;
  wire [31:0]	regfile_B;
  wire [31:0]	IRQ13_D;
  wire [31:0]	IRQ13_Q;
  wire [31:0]	SVC13_D;
  wire [31:0]	SVC13_Q;
  wire [3:0]	stat_D;
  wire [3:0]	stat_Q;
  wire [1:0]	mask_D;
  wire [1:0]	mask_Q;
  wire [1:0]	mask_Q_unbuf;
  wire [1:0]	mode_D;
  wire [1:0]	mode_Q;
  wire [1:0]	mode_Q_unbuf;
  wire [23:0]	pcAddr_D;
  wire [23:0]	pcAddr_Q;

//  wire		clear_bar;
  wire		sel_inc_bar;

  wire		clk_mask;
  wire		clk_mode;
  wire		clk_stat;


  wire		en_regfile_phi2_unbuf;
  wire		en_regfile_phi2;	// enables anded with phi2
  wire		en_IRQ13_phi2;
  wire		en_SVC13_phi2;
  wire		en_mode_phi2;
  wire		en_stat_phi2;
  wire		en_mask_phi2;
  wire		en_pcAddr_phi2;

  wire		scanin;			//  to be connected later

  assign	PCaddr = {pcAddr_Q, 2'b0};
  assign	MASKout = mask_Q;
  assign	MODEout = mode_Q;
  assign	CONDout = stat_Q;
  assign	A = Aport;
  assign 	B = Bport;


  supply1	Vdd;

//  stdinv inv_clear( .IN0(clear), .Y(clear_bar));

  stdand2 
	and_en_regfile	( .IN0(phi2), .IN1(en_regfile), .Y(en_regfile_phi2_unbuf));
  stdbuf
  	buf_en_regfile_phi2( .IN0( en_regfile_phi2_unbuf), .Y(en_regfile_phi2));
  stdand2 
	and_en_IRQ13	( .IN0(phi2), .IN1(en_IRQ13), .Y(en_IRQ13_phi2));
  stdand2 
	and_en_SVC13	( .IN0(phi2), .IN1(en_SVC13), .Y(en_SVC13_phi2));


/***********************************************************************
  stdand2 
	and_en_stat	( .IN0(phi2), .IN1(en_stat), .Y(en_stat_phi2));
  stdand2 
	and_en_mask	( .IN0(phi2), .IN1(en_mask), .Y(en_mask_phi2));
  stdand2 
	and_en_mode	( .IN0(phi2), .IN1(en_mode), .Y(en_mode_phi2));

***********************************************************************/
  stdand2 
	and_en_pcAddr	( .IN0(phi2), .IN1(en_pcAddr), .Y(en_pcAddr_phi2));

  stdlatch_c  
    latch_clk_stat( .EN(phi2), .D(en_stat), .Q(en_stat_phi2), .CLR(clear));

  stdlatch_c  
    latch_clk_mode( .EN(phi2), .D(en_mode), .Q(en_mode_phi2), .CLR(clear));

  stdlatch_c  
    latch_clk_mask( .EN(phi2), .D(en_mask), .Q(en_mask_phi2), .CLR(clear));

  stdand2 
	and_clk_stat	( .IN0(phi2), .IN1(en_stat_phi2), .Y(clk_stat));
  stdand2 
	and_clk_mask	( .IN0(phi1), .IN1(en_mask_phi2), .Y(clk_mask));
  stdand2 
	and_clk_mode	( .IN0(phi1), .IN1(en_mode_phi2), .Y(clk_mode));

  regfile2r    #(32, 24, 5, `group_regfile)
    regfile(	.IN0(W), .R1(mrA), .R2(mrB), .RE1(Vdd), .RE2(Vdd), 
		.W(mwA), .WE(en_regfile_phi2), 
		.OUT1(regfile_A), .OUT2(regfile_B));

  latch_c    #(32, `dptype, `group_regfile)
    IRQ13( .D(W), .EN(en_IRQ13_phi2), .Q(IRQ13_Q), .CLR(clear));

  latch_c    #(32, `dptype, `group_regfile)
    SVC13( .D(W), .EN(en_SVC13_phi2), .Q(SVC13_Q), .CLR(clear));
  

  dff_c #(4, `stdcelltype, `group_stat)
    stat( .CLK(clk_stat), .D(stat_D), .Q(stat_Q), .CLR(clear));

  dff_c   #(2, `stdcelltype, `group_mask)
    mask( .CLK(clk_mask), .D(mask_D), .Q(mask_Q_unbuf), .CLR(clear));

  buff 	#(2, `stdcelltype, `group_mask)
	buf_mask( .IN0( mask_Q_unbuf), .Y( mask_Q));

  dff_c   #(2, `stdcelltype, `group_mode)
    mode( .CLK(clk_mode), .D(mode_D), .Q(mode_Q_unbuf), .CLR(clear));

  buff 	#(2, `stdcelltype, `group_mode)
	buf_mode( .IN0( mode_Q_unbuf), .Y( mode_Q));


/**********************************************************************
  latch_c   #(4, `dptype, `group_stat)
    stat( .EN(en_stat_phi2), .D(stat_D), .Q(stat_Q), .CLR(clear_bar));
  
  latch_c   #(2, `dptype, `group_mask)
    mask( .EN(en_mask_phi2), .D(mask_D), .Q(mask_Q_unbuf), .CLR(clear_bar));

  buff 	#(2, `dptype, `group_mask)
	buf_mask( .IN0( mask_Q_unbuf), .Y( mask_Q));


  latch_c   #(2, `dptype, `group_mode)
    mode( .EN(en_mode_phi2), .D(mode_D), .Q(mode_Q_unbuf), .CLR(clear_bar));

  buff 	#(2, `dptype, `group_mode)
	buf_mode( .IN0( mode_Q_unbuf), .Y( mode_Q));
**********************************************************************/


  latch_c    #(24, `dptype, `group_pc)
    pcAddr( .EN(en_pcAddr_phi2), .D(pcAddr_D), .Q(pcAddr_Q), .CLR(clear));


// read port muxes
  
  mux4    #(32, `dptype, `group_regfile)
    muxA( .IN0(regfile_A), .IN1(IRQ13_Q), .IN2(SVC13_Q), 
//	  .IN3({6'b0, pcAddr_Q, 2'b0}), 		-- changed by Jian Shen 1.10.99
	  .IN3({ stat_Q, mask_Q, pcAddr_Q, mode_Q}), 
	  .S0(sel_A[0]), .S1(sel_A[1]), .Y(Aport));

  mux4    #(32, `dptype, `group_regfile)
    muxB( .IN0(regfile_B), .IN1(IRQ13_Q), .IN2(SVC13_Q), 
	  .IN3({ stat_Q, mask_Q, pcAddr_Q, mode_Q}), 
	  .S0(sel_B[0]), .S1(sel_B[1]), .Y(Bport));
	  


// write port muxes

  mux2    #(4, `stdcelltype, `group_stat)
    mux_stat( .IN0(W[31:28]), .IN1(CONDin),
	  .S0(sel_stat), .Y(stat_D));

  mux2    #(2, `stdcelltype, `group_mask)
    mux_mask( .IN0(W[27:26]), .IN1(MASKin),
	  .S0(sel_mask), .Y(mask_D));

  mux2    #(24, `dptype, `group_pc)
    mux_pcAddr( .IN0(W[25:2]), .IN1(INCin[25:2]),
	  .S0(sel_inc), .Y(pcAddr_D));

/**********************************************************************
  stdinv inv_sel_inc( .IN0(sel_inc), .Y(sel_inc_bar));

  stdand2 and_pcAddr1( .IN0(sel_inc_bar), .IN1(W[1]), .Y(pcAddr_D[1]));
  stdand2 and_pcAddr0( .IN0(sel_inc_bar), .IN1(W[0]), .Y(pcAddr_D[0]));
**********************************************************************/

  mux2    #(2, `stdcelltype, `group_mode)
    mux_mode( .IN0(W[1:0]), .IN1(MODEin),
	  .S0(sel_mode), .Y(mode_D));

endmodule



