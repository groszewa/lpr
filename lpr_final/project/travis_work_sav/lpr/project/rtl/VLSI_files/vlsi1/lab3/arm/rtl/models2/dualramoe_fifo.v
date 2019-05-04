//
//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/


// Behavior module for the dual port RAM connected such that
// port A only writes and port B only reads
// Author: Hossein Ahmadnia Aug. 1992.

  ///comptype      "dualram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"io_type"     	:INT	:1;
  ///"floorplan"     	:INT	:FLOORPLAN;
  ///"bpc"      	:INT	:BPC;
  ///"test_flag"	:INT	:0;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"test_type"	:STRING :"NONE";
  ///"bist"	        :INT	:0;

module  dualramoe_fifo (A,ADIN,AWR,B,BOE,BDOUT);

	parameter  N = 1;
	parameter  WORDS = 1;
	parameter  M = 1;
	parameter  BPC = 2;
	parameter  FLOORPLAN = 0;

	parameter  access_dly = 5;	// Access time from A()
	parameter  din_dout_dly = 4;	// Delay Din() to Dout()
	parameter  wr_dout_dly = 3;	// Delay Wr low to Dout()
	parameter  wr_to_ramcell = 2;	// Time to toggle ramcell()
	parameter  v2z_delay = 2;	
	parameter  z2v_delay = 2;	

	input [M-1:0] A,B;
	input [N-1:0] ADIN;
	input AWR,BOE;
	output [N-1:0] BDOUT;
 

	supply1 VDD;
	supply1 [N-1:0] VDDBUS;
	wire [N-1:0] ADOUT;
       
 

  dualramoe  #(N,WORDS,M,BPC,FLOORPLAN,access_dly,din_dout_dly,wr_dout_dly,wr_to_ramcell,v2z_delay,z2v_delay)
	 inst1 (.A(A),.ADIN(ADIN),.AOE(VDD),.AWR(AWR),
		.B(B),.BDIN(VDDBUS),.BOE(BOE),.BWR(VDD),
		.ADOUT(ADOUT),.BDOUT(BDOUT) );


endmodule

