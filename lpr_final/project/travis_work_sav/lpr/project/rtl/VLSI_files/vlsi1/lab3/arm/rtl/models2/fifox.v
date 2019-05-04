//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/
// Behavior model for the FIFOX
// Author: Hossein Ahmadnia Jan 1992

  /// comptype "fifo";
  ///"words"     	:INT	:WORDS;
  ///"bits"     	:INT	:N;
  ///"BUFFER_SIZE"	:INT	:1;
  ///"export"    	:INT	:1;

module  fifox(DIN,RESET,SI,SLEEPER,SO, DETECT1,FOUT,IREADY,OREADY,DOUT);

	parameter  N = 4;
	parameter  WORDS = 4;

	parameter  int_shift_dly = 5;
	parameter  si_ir_dly = 3;
	parameter  si_ir_lh_dly = 3;
	parameter  so_or_dly = 3;
	parameter  so_or_lh_dly = 3;
	parameter  si_fout_dly = 3;
	parameter  so_fout_dly = 3;
	parameter  rst_ir_dly = 4;
	parameter  rst_or_dly = 4;
	parameter  rst_out_dly = 4;
	parameter  rst_fout_dly = 4;
	parameter  so_out_dly = 4;
	parameter  first_word_dly = 2;

/*
    4x4 fifo typical delays


 setup_time_dly		INT	267
   si_ir_dly		INT	2805
   si_ir_lh_dly		INT	5052
   si_fout_dly		INT	2742
   so_or_dly		INT	2848
   so_or_lh_dly		INT	4768
   so_out_dly		INT	2684
   so_fout_dly		INT	2859
   rst_ir_dly		INT	1093
   rst_or_dly		INT	1535
   rst_out_dly		INT	730
   rst_fout_dly		INT	1373
   int_shift_dly		INT	3186
*/
	input [N-1:0] DIN;
	input SI,SO,RESET,SLEEPER;
	output [N-1:0] DOUT;
	output [WORDS-1 : 0] FOUT;
	output OREADY,IREADY,DETECT1;

	reg [WORDS-1 : 0] FOUT,tFOUT;
	reg [N-1 :0 ] DOUT;
	reg OREADY,IREADY,DETECT1;
	reg enable_shift;
	reg [N-1:0] mem [WORDS-1 :0], aword;
	reg data_setup_flag;
	reg freeze;
        wire [127:0] DIN_tcheck = DIN;

integer i;
integer llimit,ulimit;
integer rindex,windex,numwords;
initial
  begin
     llimit=0;
     ulimit=0;
     enable_shift = 0;
     numwords = 0;
     data_setup_flag = 0;
     rindex = 0;
     windex = 0;
     freeze = 1'b1;
  end
