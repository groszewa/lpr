 //		/*******************************************
//		*           Copyright (c) 1992             *
//		*   Cascade Design Automation Corporation  *
//		*           All Rights Reserved            *
//		*******************************************/

// Behavior module for the  RAM with tristate option
// Author Hossein Ahmadnia Jan 1992

  ///comptype      "ram";
  ///"words"     	:INT	:WORDS;
  ///"bits"      	:INT	:N;
  ///"io_type"     	:INT	:1;
  ///"bpc"      	:INT	:BPC;
  ///"floorplan"	:INT	:floorplan;
  ///"test_flag"	:INT	:0;
  ///"split_rail"	:INT	:split_rail;
  ///"BUFFER_SIZE"	:INT	:1;

module  ramoe (A,DIN,OE,WR, DOUT);

	parameter  N = 8;
	parameter  WORDS = 64;
	parameter  M = 6;
        parameter  BPC = 2;
        parameter  FLOORPLAN = 0;

	parameter  access_dly = 5;	// Access time from A()
	parameter  din_dout_dly = 5;	// Delay DIN() to DOUT()
	parameter  wr_dout_dly = 6;	// Delay WR low to DOUT()
	parameter  wr_to_ramcell = 4;	// Time to toggle ramcell()
	parameter  valid2z_dly	=2;	// output disable time
	parameter  z2valid_dly =2;	// output enable time


	input [M-1:0] A;
	input [N-1:0] DIN;
	input WR,OE;
	output [N-1:0] DOUT;

	reg    [N-1:0] DOUT,ramout;
	reg  [M-1:0] lastwrite_addr;
	reg wr_cycle_check;
	reg read_cycle_check;
	reg addr_hold_flag,addr_setup_flag;
	reg data_hold_flag,data_setup_flag;
	reg din_changed,a_changed;
	reg output_enable;
	reg [N-1:0] mem [WORDS-1:0];
	wire [255:0] DIN_tcheck = DIN;
	wire [11:0] A_tcheck = A;

always @(negedge WR)
 begin: write_block

  if (WR === 1'bx)
     disable write_block;

  mem[A] = 'bx;

  if (checkx_address(A))
     begin
      $display("(ERROR) %m: Writing into an unknown address at time ",$time);
      xout_memory;
      ramout = 'bx;
     end
 else

  fork
   begin: wr_dout
     ramout = #wr_dout_dly DIN;
   end
   begin: wr_mem
     mem[A] = #wr_to_ramcell DIN;
   end
   forever @(DIN)
    begin
     disable wr_dout;
     disable wr_mem;
     disable in_dout;
     disable din_mem;
     #0;
     mem[A] = 'bx;
     din_changed =1;
    end
   forever
     begin: in_dout
      wait (din_changed);
      ramout = #din_dout_dly DIN;
      din_changed = 0;
     end
   forever
     begin: din_mem
      wait (din_changed);
      mem[A] = #wr_to_ramcell DIN;
      din_changed = 0;
     end
    forever @(posedge WR or A)
     disable write_block;
   join
end
always @(A)
  begin
     if (WR ==1'b1)
      begin
       disable a_dout;
       a_changed =1;
      end
     else if (WR == 1'b0)
      begin
       $display("(ERROR): %m address A changed when WR was low at time ",$time);
        xout_memory;
        ramout = 'bx;
      end
  end
always @(posedge WR)
  lastwrite_addr = A;


  always
     begin: a_dout
       wait(a_changed);
        ramout = #access_dly mem[A];
        a_changed = 0;
     end

always @(WR or DIN or A)
 begin
   if (WR === 1'bx &&  !(checkinvalid_address(A)) && $time)
    begin
     if (DIN == mem[A])
      begin
       $display("(ERROR): %m WR transition to unknown (but DIN=MEM[A]) at time",$time);
      end
     else
      begin
       $display("(ERROR): %m WR transition to unknown and (DIN != MEM[A]) at time",$time);
       ramout = 'bx;
       mem[A] = 'bx;
      end
    end
   else if (WR === 1'bx && checkx_address(A) && $time)
     begin
      $display("(ERROR): WR and A are both unknown at time ",$time);
      ramout = 'bx;
      xout_memory;
     end
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
     disable write_block;
   for(i=0; i<=WORDS-1;i=i+1)
      mem[i] ='bx;
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

always @(posedge addr_hold_flag )
  begin
     mem[lastwrite_addr] = 'bx;
     #1 addr_hold_flag = 0;
   end
always @(posedge addr_setup_flag)
   begin
     disable write_block;
     mem[A] = 'bx;
     #1 addr_setup_flag = 0;
   end
always @(posedge data_hold_flag)
   begin
      mem[lastwrite_addr] = 'bx;
      #1 data_hold_flag =0;
   end
always @(posedge data_setup_flag)
   begin
      mem[A] = 'bx;
      ramout = 'bx;
      #1 data_setup_flag =0;
   end
always @(ramout)
   begin
       if (OE == 0 )
        begin
         disable output_something;
         DOUT = ramout;
        end
  end
always @(OE)
       begin
          disable output_something;
          output_enable =1 ;
       end
always
   begin: output_something
      wait(output_enable);
      output_enable = 0;
      if (OE == 0)
        DOUT = #z2valid_dly ramout;
      else if (OE == 1)
        DOUT = #valid2z_dly 'bz;
      else
	begin
 	 $display("(ERROR): %m unknown value for the output enable pin OE at time",$time);
         DOUT = #(0.5*valid2z_dly+0.5*z2valid_dly) 'bx;
        end
   end

specify
        specparam
          addr_hold_time =0, addr_setup_time=10,
          data_hold_time=0, data_setup_time=4,
          write_pulse_low=10, write_pulse_high=10;
	$hold(posedge WR,A_tcheck, addr_hold_time, addr_hold_flag);
	$setup(A_tcheck, negedge WR, addr_setup_time,addr_setup_flag);
	$setup(DIN_tcheck, posedge WR,data_setup_time, data_setup_flag);
	$hold(posedge WR, DIN_tcheck, data_hold_time,data_hold_flag);
	$width(negedge WR, write_pulse_low, 0, wr_cycle_check);
	$width(posedge WR, write_pulse_high, 0, read_cycle_check);

   endspecify
endmodule
