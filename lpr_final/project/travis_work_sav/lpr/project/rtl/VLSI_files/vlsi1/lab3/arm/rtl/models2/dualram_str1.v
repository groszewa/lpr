//
//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the dual port RAM with test str STR1

  ///comptype      "dualram";
  ///"words"     	:INT	:words;
  ///"bits"      	:INT	:N;
  ///"io_type"     	:INT	:0;
  ///"bpc"      	:INT	:BPC;
  ///"floorplan"	:INT	:FLOORPLAN;
  ///"test_flag"	:INT	:0;
  ///"split_rail"	:INT	:0;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"test_type"	:STRING :"STR1";
  ///"bist"	        :INT	:0;

module  dualram_str1 (A,ADIN,AWR,B,BDIN,BWR,MODE,TA,TADIN,TAWR,TB,TBDIN,TBWR,ADOUT,BDOUT);

	parameter  N = 1;
	parameter  WORDS = 1;
	parameter  M = 1;
	parameter  BPC = 2;
	parameter  FLOORPLAN = 0;

	parameter  access_dly = 5;	// Access time from A()
	parameter  din_dout_dly = 4;	// Delay Din() to Dout()
	parameter  wr_dout_dly = 3;	// Delay Wr low to Dout()
	parameter  wr_to_ramcell = 2;	// Time to toggle ramcell()
        parameter  input_mux_dly = 1;

	input [M-1:0] A,B,TA,TB;
	input [N-1:0] ADIN,BDIN,TADIN,TBDIN;
	input AWR,BWR,TAWR,TBWR,MODE;
	output [N-1:0] ADOUT,BDOUT;
 

	reg [N-1:0] tmpadin,tmpbdin;
	reg [M-1:0] tmpa,tmpb;
	reg tmpawr,tmpbwr;
       
	event ainput_change,binput_change,cinput_change;
	event dinput_change,einput_change,finput_change;
 

 dualram #(N,WORDS,M,BPC,FLOORPLAN,access_dly,din_dout_dly,wr_dout_dly,wr_to_ramcell)
	 inst1 (.A(tmpa),.ADIN(tmpadin),.AWR(tmpawr),
		.B(tmpb),.BDIN(tmpbdin),.BWR(tmpbwr),
		.ADOUT(ADOUT),.BDOUT(BDOUT) );

always @(MODE or A or TA)
 begin 
   disable block_a;
   #input_mux_dly -> ainput_change;
 end   

always @(ainput_change)
  begin: block_a
    if (MODE == 1'b0)
      tmpa = A;
    else if (MODE == 1'b1)
      tmpa = TA;
    else
      tmpa = 'bx;
  end

always @(MODE or B or TB)
 begin 
   disable block_b;
   #input_mux_dly -> binput_change;
 end   

always @(binput_change)
  begin: block_b
    if (MODE == 1'b0)
      tmpb = B;
    else if (MODE == 1'b1)
      tmpb = TB;
    else
      tmpb = 'bx;
  end

always @(MODE or ADIN or TADIN)
 begin 
   disable block_c;
   #input_mux_dly -> cinput_change;
 end   

always @(cinput_change)
  begin: block_c
    if (MODE == 1'b0)
      tmpadin = ADIN;
    else if (MODE == 1'b1)
      tmpadin = TADIN;
    else
      tmpadin = 'bx;
  end

always @(MODE or BDIN or TBDIN)
 begin 
   disable block_d;
   #input_mux_dly -> dinput_change;
 end   

always @(dinput_change)
  begin: block_d
    if (MODE == 1'b0)
      tmpbdin = BDIN;
    else if (MODE == 1'b1)
      tmpbdin = TBDIN;
    else
      tmpbdin = 'bx;
  end

always @(MODE or AWR or TAWR)
 begin 
   disable block_e;
   #input_mux_dly -> einput_change;
 end   

always @(einput_change)
  begin: block_e
    if (MODE == 1'b0)
      tmpawr = AWR;
    else if (MODE == 1'b1)
      tmpawr = TAWR;
    else
      tmpawr = 'bx;
  end

always @(MODE or BWR or TBWR)
 begin 
   disable block_f;
   #input_mux_dly -> finput_change;
 end   

always @(finput_change)
  begin: block_f
    if (MODE == 1'b0)
      tmpbwr = BWR;
    else if (MODE == 1'b1)
      tmpbwr = TBWR;
    else
      tmpbwr = 'bx;
  end

endmodule

