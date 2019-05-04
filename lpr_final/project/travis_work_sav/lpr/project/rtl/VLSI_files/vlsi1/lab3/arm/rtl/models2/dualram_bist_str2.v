//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the  RAM with test structure STR1 and bist
// Author: Hossein Ahmadnia Aug 1992

  ///comptype      "dualram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"bpc"      	:INT	:BPC;
  ///"test_flag"	:INT	:0;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"bist"             :INT    :1;
  ///"floorplan" 	:INT    :FLOORPLAN;
  ///"test_str"         :STRING :"STR2";
             
module  dualram_bist_str2 (A,ADIN,AWR,B,BDIN,BWR,MODE,TSTCLK,ADOUT,BDOUT, DONE,TEST);

	parameter  N = 8;
	parameter  WORDS = 64;
	parameter  M = 6;
	parameter  BPC = 4;
	parameter  FLOORPLAN = 0;


	parameter  access_dly = 4;	// Access time from A()
	parameter  din_dout_dly =2;	// Delay DIN() to DOUT()
	parameter  wr_dout_dly = 3;	// Delay WR low to DOUT()
	parameter  wr_to_ramcell = 1;	// Time to toggle ramcell()
        parameter  input_mux_dly = 1;
	
        input [M-1:0] A,B;
	input [N-1:0] ADIN,BDIN;
	input TSTCLK,AWR,BWR,MODE;
	output [N-1:0] ADOUT,BDOUT;
        output TEST,DONE;

/*    following for testing
        output pgen,checken,pgdinsel,pgclr,pgup;
        output[N-1:0] pgdin;
        output[M-1:0] pgaddr;
        output pgwr;
*/
        wire pgwr;
        reg TEST,pgen;

        reg[N-1:0] pattern;
        reg tmp,tmp1,lsb;
        reg[M-1:0] pgaddr,pgaddr0,pgaddr1;
        reg[N-1:0] pgdin;
        integer i; 


initial
 begin
   for (i= 0; i<N; i= i+1)
  pattern[i] = i;
end

dualram_str2 #(N,WORDS,M,BPC,FLOORPLAN,access_dly,din_dout_dly,wr_dout_dly,wr_to_ramcell,input_mux_dly) dualraminst
    (A,ADIN,AWR,B,BDIN,BWR,MODE,pgaddr0,pgdin,pgawr,pgaddr1,pgdin,pgbwr,ADOUT,BDOUT);

cda_bistram2_cntrl controller 
  (MODE,TSTCLK,pgen,checken1,checken2,pgdinsel,pgclr,pgup,DONE,odd,by2,pgawr,pgbwr);

   
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
      pgdin = pattern;
   else
      pgdin = ~pattern;
 end

always @(negedge TSTCLK)
   begin 
     tmp = 1'b1;
     tmp1 = 1'b1;
     case (pgdinsel)
       1'b0:   
           begin
            if (dualraminst.tmpadout === ~pattern)
             tmp = 1'b0;
            if (dualraminst.tmpbdout === ~pattern)
             tmp1 = 1'b0;
           end
       1'b1:       
           begin
            if (dualraminst.tmpadout === pattern) 
             tmp = 1'b0;
            if (dualraminst.tmpbdout === pattern) 
             tmp1 = 1'b0;
           end
     endcase
    
     TEST = TEST | (tmp & ~checken1 ) | (tmp1 & ~checken2) ;  
   end  

always @(pgaddr or  by2 or odd )
  begin

   case (by2)
     1'b1:
        begin
         pgaddr0 = {pgaddr[M-2:0],odd};
         pgaddr1 = {pgaddr[M-2:0],~odd};
        end
     1'b0:
        begin
         pgaddr0 = pgaddr;
         pgaddr1 = pgaddr;
        end
  endcase
end



always @(pgclr)
 begin   
   if (pgclr == 1'b0)
      assign pgaddr = 0;
   else if (pgclr == 1'b1)
      deassign pgaddr;
               
 end


always @(odd or pgup or pgaddr0 or pgaddr1[0]  or  pgaddr or by2 )
 begin
  lsb = (odd ^ pgup) ? pgaddr1[0] : pgaddr0[0];
  pgen = 1'b0;
  if (pgup == 1'b1)
    begin
       if ((by2 == 1'b0) && (pgaddr == WORDS-1))
	 pgen = 1'b1;
       else if ((by2 == 1'b1) && ({pgaddr0[M-1:1],lsb} == WORDS-1))
         pgen = 1'b1;
    end
  else if (pgup == 1'b0)
    begin
      if ((by2 == 1'b0) && (pgaddr == 0))
	pgen = 1'b1;
      else if ((by2 == 1'b1) && ({pgaddr0[M-1:1],lsb} == 0))
	pgen = 1'b1;
    end
  
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
