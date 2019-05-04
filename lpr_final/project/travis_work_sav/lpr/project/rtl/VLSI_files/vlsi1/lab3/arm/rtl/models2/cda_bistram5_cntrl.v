module cda_bistram5_cntrl(test,testclk,count,checken1,checken2,checken3,pgdinsel,pgclr,pgup,pgdone,odd,r1,r2,by2,pgawr,pgbwr);

parameter IDLE = 3'b000;
parameter BACK0 = 3'b001;
parameter FORWARD_WRITE1 = 3'b010;
parameter REVERSE_WRITE0 = 3'b011;
parameter BACK1 = 3'b100;
parameter FORWARD_WRITE0 = 3'b101;
parameter REVERSE_WRITE1 = 3'b110;
parameter DONE = 3'b111;

parameter W1R1   = 4'b0000;
parameter W1R2   = 4'b0001;
parameter W1R3   = 4'b0010;
parameter W2R1   = 4'b0011;
parameter W2R2   = 4'b0100;
parameter W2R3   = 4'b0101;
parameter WR1    = 4'b0110;
parameter WR2    = 4'b0111;
parameter WR3    = 4'b1000;
parameter WR4	 = 4'b1001;
parameter WR5	 = 4'b1010;
parameter WR6	 = 4'b1011;
input test;
input testclk;       
input count;
output checken1,checken2,checken3;
output pgclr,pgup,pgdone;
output  pgdinsel;
output odd,r1,r2,by2;
output pgawr,pgbwr;

reg  [2:0] state,next_state;
reg  [3:0] testmode,next_testmode;
reg pgdinsel,next_pgdinsel;               
reg pgclr,next_pgclr;
reg pgup,next_pgup;  
reg checken1;
reg checken2;
reg checken3;
reg pgdone,next_pgdone;
reg pgawrsel,next_pgawrsel;
reg pgbwrsel,next_pgbwrsel;
reg odd,by2;
reg r1,r2;

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
       testmode = W1R1;
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
 begin: logic_1
   @(testmode)
    begin
     if ((testmode == WR4) | (testmode == WR5) | (testmode == WR6))
       odd = 1'b1;
     else
      odd = 1'b0;

     if ((testmode == WR3) | (testmode == WR6))
       r1 = 1'b1;
     else
       r1 = 1'b0;

     if ((testmode == WR2) | (testmode == WR5))
       r2 = 1'b1;
     else
       r2 = 1'b0;

     if ((testmode == WR1) | (testmode == WR2) | (testmode == WR3)  |
      (testmode == WR4) | (testmode == WR5) | (testmode == WR6)) 
       by2 = 1'b1;
     else
       by2 = 1'b0;
    end
end

