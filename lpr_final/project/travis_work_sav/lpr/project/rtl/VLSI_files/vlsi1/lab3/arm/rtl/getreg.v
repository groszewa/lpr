// 
// getreg.v
// 
// David Van Campenhout
// 
// 
// 

`define imptype 1
`define dptype 1
`define stdcelltype 0
`define group_getreg 	"group_count"

// scan chain:
//
// register	width
// ======== 	=====
// reglist	16
// ======== 	=====
// total		16


module getreg(	clk, clear, test, scanin, scanout,
			init, initlist, mode, xreg, zero);

  input		clk;
  input		clear;
  input		test;	
  input		scanin;	
  output		scanout;
  input		init;
  input [15:0]	initlist;
  input [1:0]	mode;

  output [5:0]	xreg;
  output	zero;

  wire	[15:0]	toggle;
  wire	[15:0]	updated_reglist;
  wire	[15:0]	reglist_d;
  wire	[15:0]	reglist_q;
  wire	[15:0]	reglist_qbar;
  wire	[3:0]	xreg_low;
  
  assign	xreg = {mode, xreg_low};
  assign  scanout = reglist_q[15];

  getregfromlist xtractreg( 	.reglist(reglist_q), 
				.xreg(xreg_low), 
				.toggle(toggle));
  

  zero #(16, `dptype, `group_getreg)
	checkzero( .IN0(updated_reglist), .Y(zero));

  nor2 #(16, `dptype, `group_getreg)
	nor_0( .IN0(toggle), .IN1( reglist_qbar), .Y( updated_reglist)); 

  mux2 #(16, `dptype, `group_getreg)
	mux_0( .IN0(updated_reglist), .IN1(initlist), 
		.S0(init), .Y(reglist_d));  

  dffs_cq #(16, `dptype, `group_getreg)
	reglist( .CLK(clk), .CLR(clear), .TEST(test), .SCANIN(scanin),
		.D(reglist_d), .Q(reglist_q), .QBAR(reglist_qbar));

endmodule



