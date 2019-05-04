//
//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the dual port RAM connected such that
// port A only writes and port B only reads and is always enabled
// Author: Hossein Ahmadnia Aug. 1992.

  ///comptype      "dualram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"io_type"     	:INT	:0;
  ///"bpc"      	:INT	:BPC;
  ///"test_flag"	:INT	:0;
  ///"floorplan"	:INT	:FLOORPLAN;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"test_type"	:STRING :"NONE";
  ///"bist"	        :INT	:0;

module  dualram_fifo (A,ADIN,AWR,B,BDOUT);

	parameter  N = 1;
	parameter  WORDS = 1;
	parameter  M = 1;
	parameter  BPC = 2;
	parameter  FLOORPLAN = 0;

	parameter  access_dly = 5;	// Access time from A()
	parameter  din_dout_dly = 4;	// Delay Din() to Dout()
	parameter  wr_dout_dly = 3;	// Delay Wr low to Dout()
	parameter  wr_to_ramcell = 2;	// Time to toggle ramcell()

	input [M-1:0] A,B;
	input [N-1:0] ADIN;
	input AWR;
	output [N-1:0] BDOUT;
 

	supply1 VDD;
	supply1 [N-1:0] VDDBUS;
	wire [N-1:0] ADOUT;
       
 

  dualram  #(N,WORDS,M,BPC,FLOORPLAN,access_dly,din_dout_dly,wr_dout_dly,wr_to_ramcell)
	 inst1 (.A(A),.ADIN(ADIN),.AWR(AWR),
		.B(B),.BDIN(VDDBUS),.BWR(VDD),
		.ADOUT(ADOUT),.BDOUT(BDOUT) );


endmodule