always
  begin: logic_2
  @(state or testmode or pgclr )
   begin
    if (!((state == BACK0) | (state == BACK1)) & (pgclr == 1'b1))
      begin
      case (testmode)
       W1R1:
             begin
              checken1 = 1'b0;
              checken2 = 1'b1;
              checken3 = 1'b1;
             end
       W1R2:
             begin
              checken1 = 1'b1;
              checken2 = 1'b0;
              checken3 = 1'b1;
             end
       W1R3:
             begin
              checken1 = 1'b1;
              checken2 = 1'b1;
              checken3 = 1'b0;
             end
       W2R1:
             begin
              checken1 = 1'b0;
              checken2 = 1'b1;
              checken3 = 1'b1;
             end
       W2R2:
             begin
              checken1 = 1'b1;
              checken2 = 1'b0;
              checken3 = 1'b1;
             end
       W2R3:
             begin
              checken1 = 1'b1;
              checken2 = 1'b1;
              checken3 = 1'b0;
             end
       WR1:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
              checken3 = 1'b0;
             end
       WR2:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
              checken3 = 1'b0;
             end
       WR3:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
              checken3 = 1'b0;
             end
       WR4:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
              checken3 = 1'b0;
             end
       WR5:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
              checken3 = 1'b0;
             end
       WR6:
             begin
              checken1 = 1'b0;
              checken2 = 1'b0;
              checken3 = 1'b0;
             end
       endcase
     end
    else
      begin
        checken1 = 1'b1;
        checken2 = 1'b1;
        checken3 = 1'b1;
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
      next_state = state;
      next_testmode = testmode;
      case (state)  
        IDLE:              
               begin
                 next_pgclr = 1'b1;
                 next_state = BACK0;   
//                 $display("move to state (BACK0)",$time);
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
//                $display("move to state (FORWARD_WRITE1)",$time);
		next_pgclr = 1'b0;
               end
        FORWARD_WRITE1:
              begin
                if (count == 1'b1) 
                 begin
                  next_pgup = 1'b0;
                  next_pgdinsel = 1'b0;
                  next_state = REVERSE_WRITE0;                 
//                  $display("move to state (REVERSE_WRITE0)",$time);
                 end
                else
                 begin
		   next_pgup = 1'b1;
                   next_pgdinsel = 1'b1;
                 end
              end
         REVERSE_WRITE0:
             begin
                if (count == 1'b1)
                 begin
                  next_pgclr = 1'b0;
                  next_pgup = 1'b1;
                  next_pgdinsel = 1'b1;
                  next_state = BACK1;
//                  $display("move to state (BACK1)",$time);
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
//                $display("move to state (FORWARD_WRITE0)",$time);
		next_pgclr = 1'b0;
               end
	     end
        FORWARD_WRITE0:
              begin
                if (count == 1'b1)
                 begin
                  next_state = REVERSE_WRITE1;
                  next_pgdinsel = 1'b1;
                  next_pgup = 1'b0;
//                  $display("move to state (REVERSE_WRITE1)",$time);
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
		  next_pgdinsel = 1'b0;
                  next_pgup = 1'b1; 
                  case(testmode)
                  W1R1:
                    begin
	 	     next_testmode = W1R2;
	 	     next_state = BACK0;
//                     $display("move to state (W1R2)",$time);
                    end 
                  W1R2:
                    begin
	 	     next_testmode = W1R3;
	 	     next_state = BACK0;
//                     $display("move to state (W1R3)",$time);
                    end 
                  W1R3:
                    begin
	 	     next_testmode = W2R1;
	 	     next_state = BACK0;
//                     $display("move to state (W2R1)",$time);

                    end 
                  W2R1:
                    begin
	 	     next_testmode = W2R2;
	 	     next_state = BACK0;
	 	     next_pgawrsel = 1'b1;
	 	     next_pgbwrsel = 1'b0;
//                     $display("move to state (W2R2)",$time);

                    end 
                  W2R2:
                    begin
	 	     next_testmode = W2R3;
	 	     next_state = BACK0;
	 	     next_pgawrsel = 1'b1;
	 	     next_pgbwrsel = 1'b0;
//                     $display("move to state (W2R3)",$time);
                    end 
                  W2R3:
                    begin
	 	     next_testmode = WR1;
	 	     next_state = BACK0;
	 	     next_pgawrsel = 1'b0;
	 	     next_pgbwrsel = 1'b0;
//                     $display("move to state (WR1)",$time);
                    end 
                  WR1:
                    begin
	 	     next_testmode = WR2;
	 	     next_state = BACK0;
//                     $display("move to state (WR2)",$time);

                    end 
                  WR2:
                    begin
	 	     next_testmode = WR3;
	 	     next_state = BACK0;
//                     $display("move to state (WR3)",$time);

                    end 
                  WR3:
                    begin
	 	     next_testmode = WR4;
	 	     next_state = BACK0;
//                     $display("move to state (WR4)",$time);

                    end 
                  WR4:
                    begin
	 	     next_testmode = WR5;
	 	     next_state = BACK0;
//                     $display("move to state (WR5)",$time);

                    end 
                  WR5:
                    begin
	 	     next_testmode = WR6;
	 	     next_state = BACK0;
//                     $display("move to state (WR6)",$time);

                    end 
                  WR6:
                    begin
	 	     next_state = DONE;
//                     $display("move to state (DONE)",$time);
	             next_pgdone = 1'b1;
                    end 
                 endcase
              end
             end
  	DONE:
	      begin
	       next_pgclr = 1'b0;
	       next_pgawrsel = 1'b1;
	       next_pgbwrsel = 1'b1;
	      end
       endcase
   end


endmodule   

           
