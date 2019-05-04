`timescale 1 ns / 100 ps

/* 16-bit Ripple-carry Adder*/



module rc_16b( a, b, cin, s, cout);/* 4-bit ripple carry adder made up of one_bit_adders */
parameter WIDTH = 16;

input [WIDTH-1:0] a; 
input [WIDTH-1:0] b;
input 		 cin;

output[WIDTH-1:0] s;
output		 cout;

wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15;

one_bit_adder a1(a[0],b[0],cin,s[0],t1);
one_bit_adder a2(a[1],b[1],t1,s[1],t2);
one_bit_adder a3(a[2],b[2],t2,s[2],t3);
one_bit_adder a4(a[3],b[3],t3,s[3],t4);
one_bit_adder a5(a[4],b[4],t4,s[4],t5);
one_bit_adder a6(a[5],b[5],t5,s[5],t6);
one_bit_adder a7(a[6],b[6],t6,s[6],t7);
one_bit_adder a8(a[7],b[7],t7,s[7],t8);
one_bit_adder a9(a[8],b[8],t8,s[8],t9);
one_bit_adder a10(a[9],b[9],t9,s[9],t10);
one_bit_adder a11(a[10],b[10],t10,s[10],t11);
one_bit_adder a12(a[11],b[11],t11,s[11],t12);
one_bit_adder a13(a[12],b[12],t12,s[12],t13);
one_bit_adder a14(a[13],b[13],t13,s[13],t14);
one_bit_adder a15(a[14],b[14],t14,s[14],t15);
one_bit_adder a16(a[15],b[15],t15,s[15],cout);

endmodule

module one_bit_adder(a0,b0,c0,s0,c1);

/* three inputs which are 1 bit each */
input a0;
input b0;
input c0;/* carry in */

/* two outputs which are 1 bit each */
output s0;/* sum */
output c1;/* carry out */

assign s0 = a0^b0^c0;
assign c1 = (a0&b0)|(b0&c0)|(c0&a0);

endmodule