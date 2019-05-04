//
//		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the dual port RAM

  ///comptype      "dualram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"io_type"     	:INT	:1;
  ///"bpc"      	:INT   	:BPC;
  ///"floorplan"	:INT	:FLOORPLAN;
  ///"test_flag"	:INT	:0;
  ///"split_rail"	:INT	:0;
  ///"BUFFER_SIZE"	:INT	:1;

module  dualramoe (A,ADIN,AOE,AWR,B,BDIN,BOE,BWR, ADOUT,BDOUT);

	parameter  N = 1; // Bits per word
	parameter  WORDS = 1;
	parameter  M = 1; // Address bus size
	parameter  BPC = 2;
	parameter  FLOORPLAN = 0;

	parameter  access_dly = 5;	// Access time from A()
	parameter  din_dout_dly = 4;	// Delay Din() to Dout()
	parameter  wr_dout_dly = 3;	// Delay Wr low to Dout()
	parameter  wr_to_ramcell = 2;	// Time to toggle ramcell()
	parameter  v2z_delay = 2;	// oe low to valid dout ()
	parameter  z2v_delay = 2;	// oe high to tristated dout ()

	input [M-1:0] A,B;
	input [N-1:0] ADIN,BDIN;
	input AWR,BWR,AOE,BOE;
	output [N-1:0] ADOUT,BDOUT;

	reg  [N-1:0] ADOUT,BDOUT;
	reg  [N-1:0] tADOUT,tBDOUT;

	reg  [M-1:0] alastread_addr,alastwrite_addr;
	reg  [M-1:0] blastread_addr,blastwrite_addr;
	reg aaddr_hold_flag,aaddr_setup_flag;
	reg adata_hold_flag,adata_setup_flag;
	reg baddr_hold_flag,baddr_setup_flag;
	reg bdata_hold_flag,bdata_setup_flag;
	reg adin_changed,bdin_changed;
	reg aa_changed, ba_changed;
	reg bdout_changed, adout_changed;
	reg [N-1:0] mem [WORDS-1:0];
	event aaddr_unstable_memory,baddr_unstable_memory;
	wire [9:0] A_tcheck =A;
	wire [9:0] B_tcheck =B;
	wire [127:0] ADIN_tcheck =ADIN;
	wire [127:0] BDIN_tcheck =BDIN;

