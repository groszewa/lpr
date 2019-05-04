//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the  mpram3r2w with test structure STR1 
// Author: Hossein Ahmadnia Aug 1992

  ///comptype      "bistram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"addr"      	:INT	:M;
  ///"bpc"      	:INT	:BPC;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"bist"             :INT    :0;
  ///"test_str"         :STRING :"STR1";
             

module mpram5_str1(DIN0,DIN1,MODE,OE0BAR,OE1BAR,OE2BAR,RAD0,RAD1,RAD2,
               TDIN0,TDIN1,TOE0BAR,TOE1BAR,TOE2BAR,TRAD0,TRAD1,TRAD2,TWAD0,
	       TWAD1,TWE0BAR,TWE1BAR,WAD0,WAD1,WE0BAR,WE1BAR,DOUT0,DOUT1,DOUT2);

 parameter N = 8;
 parameter WORDS = 8;
 parameter M = 3;
 parameter BPC = 1;
 parameter TACC = 5;
 parameter TOES = 4;
 parameter TPDS = 3;
 parameter TWP = 7;
 parameter TDS = 8;
 parameter TWES = 10;
 parameter TDIO = 9;

input MODE;
input [M-1:0] RAD0,RAD1,RAD2,TRAD0,TRAD1,TRAD2,
                     WAD0,WAD1,TWAD0,TWAD1;
input [N-1:0] DIN0,DIN1,TDIN0,TDIN1;
input OE0BAR,OE1BAR,OE2BAR,TOE0BAR,TOE1BAR,TOE2BAR;
input WE0BAR,WE1BAR,TWE0BAR,TWE1BAR;
output [N-1:0] DOUT0,DOUT1,DOUT2;


wire[N-1:0] pgdin0,pgdin1;
wire[M-1:0] pgraddr0,pgraddr1,pgraddr2,
		  pgwaddr0,pgwaddr1;
wire pgoe0,pgoe1,pgoe2,pgwr0,pgwr1;

mpram_3r2w #(N,WORDS,M,BPC,TACC,TOES,TPDS,TWP,TDS,TWES,TDIO)
       rampart (pgdin0,pgdin1,pgoe0,pgoe1,pgoe2,pgraddr0,pgraddr1,pgraddr2,
                   pgwaddr0,pgwaddr1,pgwr0,pgwr1,DOUT0,DOUT1,DOUT2);

  assign pgoe0 = (MODE) ? TOE0BAR : OE0BAR;          
  assign pgoe1 = (MODE) ? TOE1BAR : OE1BAR;          
  assign pgoe2 = (MODE) ? TOE2BAR : OE2BAR;          
  assign pgwr0 = (MODE) ? TWE0BAR : WE0BAR;
  assign pgwr1 = (MODE) ? TWE1BAR : WE1BAR;
  assign pgdin0 = (MODE) ? TDIN0 : DIN0;
  assign pgdin1 = (MODE) ? TDIN1 : DIN1;
  assign pgwaddr0 = (MODE) ? TWAD0 : WAD0;
  assign pgwaddr1 = (MODE) ? TWAD1 : WAD1;
  assign pgraddr0 = (MODE) ? TRAD0 : RAD0;
  assign pgraddr1 = (MODE) ? TRAD1 : RAD1;
  assign pgraddr2 = (MODE) ? TRAD2 : RAD2;

endmodule
