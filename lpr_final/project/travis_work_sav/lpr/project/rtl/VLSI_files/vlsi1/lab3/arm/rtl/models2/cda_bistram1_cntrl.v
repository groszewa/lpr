
module cda_bistram1_cntrl(test,testclk,count,checken,pgdinsel,pgclr,pgup,pgdone);
parameter IDLE  = 3'b000;
parameter BACK0 = 3'b001;
parameter FORWARD_WRITE1 = 3'b010;
parameter REVERSE_WRITE0 = 3'b011;
parameter BACK1 = 3'b100;
parameter FORWARD_WRITE0 = 3'b101;
parameter REVERSE_WRITE1 = 3'b110;
parameter DONE = 3'b111;

input test;
input testclk;       
input count;
output checken;
output pgclr,pgup,pgdone;
output  pgdinsel;

reg  [2:0] state,next_state;
reg pgdinsel,next_pgdinsel;               
reg pgclr,next_pgclr;
reg pgup,next_pgup;  
reg checken,next_checken;
reg pgdone,next_pgdone;

                     
/* test is active high */
always 
  begin: reset
   @(negedge test)
    begin
     disable clock;
      fork
       state = IDLE; 
       pgup = 1'b1; 
       pgclr = 1'b0;
       pgdone = 1'b0;
       checken = 1'b0;
       pgdinsel = 1'b0;
      join
    end
  end  

always 
  begin: clock
    wait(test)
    @(posedge testclk)
     fork
      state = #2 next_state;
      checken = #2 next_checken;
      pgdinsel = #2 next_pgdinsel;
      pgup = #2 next_pgup;
      pgclr = #2 next_pgclr;
      pgdone = #2 next_pgdone;
    join
  end

always
  begin : logic 
   @(state or count) 
    #3;
      case (state)  
        IDLE:              
               begin
                 next_pgclr = 1'b1;
                 next_state = BACK0;   
//               $display("move to state (BACK0)");
                 next_checken =  1'b0;
                 next_pgdinsel = 1'b0 ;
                 next_pgdone = 1'b0 ;
                 next_pgup = 1'b1 ;
             end
        BACK0:       
              if (count == 1'b1 ) 
               begin
                next_state = FORWARD_WRITE1; 
//              $display("move to state (FORWARD_WRITE1)");
		next_pgclr = 1'b0;
               end
        FORWARD_WRITE1:
              begin
                if (count == 1'b1) 
                 begin
                  next_pgup = 1'b0;
                  next_pgdinsel = 1'b0;
                  next_state = REVERSE_WRITE0;                 
//                $display("move to state (REVERSE_WRITE0)");
                 end
                else
                 begin
		   next_pgclr = 1'b1;
                   next_pgdinsel = 1'b1;
		   next_checken = 1'b1;
                 end
              end
         REVERSE_WRITE0:
             begin
                if (count == 1'b1)
                 begin
                  next_pgclr = 1'b0;
                  next_pgup = 1'b1;
		  next_checken = 1'b0;
                  next_pgdinsel = 1'b1;
                  next_state = BACK1;
//                $display("move to state (BACK1)");
                 end
              end
        BACK1:       
             begin
              if (count  == 1'b1) 
               begin
                next_state = FORWARD_WRITE0; 
//              $display("move to state (FORWARD_WRITE0)");
		next_pgclr = 1'b0;
               end
              else
                next_pgclr = 1'b1;
	     end
        FORWARD_WRITE0:
              begin
                if (count == 1'b1)
                 begin
                  next_state = REVERSE_WRITE1;
                  next_pgdinsel = 1'b1;
                  next_pgup = 1'b0;
//                $display("move to state (REVERSE_WRITE1)");
                 end
                else
                 begin
		  next_pgclr = 1'b1;
                  next_pgdinsel = 1'b0;
		  next_checken = 1'b1;
                 end
              end
         REVERSE_WRITE1:
             begin
                if (count == 1'b1)
                 begin
		  next_checken = 1'b0;
                  next_state = DONE;
//                $display("move to state (DONE)");
                 end
              end
  	DONE:
	      begin
	       next_pgdone = 1'b1;
	       next_pgclr = 1'b0;
	      end
       endcase
   end


endmodule   

           