always @(negedge  AWR)
 begin: awrite_block

  if (AWR === 1'bx)
     disable awrite_block;

  mem[A] = 'bx;

 if (checkx_address(A))
     begin
      $display("(ERROR) %m: Writing into an unknown address from port A at time ",$time);
      xout_memory;
      ADOUT = 'bx;
     end
 else
  fork
   begin: awr_dout
     tADOUT = #wr_dout_dly ADIN;
   end
   begin: awr_mem
     mem[A] = #wr_to_ramcell ADIN;
   end
   forever @(ADIN)
    begin
     disable awr_dout;
     disable awr_mem;
     disable ain_dout;
     disable adin_mem;
     #0;
     mem[A] = 'bx;
     adin_changed =1;
    end
   forever
     begin: ain_dout
      wait (adin_changed);
      tADOUT = #din_dout_dly ADIN;
      adin_changed = 0;
     end
   forever
     begin: adin_mem
      wait (adin_changed);
      mem[A] = #wr_to_ramcell ADIN;
      adin_changed = 0;
     end
    forever @(posedge AWR or A)
     disable awrite_block;

    forever @(negedge BWR or ADIN or BDIN)
     begin
       if ( (AWR == BWR) && (A==B) && (ADIN != BDIN))
        begin
         disable bwrite_block;
         disable awrite_block;
        end
     end
   join
end

always @(negedge BWR)
 begin: bwrite_block

  if (BWR === 1'bx)
     disable bwrite_block;

  mem[B] = 'bx;

 if (checkx_address(B))
   begin
     $display("(ERROR) %m: Writing into an unknown address from port B at time ",$time);
     xout_memory;
     tBDOUT = 'bx;
    end
 else 

  fork
   begin: bwr_dout
     tBDOUT = #wr_dout_dly BDIN;
   end
   begin: bwr_mem
     mem[B] = #wr_to_ramcell BDIN;
   end
   forever @(BDIN)
    begin
     disable bwr_dout;
     disable bwr_mem;
     disable bin_dout;
     disable bdin_mem;
     #0;
     mem[B] = 'bx;
     bdin_changed =1;
    end
   forever
     begin: bin_dout
      wait (bdin_changed);
      tBDOUT = #din_dout_dly BDIN;
      bdin_changed = 0;
     end
   forever
     begin: bdin_mem
      wait (bdin_changed);
      mem[B] = #wr_to_ramcell BDIN;
      bdin_changed = 0;
     end
    forever @(posedge BWR or B)
     disable bwrite_block;

    forever @(negedge AWR or ADIN or BDIN)
     begin
       if ( (AWR==BWR) && (A==B) && (ADIN != BDIN) )
        begin
         disable awrite_block;
         disable bwrite_block;
        end
     end
   join
end

always @(A)
  begin
     if (AWR ==1'b1)
      begin
       disable aa_dout;
       aa_changed =1;
      end
     else if (AWR == 1'b0)
      begin
       $display("(ERROR): %m address A changed when AWR was low at time ",$time);
        xout_memory;
        tADOUT = 'bx;
      end
     else if (checkx_address(A)) 
      begin
        xout_memory;
        tADOUT = 'bx;
        $display("(ERROR): %m address A and AWR are both unknown at time ",$time);
     end

  end
always @(B )

  begin
     if (BWR ==1'b1)
      begin
       disable ba_dout;
       ba_changed =1;
      end
     else  if (BWR == 1'b0)
      begin  
       $display("(ERROR): %m address B changed when BWR was low at time ",$time);
        xout_memory;
        tBDOUT = 'bx;
      end
     else if (checkx_address(B)) 
      begin
        xout_memory;
        tBDOUT = 'bx;
        $display("(ERROR): %m address B and BWR are both unknown at time ",$time);
     end
  end
always @(posedge AWR)
  alastwrite_addr = A;
always @(posedge BWR)
  blastwrite_addr = B;

  always
     begin: aa_dout
       wait(aa_changed);
        aa_changed = 0;
        if (checkx_address(A))
         begin
          tADOUT = 'bx;
          $display("(ERROR) %m: Reading from an unknown address on port A at time ",$time);
         end
        else if (checkinvalid_address(A))
         begin
          tADOUT ='bx;
          $display("(ERROR) %m: Reading from an address which doesn't exist on port A at time ",$time);
         end
        else if (checkx_address(alastread_addr) )
         begin
         tADOUT ='bx;
         $display("(NOTE) %m: Address changed from an unknown address to a known address on port A at time ",$time);
         end
        else
        tADOUT = #access_dly mem[A];
        alastread_addr = A;
     end

  always
     begin: ba_dout
       wait(ba_changed);
        ba_changed = 0;
        if (checkx_address(B))
         begin
          tBDOUT ='bx;
          $display("(ERROR) %m: Reading from an unknown address on port B at time ",$time);
         end
        else if (checkinvalid_address(B))
         begin
          tBDOUT = 'bx;
          $display("(ERROR) %m: Reading from an address which doesn't exist on port B at time ",$time);
         end
        else if (checkx_address(blastread_addr))
         begin
         tBDOUT = 'bx;
         $display("(NOTE) %m: Address changed from an unknown address to a known address on port B at time ",$time);
         end
        else
        tBDOUT = #access_dly mem[B];
        blastread_addr = B;
     end

always @(AWR or ADIN or A)
 begin
   if (AWR === 1'bx &&  !(checkinvalid_address(A)))
    begin
     if (ADIN == mem[A])
      begin
       $display("(ERROR): %m AWR transition to unknown (but ADIN=MEM[A]) at time",$time);
      end
     else
      begin
       $display("(ERROR): %m AWR transition to unknown and (ADIN != MEM[A]) at time",$time);
       tADOUT = 'bx;
       mem[A] = 'bx;
      end
    end
   else if (AWR === 1'bx && checkx_address(A))
     begin
      $display("(ERROR): AWR and A are both unknown at time ",$time);
      tADOUT = 'bx;
      xout_memory;
     end
 end

always @(BWR or BDIN or B)
 begin
   if (BWR === 1'bx &&  !(checkinvalid_address(B)))
    begin
     if (BDIN == mem[B])
      begin
       $display("(ERROR): %m BWR transition to unknown (but BDIN=MEM[B]) at time",$time);
      end
     else
      begin
       $display("(ERROR): %m BWR transition to unknown and (BDIN != MEM[B]) at time",$time);
       tBDOUT = 'bx;
       mem[B] = 'bx;
      end
    end
   else if (BWR === 1'bx && checkx_address(B))
     begin
      $display("(ERROR): BWR and B are both unknown at time ",$time);
      tBDOUT = 'bx;
      xout_memory;
     end
 end


always @ (AWR or BWR or ADIN or BDIN )
     begin: write_same
          if ( (AWR==0 && BWR==0) && (A===B) && !checkinvalid_address(A) )
            begin
             if (ADIN == BDIN) 
               $display("(WARNING): %m Writing same data to the same address from both A and B ports at time",$time);
             else 
              begin
               $display("(ERROR): %m Writing different data to the same address from both A and B ports at time",$time);
               mem[A] = 'bx;
	       tADOUT = 'bx;
	       tBDOUT = 'bx;
              end
            end
          else
            disable write_same;
      end      

always @( BOE)
    begin
       disable bdout_block;
       bdout_changed = 1;
    end

always @(tBDOUT)
    begin
	if (BOE == 1'b0)
	begin
	 bdout_changed = 0;
	 disable bdout_block;
	 BDOUT = tBDOUT;
	end
    end

always
 begin: bdout_block
   wait(bdout_changed);
       if (BOE == 0)
          BDOUT = #( 0.5*z2v_delay +0.5*v2z_delay) tBDOUT;
       else if (BOE == 1'b1)
          BDOUT = #(0.5*z2v_delay + 0.5*v2z_delay)  'bz;
       else 
       begin
 	$display("(ERROR): %m unknown value for the output enable pin BOE at time",$time);
        BDOUT = #(0.5*z2v_delay + 0.5*v2z_delay)  'bz;
       end
     bdout_changed = 0;
    end  
 
always @(AOE)
    begin
	disable adout_block;
	adout_changed = 1;
    end

always @(tADOUT)
    begin
	if (AOE == 1'b0)
	 begin
	  adout_changed = 0;
	  disable adout_block;
	  ADOUT = tADOUT;
	 end
    end

always
 begin: adout_block
  wait(adout_changed);
       if (AOE == 0)
          ADOUT = #z2v_delay tADOUT;
       else if (AOE == 1'b1)
          ADOUT = #v2z_delay 'hz;
       else
       begin
 	$display("(ERROR): %m unknown value for the output enable pin AOE at time",$time);
        ADOUT = #(0.5*z2v_delay + 0.5*v2z_delay)  'bz;
       end
     adout_changed = 0;
    end

always @(posedge aaddr_hold_flag )
  begin
     mem[alastwrite_addr] = 'bx;
     #1 aaddr_hold_flag = 0;
   end
always @(posedge aaddr_setup_flag)
   begin
     disable awrite_block;
     mem[A] = 'bx;
     #1 aaddr_setup_flag = 0;
   end
always @(posedge adata_hold_flag)
   begin
      mem[alastwrite_addr] = 'bx;
      if (alastwrite_addr == A)
        tADOUT = 'hx;
      #1 adata_hold_flag =0;
   end
always @(posedge adata_setup_flag)
   begin
      mem[A] = 'bx;
      tADOUT = 'bx;
      #1 adata_setup_flag =0;
   end

always @(posedge baddr_hold_flag )
  begin
     mem[blastwrite_addr] = 'bx;
     #1 baddr_hold_flag = 0;
   end
always @(posedge baddr_setup_flag)
   begin
     disable bwrite_block;
     mem[B] = 'bx;
     #1 baddr_setup_flag = 0;
   end
always @(posedge bdata_hold_flag)
   begin
      mem[blastwrite_addr] = 'bx;
      if (blastwrite_addr == B)
        tBDOUT = 'hx;
      #1 bdata_hold_flag =0;
   end
always @(posedge bdata_setup_flag)
   begin
      mem[B] = 'bx;
      tBDOUT = 'bx;
      #1 bdata_setup_flag =0;
   end

function checkx_address;
// check for unknown value on the given address bus
  input [M-1:0] addr;
    if (|(addr & ~addr) === 1'bx)
     checkx_address = 1'b1;
    else 
     checkx_address = 1'b0;
endfunction

task xout_memory;
// put x in all of the memory locations 
   integer i;

    begin
     for(i=0; i<=WORDS-1;i=i+1)
       mem[i] ='bx;
     disable awrite_block;
     disable bwrite_block;
    end

endtask

function checkinvalid_address;
// address in range and known
  input [M-1:0] addr;
  
  if (!checkx_address(addr))
   begin
     if (addr <=WORDS-1)
        checkinvalid_address = 1'b0;
     else
        checkinvalid_address = 1'b1;
   end
  else
        checkinvalid_address = 1'b1;
endfunction


specify
        specparam
          addr_hold_time =0, addr_setup_time=5,
          data_hold_time=0, data_setup_time=5,
          write_pulse_low=10, write_pulse_high=10;
	$hold(posedge AWR,A_tcheck, addr_hold_time, aaddr_hold_flag);
	$setup(A_tcheck, negedge AWR, addr_setup_time,aaddr_setup_flag);
	$setup(ADIN_tcheck, posedge AWR,data_setup_time, adata_setup_flag);
	$hold(posedge AWR, ADIN_tcheck, data_hold_time,adata_hold_flag);

	$hold(posedge BWR,B_tcheck, addr_hold_time, baddr_hold_flag);
	$setup(B_tcheck, negedge BWR, addr_setup_time,baddr_setup_flag);
	$setup(BDIN_tcheck, posedge BWR,data_setup_time, bdata_setup_flag);
	$hold(posedge BWR, BDIN_tcheck, data_hold_time,bdata_hold_flag);


      	$width(negedge BWR, write_pulse_low);
	$width(posedge BWR, write_pulse_high);

	$width(negedge AWR, write_pulse_low);
	$width(posedge AWR, write_pulse_high);


   endspecify
endmodule
