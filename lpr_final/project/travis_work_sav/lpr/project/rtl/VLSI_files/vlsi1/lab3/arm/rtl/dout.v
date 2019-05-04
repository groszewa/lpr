// 
// dout.v
// 
// David Van Campenhout
// 
// duplicate byte over whole word width if store byte
// 

 
`define stdcelltype 0
`define dptype 1
`define group_dout	"group_dio"

// scan chain:
//
// register	width
// ======== 	=====
// dout		32
// ======== 	=====
// total		32

module dout( 	clk, clear, test, scanin, scanout, 
			in, byte, enable, dataBus);

  input		clk;
  input		clear;
  input		test;
  input		scanin;
//  input	scanout; -- changed by Jian Shen
  output	scanout;  
  input [31:0]	in;
  input		byte;	// 1: store byte
  input		enable;

  output [31:0] dataBus;
  

  wire		enable_bar;
  wire 	[31:0]	dout_d;
  wire 	[31:0]	dout_q;
  assign	dout_d[7:0] = in[7:0];

  // scan chain:
  //
  // dout_q[0] -> dout_q[31]
  //
  
  assign		scanout = dout_q[31];

  stdinv inv_en( .IN0(enable), .Y(enable_bar));

  mux2 #(8, `dptype, `group_dout)
	mux_1( .IN0(in[15:8]), .IN1(in[7:0]), .S0(byte), .Y(dout_d[15:8]));
  mux2 #(8, `dptype, `group_dout)
	mux_2( .IN0(in[23:16]), .IN1(in[7:0]), .S0(byte), .Y(dout_d[23:16]));
  mux2 #(8, `dptype, `group_dout)
	mux_3( .IN0(in[31:24]), .IN1(in[7:0]), .S0(byte), .Y(dout_d[31:24]));

  dffs_c   #(32, `dptype, `group_dout)
    dout( .CLK(clk), .CLR(clear), .TEST(test), .SCANIN(scanin), 
    		.D(dout_d), .Q(dout_q));
 
  tribuf #(32, `dptype, `group_dout)
        tbuf_dout( .EN(enable_bar), .IN0(dout_q), .Y(dataBus));

endmodule