always @(negedge RESET)
   begin :reset_fifo

     rindex = 0;
     windex = 0;
     numwords = 0;
     disable shift;
     disable si_ph;
     disable so_ph;
     disable so_pl;
     enable_shift = 0;
     freeze = 1'b1;

   if (RESET == 1'b0)
    begin
     fork
       DOUT= #rst_out_dly 'bx;
       FOUT= #rst_fout_dly 0;
       IREADY  = #rst_ir_dly 1;
       OREADY  = #rst_or_dly 0;

      forever
        @(posedge RESET)
	  begin
	   if (RESET == 1'b1)
	    begin
	     freeze = 1'b0;
             disable reset_fifo;
	    end
	 end
    join
   end
  else
      $display("(ERROR) %m unknown value detected on the RESET pin");
 end

always @(SI )
  begin
      if (RESET == 1'b1 && SI === 1'bx && IREADY == 1) 
	begin // fifo can take more data and SI goes x
	  IREADY = 1'bx;
	  OREADY = 1'bx;
          FOUT ='bx; 
	  DOUT = 'bx;
	  numwords = 0;
	  rindex = 0;
	  windex = 0;
	  $display("(ERROR) %m detected unknown value on SI pin.");
	  $display("(ERROR) %m Must reset the fifo to put it in a known state");
	  freeze = 1'b1;
	  // the following processes have wait statements and should be disabled
          disable si_ph;
          disable so_ph;
          disable so_pl;
	end
 end
always @(SO )
  begin
      if (RESET == 1'b1 && SO === 1'bx && OREADY == 1) 
	begin // fifo has something in it and SO goes x
	  OREADY = 1'bx;
	  IREADY = 1'bx;
          FOUT ='bx; 
	  DOUT = 'bx;
	  numwords = 0;
	  rindex = 0;
	  windex = 0;
	  $display("(ERROR) %m detected unknown value on SO pin.");
	  $display("(ERROR) %m Must reset the fifo to put it in a known state");
	  freeze = 1'b1;
	  // the following processes have wait statements and should be disabled
          disable si_ph;
          disable so_ph;
          disable so_pl;
	end
 end
always @(negedge SI or posedge RESET)

  begin
    #0;
    if (SI == 1'b0 && RESET == 1'b1 && ~freeze)
         if (numwords != WORDS)
           enable_shift=1;
  end

always @(posedge SI or posedge RESET)
     begin: si_ph
      #0;
      if (SI == 1'b1 && RESET == 1'b1 && ~freeze)
       begin
         fork
         #si_fout_dly    FOUT[0] = 1;
         begin
          wait (IREADY == 1);
           #si_ir_dly      IREADY = 0;
         end

         begin
          wait (IREADY ==1);
           if (data_setup_flag ==0)
             mem[windex] = DIN;
           else
            mem[windex] = 'bx;
            data_setup_flag = 0;
            windex = (windex + 1) % WORDS;
            numwords = numwords + 1;
//            $display( "SI pin handler new windex = %d numwords=%d, time=%d",windex,numwords,$time);
         end

         forever @(negedge SI)
             disable si_ph;
         join
       end
     end
always @(negedge SO or posedge RESET)

  begin: so_pl
   #0;
   if (SO == 1'b0 && RESET == 1'b1 && ~freeze)
    begin
         if ((FOUT[WORDS-2]) == 1)
           enable_shift = 1;

         fork

          if (numwords != 0)
           #so_or_lh_dly OREADY=1;

           begin
            wait (OREADY ==1);
             #so_out_dly DOUT = mem[rindex] ;
             rindex = (rindex + 1) % WORDS;
             numwords = numwords - 1;
//           $display( "SO pin handler new rindex = %d numwords=%d, time=%d",rindex,numwords,$time);
           end

        join
    end
  end

always @(posedge SO or posedge RESET)
     begin: so_ph
      #0;
      if (SO == 1'b1 && RESET == 1'b1 && ~freeze)
       begin
        fork
        begin
         wait (OREADY == 1);
          #so_or_dly      OREADY = 0;
        end

        #so_fout_dly    FOUT[WORDS-1] = 0;
        forever @(negedge SO)
            disable so_ph;

        join
     end
   end

always @(SLEEPER)
  begin: sleeper_ph
    if (SLEEPER == 1)
         #first_word_dly DETECT1 =1 ;
    else if (SLEEPER == 0)
        disable sleeper_ph;
    else
         #first_word_dly DETECT1 =1'bx ;
  end
always @( windex or SLEEPER or DOUT)
 begin: detect_ph
    if (SLEEPER == 0 )
     begin
       DETECT1=0;
       #0;
	 if (freeze)
	    DETECT1 = 1'bx;
         else if(DOUT[N-1] == 1)
	      DETECT1 = 1;
	 else 
	  begin
	   for (i=rindex; i != windex ; i=(i+1)%WORDS)
	     begin
              aword = mem[i];
              if(aword[N-1] == 1)
               begin
                DETECT1 = 1;
                disable detect_ph ;
               end
	     end /* end of for loop */
          end /* end of else */
     end /* end of if sleeper */
 end /* end of detect_ph */


always @(FOUT )
  begin: check
      for(i=WORDS-1; i>=0; i=i-1)
         begin
          if (~FOUT[i] & FOUT[i-1])
            begin
                disable shift;
                enable_shift =1 ;
                 disable check;
            end
         end

end

 always @(negedge FOUT[0])
   begin
     if (RESET == 1'b1 && FOUT[0] == 1'b0)
 	  IREADY = 1;
   end


always @(posedge FOUT[WORDS-1])
   begin
      if (RESET == 1'b1 && FOUT[0] == 1'b0)
	  OREADY=1;
   end

always
   begin: shift
    wait (enable_shift == 1);
         enable_shift = 0;
    if (RESET == 1)
     begin
      #0;
      tFOUT = 0;
      if (SI ==1 )
          llimit=1;
      else
          llimit=0;

      if (SO ==1)
          ulimit=1;
      else
          ulimit = 0;

      for(i=WORDS-1; i>=0; i=i-1)
         if (i>0 && (i!= llimit ) && ~(i == WORDS-1 && ulimit == 1) && FOUT[i] ==0 && FOUT[i-1] == 1)
           begin
              tFOUT = tFOUT << 2;
              tFOUT[1] = 1;
              tFOUT[0] = 0;
              i= i-1;
           end
         else
           begin
              tFOUT = tFOUT << 1;
              tFOUT[0] = FOUT[i];
           end

      // $display("tFOUT is %b at time %d",tFOUT[WORDS-1:1],$time);
      if (ulimit==1 && llimit == 0 )
       FOUT[WORDS-2:0] = #int_shift_dly tFOUT[WORDS-2:0];
      else if (ulimit==0 && llimit == 1 )
       FOUT[WORDS-1:1] = #int_shift_dly tFOUT[WORDS-1:1];
      else if (ulimit==1 && llimit == 1 )
       FOUT[WORDS-2:1] = #int_shift_dly tFOUT[WORDS-2:1];
      else
       FOUT[WORDS-1: 0] = #int_shift_dly tFOUT[WORDS-1:0];
    end
 end

specify
        specparam
          data_setup_time=1;
	$setup(DIN_tcheck, edge[01]  SI, data_setup_time,data_setup_flag);
endspecify
endmodule
