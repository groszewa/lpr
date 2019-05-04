//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the  RAM with test structure STR1
// Author Hossein Ahmadnia June 1992
  ///comptype      "ram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"addr"             "INT    :M;
  ///"io_type"     	:INT	:0;
  ///"bpc"      	:INT	:BPC;
  ///"floorplan"	:INT	:floorplan;
  ///"test_flag"	:INT	:0;
  ///"split_rail"	:INT	:split_rail;
  ///"BUFFER_SIZE"	:INT	:1;  
  ///"test_type"        :STRING :"STR1";
  ///"bist"             :INT    :0;

module  ram_str1 (A,DIN,MODE,TA,TDIN,TWR,WR, DOUT);

	parameter  N = 8;
	parameter  WORDS = 64;
	parameter  M = 6;
	parameter  BPC = 4;
	parameter  FLOORPLAN = 0;

	parameter  access_dly = 1;	// Access time from A()
	parameter  din_dout_dly = 1;	// Delay DIN() to DOUT()
	parameter  wr_dout_dly = 1;	// Delay WR low to DOUT()
	parameter  wr_to_ramcell = 1;	// Time to toggle ramcell()
        parameter  input_mux_dly = 1;

	
        input [M-1:0] A,TA;
	input [N-1:0] DIN,TDIN;
	input WR,TWR,MODE;
	output [N-1:0] DOUT;
   
        reg tmpwr;
        reg [M-1:0] tmpaddr;
        reg [N-1:0] tmpdata;  
       
        event input_change;

ram #(N,WORDS,M,BPC,FLOORPLAN,
      access_dly,din_dout_dly,wr_dout_dly,wr_to_ramcell)
      raminst (tmpaddr,tmpdata,tmpwr, DOUT);     

always @(MODE or A or TA or DIN or TDIN or WR or TWR)
   begin              
     disable block_a;
     #input_mux_dly ->input_change;

   end
always @(input_change)
   begin: block_a
     if (MODE == 1'b0)
       begin
        tmpwr = WR;
        tmpaddr = A;
        tmpdata = DIN;
       end
     else if (MODE == 1'b1)
       begin
        tmpwr = TWR;
        tmpaddr = TA;
        tmpdata = TDIN;
       end
     else
       begin
        tmpwr = 1'bx;
        tmpaddr = 'bx;
        tmpdata = 'bx;
       end
    end
endmodule


