module cda_bistram2_cntrl(test,testclk,count,checken1,checken2,pgdinsel,pgclr,pgup,pgdone,odd,by2,pgawr,pgbwr);
parameter IDLE = 3'b000;
parameter BACK0 = 3'b001;
parameter FORWARD_WRITE1 = 3'b010;
parameter REVERSE_WRITE0 = 3'b011;
parameter BACK1 = 3'b100;
parameter FORWARD_WRITE0 = 3'b101;
parameter REVERSE_WRITE1 =3'b110;
parameter DONE =3'b111;
parameter WAIT =4'b1010;

parameter AWAR   = 3'b000;
parameter BWBR   = 3'b001;
parameter AWBR   = 3'b010;
parameter BWAR   = 3'b011;
parameter ABWABR1   =3'b100;
parameter ABWABR2   = 3'b101;

input test;
input testclk;       
input count;
output checken1,checken2;
output pgclr,pgup,pgdone;
output  pgdinsel;
output odd,by2;
output pgawr,pgbwr;

reg  [3:0] state,next_state;
reg  [2:0] testmode,next_testmode;
reg pgdinsel,next_pgdinsel;               
reg pgclr,next_pgclr;
reg pgup,next_pgup;  
reg pgdone,next_pgdone;
reg pgawrsel,next_pgawrsel;
reg pgbwrsel,next_pgbwrsel;
reg odd,by2;
reg checken1,checken2;

/* awr and bwr signals */
assign pgawr = testclk | pgawrsel;
assign pgbwr = testclk | pgbwrsel;
                     
/* test is active high */
always 
  begin: reset
   @(negedge test)
    begin
     disable clock;
      fork
       state = IDLE; 
       testmode = AWAR;
       pgup = 1'b1; 
       pgclr = 1'b0;
       pgdone = 1'b0;
       pgdinsel = 1'b0;
       pgawrsel = 1'b1;
       pgbwrsel = 1'b1;
      join
    end
  end  
always
 begin : logic_1
  @(testmode  or state)
   begin
    if ((testmode == ABWABR2) | ((state == WAIT) & (testmode == AWBR)))
      odd = 1'b1;
    else
      odd = 1'b0;

    if ((state == WAIT) | (testmode == ABWABR1) | (testmode == ABWABR2))
      by2 = 1'b1;
    else
      by2 = 1'b0;
  end
 end
