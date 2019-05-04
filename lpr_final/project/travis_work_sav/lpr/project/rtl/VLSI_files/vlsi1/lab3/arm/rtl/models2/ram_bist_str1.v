//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the  RAM with test structure STR1 and bist
// Author: Hossein Ahmadnia Jan 1992

  ///comptype      "ram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"io_type"     	:INT	:0;
  ///"bpc"      	:INT	:BPC;
  ///"floorplan"	:INT	:floorplan;
  ///"test_flag"	:INT	:0;
  ///"split_rail"	:INT	:split_rail;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"bist"             :INT    :1;
  ///"test_str"         :STRING :"STR1";
             
module  ram_bist_str1 (A,DIN,MODE,TSTCLK,WR, DONE,DOUT,TEST);

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
	
        input [M-1:0] A;
	input [N-1:0] DIN;
	input TSTCLK,WR,MODE;
	output [N-1:0] DOUT;
        output TEST,DONE;

        /* following for testing */
        wire pgwr;
        reg TEST,pgen;
        reg tmp;
        reg[N-1:0] pgdin;
        reg[M-1:0] pgaddr;


ram_str1 #(N,WORDS,M,BPC,FLOORPLAN,access_dly,din_dout_dly,wr_dout_dly,wr_to_ramcell,input_mux_dly)
         raminst (A,DIN,MODE,pgaddr,pgdin,pgwr,WR,DOUT); 

cda_bistram1_cntrl cntr1(MODE,TSTCLK,pgen,checken,pgdinsel,pgclr,pgup,DONE);
                

assign pgwr = TSTCLK | ~pgclr;

   
always @(MODE)
 begin             
   if (MODE == 1'b0)   
     assign TEST = 0;
   else
     deassign TEST;
 end               
always @(pgdinsel)
 begin
   if (pgdinsel == 1'b0)
       pgdin = 0;
   else
    begin
      pgdin = 0;
      pgdin = ~pgdin;
    end
 end
always @(negedge TSTCLK)
   begin 
     tmp = 1'b1;
     case (pgdinsel)
       1'b0:   
           if (&DOUT === 1'b1)
           tmp = 1'b0;
       1'b1:       
           if (|DOUT === 1'b0)
           tmp = 1'b0;
     endcase
    
     TEST = TEST | (tmp & checken);  
   end  

always @(pgclr)
 begin   
   if (pgclr == 1'b0)
      assign pgaddr = 0;
   else if (pgclr == 1'b1)
      deassign pgaddr;
               
 end

always @(pgaddr or pgup)
 begin
  pgen = 1'b0;
  if (pgup == 1'b1 && pgaddr == WORDS-1)
       pgen = 1'b1; 
  else if (pgup == 1'b0 && pgaddr == 0)
       pgen = 1'b1;  
  
 end

always @(posedge TSTCLK)
  begin
   if (~pgen)       
    begin
     if (pgup)
        pgaddr = pgaddr+1;
     else
        pgaddr = pgaddr-1;
    end
  end
         
endmodule
