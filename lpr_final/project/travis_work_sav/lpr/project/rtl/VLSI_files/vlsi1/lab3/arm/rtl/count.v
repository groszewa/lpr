// 
// count.v
// 
// David Van Campenhout
// 
// counts the number of '1' bits in 16-bit field
// 
// no ffs

`define stdcelltype 0
`define	group_count "group_count"

module count(in, cnt, cnt1);

  input [15:0]	in;
  output [4:0]	cnt;	// count
  output [3:0]	cnt1;	// count - 1; when used count will always be >=1

  supply1	vdd, VDD, Vdd;
  supply0	vss, VSS, Vss;

  wire [6:0]	c0;
  wire [10:0]	c1;
  wire [4:0]	c2;
  wire [1:0]	c3;

  stdadd add0_0( .A(in[0]), .B(in[1]), .CIN(in[2]), .SUM(c0[0]), .COUT(c1[0]));
  stdadd add0_1( .A(in[3]), .B(in[4]), .CIN(in[5]), .SUM(c0[1]), .COUT(c1[1]));
  stdadd add0_2( .A(in[6]), .B(in[7]), .CIN(in[8]), .SUM(c0[2]), .COUT(c1[2]));
  stdadd add0_3( .A(in[9]), .B(in[10]), .CIN(in[11]), .SUM(c0[3]), .COUT(c1[3]));
  stdadd add0_4( .A(in[12]), .B(in[13]), .CIN(in[14]), .SUM(c0[4]), .COUT(c1[4]));

  stdadd add0_5( .A(c0[0]), .B(c0[1]), .CIN(c0[2]), .SUM(c0[5]), .COUT(c1[5]));
  stdadd add0_6( .A(c0[3]), .B(c0[4]), .CIN(in[15]), .SUM(c0[6]), .COUT(c1[6]));
  stdaddh add0_7( .A(c0[5]), .B(c0[6]), .SUM(cnt[0]), .COUT(c1[7]));

  stdadd add1_0( .A(c1[0]), .B(c1[1]), .CIN(c1[2]), .SUM(c1[8]), .COUT(c2[0]));
  stdadd add1_1( .A(c1[3]), .B(c1[4]), .CIN(c1[6]), .SUM(c1[9]), .COUT(c2[1]));
  stdaddh add1_2( .A(c1[8]), .B(c1[5]), .SUM(c1[10]), .COUT(c2[2]));

  stdadd add1_3( .A(c1[10]), .B(c1[9]), .CIN(c1[7]), .SUM(cnt[1]), .COUT(c2[3]));
  stdadd add2_0( .A(c2[0]), .B(c2[1]), .CIN(c2[2]), .SUM(c2[4]), .COUT(c3[0]));
  stdaddh add2_1( .A(c2[4]), .B(c2[3]), .SUM(cnt[2]), .COUT(c3[1]));
  stdaddh add3_0( .A(c3[0]), .B(c3[1]), .SUM(cnt[3]), .COUT(cnt[4]));


  // in case cnt == 16; decrementing cnt[3:0] will still yield 15 !
  // so, we only need a 4-bits decrementer
  incbar #(4, `stdcelltype, `group_count)
	decrement(	.EN(vdd),	
			.IN0(cnt[3:0]),
			//.TC(), .TCBAR(),
			.Y(cnt1));  
  
endmodule