always 
 begin : logic_2
  @(state or testmode or pgclr )
   begin
    if (!((state == WAIT) | (state == BACK0) | (state == BACK1)) & pgclr == 1'b1)
      begin
      case (testmode)
       AWAR:
             begin
              checken1 = 1'b0;
              checken2 = 1'b1;
             end
       BWAR:
             begin
              checken1 = 1'b0;
              checken2 = 1'b1;
             end
       AWBR:
             begin
              checken1 = 1'b1;
              checken2 = 1'b0;
             end
       BWBR:
             begin
              checken1 = 1'b1;
              checken2 = 1'b0;
             end
       ABWABR1:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
             end
       ABWABR2:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
             end
       endcase
     end
    else
      begin
        checken1 = 1'b1;
        checken2 = 1'b1;
      end
  end
 end


always 
  begin: clock
    wait(test)
    @(posedge testclk)
     fork
      state = #2 next_state;
      testmode = #2 next_testmode;
      pgdinsel = #2 next_pgdinsel;
      pgup = #2 next_pgup;
      pgclr = #2 next_pgclr;
      pgdone = #2 next_pgdone;
      pgawrsel = #2 next_pgawrsel;
      pgbwrsel = #2 next_pgbwrsel;
    join
  end

always
  begin : logic 
   @(state or count or testmode) 
      #3;
      next_pgclr = 1'b1;
      case (state)  
        IDLE:              
               begin
                 next_pgclr = 1'b1;
                 next_state = BACK0;   
                 next_testmode = AWAR;   
                 next_pgdinsel = 1'b0 ;
                 next_pgdone = 1'b0 ;
                 next_pgup = 1'b1 ;
                 next_pgawrsel = 1'b0;
                 next_pgbwrsel = 1'b1;
             end
        BACK0:       
              if (count == 1'b1 ) 
               begin
                next_state = FORWARD_WRITE1; 
		next_pgclr = 1'b0;
               end
        FORWARD_WRITE1:
              begin
                if (count == 1'b1) 
                 begin
                  next_pgdinsel = 1'b0;
                  if (testmode == AWBR)
                   begin
                    next_state = WAIT;
                    next_pgawrsel = 1'b1;
                   end
                  else if (testmode == BWAR)
                   begin
                    next_state = WAIT;
                    next_pgbwrsel = 1'b1;
                   end
                  else
                   begin
                    next_pgup = 1'b0;
                    next_state = REVERSE_WRITE0;                 
                   end
                 end
                else
                 begin
		   next_pgup = 1'b1;
                   next_pgdinsel = 1'b1;
                 end
              end
         WAIT:
           begin
            next_pgup = 1'b0;
            if (testmode == AWBR)
             next_pgawrsel = 1'b0;
            else
             next_pgbwrsel = 1'b0;
            if (pgdinsel)
             next_state = REVERSE_WRITE1;
            else
             next_state = REVERSE_WRITE0;
           end

         REVERSE_WRITE0:
             begin
                if (count == 1'b1)
                 begin
                  next_pgclr = 1'b0;
                  next_pgup = 1'b1;
                  next_pgdinsel = 1'b1;
                  next_state = BACK1;
                 end
		else
		 begin
		  next_pgup = 1'b0;
		  next_pgdinsel = 1'b0;
		 end
              end
        BACK1:       
             begin
              if (count  == 1'b1) 
               begin
                next_state = FORWARD_WRITE0; 
		next_pgclr = 1'b0;
               end
	     end
        FORWARD_WRITE0:
              begin
                if (count == 1'b1)
                 begin
                  next_pgdinsel = 1'b1;
                  if ( testmode == BWAR)
                   begin
                    next_state = WAIT;
                    next_pgbwrsel = 1'b1;
                   end
                  else if (testmode == AWBR)
                   begin
                    next_state = WAIT;
                    next_pgawrsel = 1'b1;
                   end
                  else
                   begin
                    next_state = REVERSE_WRITE1;
                    next_pgup = 1'b0;
                   end
                 end
                else
                 begin
                  next_pgdinsel = 1'b0;
		  next_pgup = 1'b1;
                 end
              end
         REVERSE_WRITE1:
             begin
                if (count == 1'b1)
                 begin
                  next_pgup = 1'b1; 
		  next_pgdinsel = 1'b0;
                  case(testmode)
                  AWAR:
                    begin
	 	     next_testmode = BWBR;
	 	     next_state = BACK0;
	 	     next_pgawrsel = 1'b1;
	 	     next_pgbwrsel = 1'b0;
                      
                    end 
                  BWBR:
                    begin
	 	     next_testmode = AWBR;
	 	     next_state = BACK0;
	 	     next_pgawrsel = 1'b0;
	 	     next_pgbwrsel = 1'b1;

                    end 
                  AWBR:
                    begin
	 	     next_testmode = BWAR;
	 	     next_state = BACK0;
	 	     next_pgawrsel = 1'b1;
	 	     next_pgbwrsel = 1'b0;

                    end 
                  BWAR:
                    begin
	 	     next_testmode = ABWABR1;
	 	     next_state = BACK0;
	 	     next_pgawrsel = 1'b0;
	 	     next_pgbwrsel = 1'b0;

                    end 
                  ABWABR1:
                    begin
	 	     next_testmode = ABWABR2;
	 	     next_state = BACK0;

                    end 
                  ABWABR2:
                    begin
	             next_state = DONE;
	             next_pgdone = 1'b1;
	 	     next_pgawrsel = 1'b1;
	 	     next_pgbwrsel = 1'b1;
                    end 
                 endcase
              end
             end
	DONE: 
	   begin
	    next_pgclr = 1'b0;
           end

       endcase
   end


endmodule   

           
