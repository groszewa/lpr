module mpram_5r1wp(DIN0,OE0BAR,OE1BAR,OE2BAR,OE3BAR,OE4BAR,PDBAR,RAD0,RAD1,RAD2,
                   RAD3,RAD4,WAD0,WE0BAR,DOUT0,DOUT1,DOUT2,DOUT3,DOUT4);

parameter N = 4;
parameter WORDS = 32;
parameter M = 5;                         
parameter BPC = 1;
parameter TACC = 5;
parameter TOES = 4;
parameter TPDS = 3;
parameter TWP = 7;
parameter TDS = 8;
parameter TWES = 10;
parameter TDIO = 9;
input [M-1:0] RAD0,RAD1,
                     RAD2,RAD3,RAD4,
                     WAD0;
input [N-1:0] DIN0;
input OE0BAR,OE1BAR,OE2BAR,OE3BAR,OE4BAR;
input WE0BAR;
input PDBAR;
output [N-1:0] DOUT0,DOUT1,DOUT2,DOUT3,DOUT4;
                     
/* internally used events */
event R0_update,R1_update,R2_update,R3_update,R4_update;

reg [N-1:0] mem [WORDS-1:0];
reg [N-1:0] DOUT0,DOUT1,DOUT2,DOUT3,DOUT4;

  read_port #(M,TACC,TOES,TPDS)
   R0 (.A (RAD0),.OEb(OE0BAR),.PDb(PDBAR)),
   R1 (.A (RAD1),.OEb(OE1BAR),.PDb(PDBAR)),
   R2 (.A (RAD2),.OEb(OE2BAR),.PDb(PDBAR)),
   R3 (.A (RAD3),.OEb(OE3BAR),.PDb(PDBAR)),
   R4 (.A (RAD4),.OEb(OE4BAR),.PDb(PDBAR));

  write_port #(N,M,TWP,TDS,TWES,TDIO)
   W0 (.WEb(WE0BAR),.Din(DIN0),.Addr(WAD0));


always 
 begin
  fork

   /*   memory reads  */
   forever @(R0.read_strobe or R0_update) 
    begin
      if (checkinvalid_address(RAD0))
       begin
        $display("(ERROR):%m Reading from an invalid address on port0 at time",$time);
	DOUT0 = 'bx;
       end
      else
       DOUT0 = mem[R0.raddr];
    end
   forever @(R1.read_strobe or R1_update) 
    begin
      if (checkinvalid_address(RAD1))
       begin
        $display("(ERROR):%m Reading from an invalid address on port1 at time",$time);
	DOUT1 = 'bx;
       end
      else
       DOUT1 = mem[R1.raddr];
    end
   forever @(R2.read_strobe or R2_update) 
    begin
      if (checkinvalid_address(RAD2))
       begin
        $display("(ERROR):%m Reading from an invalid address on port2 at time",$time);
	DOUT2 = 'bx;
       end
      else
       DOUT2 = mem[R2.raddr];
    end
   forever @(R3.read_strobe or R3_update) 
    begin
      if (checkinvalid_address(RAD3))
       begin
        $display("(ERROR):%m Reading from an invalid address on port3 at time",$time);
	DOUT3 = 'bx;
       end
      else
       DOUT3 = mem[R3.raddr];
    end
   forever @(R4.read_strobe or R4_update) 
    begin
      if (checkinvalid_address(RAD4))
       begin
        $display("(ERROR):%m Reading from an invalid address on port4 at time",$time);
	DOUT4 = 'bx;
       end
      else
       DOUT4 = mem[R4.raddr];
    end

   /* outputs disabled */
   
    forever @(R0.outz_strobe)
      DOUT0 = 'bz;
    forever @(R1.outz_strobe)
      DOUT1 = 'bz;
    forever @(R2.outz_strobe)
      DOUT2 = 'bz;
    forever @(R3.outz_strobe)
      DOUT3 = 'bz;
    forever @(R4.outz_strobe)
      DOUT4 = 'bz;

   /* output powered down */ 
 
    forever @(R0.outpd_strobe)
      DOUT0 = ~(0);
    forever @(R1.outpd_strobe)
      DOUT1 = ~(0);
    forever @(R2.outpd_strobe)
      DOUT2 = ~(0);
    forever @(R3.outpd_strobe)
      DOUT3 = ~(0);
    forever @(R4.outpd_strobe)
      DOUT4 = ~(0);     


   /* unstable address */
      forever @(W0.addr_unstable)
       begin
	xout_memory;
        update_out;
       end

   /*  memory write */  
      forever @(W0.wr_strobe)
       begin
	if (checkx_address(WAD0))
	 begin
	  $display("(ERROR):%m Writing to an unknown address from port0 at time",$time);
	  $display("(ERROR):%m Writing X to all address locations at time ",$time);
	  xout_memory;
	  update_out;
         end
        else if (checkinvalid_address(WAD0))
	 begin
	  $display("(ERROR):%m Writing to an invalid address from port0 at time",$time);
	  $display("(ERROR):%m No write occured. ");
	 end
        else
         mem[W0.waddr] = W0.wdata;    
      end
    /* write modified read */

      forever @(W0.read_strobe)
           update_out;    

    join
  end
task update_out;    
              if (PDBAR == 1'b1)
               begin
                if (OE0BAR == 1'b0)
                  ->  R0_update;
                if (OE1BAR == 1'b0)
                  ->  R1_update;
                if (OE2BAR == 1'b0)
                  ->  R2_update;
                if (OE3BAR == 1'b0)
                  ->  R3_update; 
                if (OE4BAR == 1'b0)
                  ->  R4_update; 
               end
endtask         

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
endmodule
