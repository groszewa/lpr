//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the  mpram3r2w  with test structure STR1 and bist
// Author: Hossein Ahmadnia Jan 1992

  ///comptype      "bistram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"bpc"      	:INT	:BPC;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"bist"             :INT    :1;
  ///"test_str"         :STRING :"STR1";
             

module mpram5_bist_str1(DIN0,DIN1,MODE,OE0BAR,OE1BAR,OE2BAR,RAD0,RAD1,RAD2,
                TSTCLK,WAD0,WAD1,WE0BAR,WE1BAR,DONE,DOUT0,DOUT1,DOUT2,TEST);

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

input MODE,TSTCLK;
input [M-1:0] RAD0,RAD1,RAD2,
                     WAD0,WAD1;
input [N-1:0] DIN0,DIN1;
input OE0BAR,OE1BAR,OE2BAR;
input WE0BAR,WE1BAR;
output [N-1:0] DOUT0,DOUT1,DOUT2;
output DONE,TEST;
integer i;

supply1 VDD;
reg[N-1:0] pattern,pgdin;
reg TEST,tmp,tmp1,tmp2,pgen;
reg[M-1:0] pgaddr;
reg[M-1:0] pgraddr0,pgraddr1,pgraddr2,
		  pgwaddr0,pgwaddr1;
wire pgoe0,pgoe1,pgoe2,pgwr0,pgwr1;
wire [N-1:0] pgdin0,pgdin1;
wire checken1,checken2,checken3;
wire r1,r2,by2,pgawr,pgbwr;
wire pgclr,pgup;



mpram_3r2w #(N,WORDS,M,BPC,TACC,TOES,TPDS,TWP,TDS,TWES,TDIO)
       rampart (pgdin0,pgdin1,pgoe0,pgoe1,pgoe2,pgraddr0,pgraddr1,pgraddr2,
                   pgwaddr0,pgwaddr1,pgwr0,pgwr1,DOUT0,DOUT1,DOUT2);

initial
 begin
   for (i= 0; i<N; i= i+1)
  pattern[i] = i;
end

                
cda_bistram5_cntrl controller 
         (MODE,TSTCLK,pgen,checken1,checken2,checken3,pgdinsel,pgclr,pgup,DONE,odd,r1,r2,by2,pgawr,pgbwr);

  assign pgoe0 = (MODE) ? checken1 : OE0BAR;          
  assign pgoe1 = (MODE) ? checken2 : OE1BAR;          
  assign pgoe2 = (MODE) ? checken3 : OE2BAR;          
  assign pgwr0 = (MODE) ? pgawr : WE0BAR;
  assign pgwr1 = (MODE) ? pgbwr : WE1BAR;
  assign pgdin0 = (MODE) ? pgdin : DIN0;
  assign pgdin1 = (MODE) ? pgdin : DIN1;

   
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
     tmp1= 1'b1;
     tmp2= 1'b1;
     case (pgdinsel)
       1'b0:   
           begin
            if (DOUT0=== ~pattern)
             tmp = 1'b0;
            if (DOUT1=== ~pattern)
             tmp1= 1'b0;
            if (DOUT2=== ~pattern)
             tmp2= 1'b0;
           end
       1'b1:       
 	   begin
            if (DOUT0=== pattern )
             tmp = 1'b0;
            if (DOUT1=== pattern )
             tmp1= 1'b0;
            if (DOUT2=== pattern )
             tmp2= 1'b0;
 	   end
     endcase
    
     /* note checken? signals are active low  */
     TEST = TEST | (tmp & ~checken1) | (tmp1 & ~checken2) | (tmp2 & ~checken3);  
   end  


always @(pgaddr or MODE or by2 or r1 or r2 or RAD0 or RAD1 or RAD2)
  begin

   case ({~MODE,by2})

     2'b10, 2'b11: 
        begin
         pgraddr0 = RAD0;
         pgraddr1 = RAD1;
         pgraddr2 = RAD2;
        end
     2'b01:
        begin
         pgraddr0 = {pgaddr[N-2:0],r1};
         pgraddr1 = {pgaddr[N-2:0],r2};
         pgraddr2 = {pgaddr[N-2:0],VDD};
        end
     2'b00:
        begin
         pgraddr0 = pgaddr;
         pgraddr1 = pgaddr;
         pgraddr2 = pgaddr;
        end
    endcase
end

always @(pgaddr or MODE or by2 or odd or WAD0 or WAD1 )
  begin

   #1
   case ({~MODE,by2})

     2'b10, 2'b11: 
        begin
         pgwaddr0 = WAD0;
         pgwaddr1 = WAD1;
        end
     2'b01:
        begin
         pgwaddr0 = {pgaddr[N-2:0],odd};
         pgwaddr1 = {pgaddr[N-2:0],~odd};
        end
     2'b00:
        begin
         pgwaddr0 = pgaddr;
         pgwaddr1 = pgaddr;
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

always @(pgaddr or pgup or by2 or pgraddr2)
 begin
  pgen = 1'b0;
  if (pgup == 1'b1)
    begin
       if ((by2 == 1'b0) && (pgaddr == WORDS-1))
	 pgen = 1'b1;
       else if ((by2 == 1'b1) && (pgraddr2 == WORDS-1))
       pgen = 1'b1;
    end
  else if (pgup == 1'b0)
    begin
      if ((by2 == 1'b0) && (pgaddr == 0))
	pgen = 1'b1;
      else if ((by2 == 1'b1) && (pgraddr2 == 1'b1))
	pgen = 1'b1;
    end
  
 end

always @(posedge TSTCLK)
  begin
   if (~pgen)       
    begin
     if (pgup)
        pgaddr = pgaddr + 1;
     else
        pgaddr = pgaddr - 1;
    end
  end
         
endmodule
