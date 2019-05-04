// 
// din.v
// 
// David Van Campenhout
// 
// data in: shift byte into LSB position if byte
// 


 
`define stdcelltype 0
`define dptype 1
`define group_din	"group_dio"
`define group_din8	"group_dio"
`define group_din24	"group_dio"

// scan chain:
//
// register	width
// ======== 	=====
// din		32
// ======== 	=====
// total		32


module din( 	clk, clear, test, scanin, scanout, 
			enable, dataBus, byte, ldstrByte, out);
 
  input		clk;
  input		clear;
  input		test;
  input		scanin;
  output		scanout;
  
  input		enable;
  input	[31:0]	dataBus;
  input [1:0]	byte;
  input 	ldstrByte;	// 1: byte; 0: word

  output [31:0]	out;
  

  supply1	vdd, VDD, Vdd;
  supply0	vss, VSS, Vss;

  wire 	[31:0]	din_q;
  wire	[1:0]	select_byte;
  wire		ldstrWord_buf;
  wire	[23:0]	ldstrWord24;
	
  // scan chain
  //
  // din_q[0] -> din_q[31]
  //
  
  assign	scanout = din_q[31];

  assign 	ldstrWord24 = 
	{ ldstrWord_buf, ldstrWord_buf, ldstrWord_buf, ldstrWord_buf,
	ldstrWord_buf, ldstrWord_buf, ldstrWord_buf, ldstrWord_buf,
	ldstrWord_buf, ldstrWord_buf, ldstrWord_buf, ldstrWord_buf,
	ldstrWord_buf, ldstrWord_buf, ldstrWord_buf, ldstrWord_buf,
	ldstrWord_buf, ldstrWord_buf, ldstrWord_buf, ldstrWord_buf,
	ldstrWord_buf, ldstrWord_buf, ldstrWord_buf, ldstrWord_buf};

  stdbufinv buf_ldstr( .IN0(ldstrByte), .Y(ldstrWord_buf));

  dffs_c   #(32, `dptype, `group_din)
    din( .CLK(clk), .CLR(clear), .TEST(test), .SCANIN(scanin),
    		.D(dataBus), .Q(din_q));

  stdand2 and_0( .IN0(byte[0]), .IN1(ldstrByte), .Y(select_byte[0]));
  stdand2 and_1( .IN0(byte[1]), .IN1(ldstrByte), .Y(select_byte[1]));

  mux4   #(8, `dptype, `group_din8)
    mux_0( .IN0(din_q[7:0]), .IN1( din_q[15:8]), 
		.IN2( din_q[23:16]), .IN3( din_q[31:24]), 
		.S0( select_byte[0]), .S1( select_byte[1]),
		.Y( out[7:0]));

  and2   #(24, `dptype, `group_din24)
    and_24( .IN0( din_q[31:8]), .IN1( ldstrWord24), .Y( out[31:8]));



endmodule




