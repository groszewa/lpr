module mpram_2r1w (DIN0,OE0BAR,OE1BAR,RAD0,RAD1,WAD0,WE0BAR,
		   DOUT0,DOUT1);
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
                     WAD0;
input [N-1:0] DIN0;
input OE0BAR,OE1BAR;
input WE0BAR;
output [N-1:0] DOUT0,DOUT1; 

/* internally used events */
event R0_update,R1_update;

reg [N-1:0] mem [WORDS-1:0];
reg [N-1:0] DOUT0,DOUT1;

  read_port #(M,TACC,TOES,TPDS)
   R0 (.A (RAD0),.OEb(OE0BAR),.PDb(1'b1)),
   R1 (.A (RAD1),.OEb(OE1BAR),.PDb(1'b1));

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

   /* outputs disabled */
   
    forever @(R0.outz_strobe)
      DOUT0 = 'bz;
    forever @(R1.outz_strobe)
      DOUT1 = 'bz;

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
  		begin
                  if (OE0BAR == 1'b0)
                   ->  R0_update;
                  if (OE1BAR == 1'b0)
                   ->  R1_update;
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
