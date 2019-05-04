//
// regfile.v
//
// David Van Campenhout
//
// 
//

`define group_mode	"group_mode"
`define dptype 	1
`define stdcelltype 0


module 
regfile( 	phi1, phi2, clear, test, scanin, scanout,
		rA, rB, wA, 
		W, INCin, MODEin, MASKin, CONDin, 
		enW, enINC, enMODE, enMASK, enCOND, 
		A, B, PCaddr, MODEout, MASKout, CONDout);

  input		phi1;
  input		phi2;	// clock used for writing
  input		clear;
  input		test;
  input		scanin;
  output		scanout;
  
  input [5:0]	rA;		// number of physical register to be read on A port
  input [5:0]	rB;		// number of physical register to be read on B port
  input [5:0]	wA;		// number of physical register to be written on B port

  input	[31:0]	W;	// general write port
  input [25:0]	INCin;	// write port to PC for incremented address reg
  input [1:0]	MODEin;	// write port to MODE part of PC
  input [1:0]	MASKin; 	// write port to interrupt mask part of PC
  input [3:0]	CONDin; 	// write port to datapath  flags

  input		enW;		// enables to write ports:
  input		enINC;
  input		enMODE;
  input		enMASK;
  input		enCOND;

  output [31:0]	A;	// read port A
  output [31:0]	B;	// read port A
  output [25:0]	PCaddr; // { PC[25:0], 2'b0 }
  output [1:0]	MODEout;	// MODE read port
  output [1:0]	MASKout;	// interrupt mask read port
  output [3:0]	CONDout;	// datapath status read port


  wire [4:0]	mrA;	// mapped rA
  wire [4:0]	mrB;	// mapped rB
  wire [4:0]	mwA;	// mapped wA

  wire [1:0]	sel_A;
  wire [1:0]	sel_B;
  wire [1:0]	sel_A_unbuf;
  wire [1:0]	sel_B_unbuf;
  wire		sel_stat;
  wire		sel_mask;
  wire		sel_inc;
  wire		sel_mode;

  wire		en_regfile;
  wire		en_IRQ13;
  wire		en_SVC13;
  wire		en_stat;
  wire		en_mask;
  wire		en_pcAddr;
  wire		en_mode;

//  wire		clear_bar;
  wire [1:0]	MODE_D;

  regfile_struct STRUCT(
.phi1( phi1), .phi2( phi2), .clear( clear), 
.test( test), .scanin( scanin), .scanout( scanout),
.W( W), 
.INCin( INCin), .MODEin( MODEin), .MASKin( MASKin), .CONDin( CONDin), 
.mrA( mrA), .mrB( mrB), .mwA( mwA), 
.sel_A( sel_A), .sel_B( sel_B), 
.sel_stat( sel_stat), .sel_mask( sel_mask), 
.sel_inc( sel_inc), .sel_mode( sel_mode), 
.en_regfile( en_regfile), 
.en_IRQ13( en_IRQ13), .en_SVC13( en_SVC13), 
.en_stat( en_stat), .en_mask( en_mask), 
.en_pcAddr( en_pcAddr), .en_mode( en_mode),
.A( A), .B( B), 
.PCaddr( PCaddr), 
.MODEout( MODEout), .MASKout( MASKout), .CONDout( CONDout)
);

  stdbuf buf_sel_A0( .IN0( sel_A_unbuf[0]), .Y( sel_A[0]));
  stdbuf buf_sel_A1( .IN0( sel_A_unbuf[1]), .Y( sel_A[1]));
  stdbuf buf_sel_B0( .IN0( sel_B_unbuf[0]), .Y( sel_B[0]));
  stdbuf buf_sel_B1( .IN0( sel_B_unbuf[1]), .Y( sel_B[1]));

//  stdinv inv_clear( .IN0(clear), .Y(clear_bar));

  decode_addresses CTRL(rA, rB, wA, enW, enINC, enMODE, enMASK, enCOND, 
	MODEout,
	mrA, mrB, mwA, 
	sel_A_unbuf, sel_B_unbuf, sel_stat, sel_mask, sel_inc, sel_mode, 
	en_regfile, en_IRQ13, en_SVC13, en_stat, en_mask, en_pcAddr, en_mode );
  
endmodule






