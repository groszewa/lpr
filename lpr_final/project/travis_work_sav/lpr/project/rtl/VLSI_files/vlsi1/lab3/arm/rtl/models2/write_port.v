//  
// write_port handles the write operation associate with a given port
//
module write_port(WEb,Din,Addr,WEb1,Addr1,WEb2,Addr2);    
parameter numbits = 0;
parameter numaddr = 0;

// timing parameters
parameter twp = 7 ;
parameter tds = 8 ;
parameter twes = 10;
parameter tdio = 9; 

input WEb,WEb1,WEb2;
input [numbits-1 :0]Din;
input [numaddr-1:0] Addr,Addr1,Addr2;  
/* externally used event */
event wr_strobe;       
event read_strobe;  

/* internally used events */
event addr_unstable;
event new_din_strobe;
event new_wr_strobe;         
event restart_wr;

/* internally used register */
reg din_changed;
/* externally used register */
reg [numaddr-1:0] waddr;
reg [numbits-1:0] wdata;
              
//
// When a negative edge of WE occurs a write cycle is initiated. Also,
// a change in the input data while WE is low causes new data to be
// written into the selected address. 
//
   always @(negedge WEb or restart_wr)
      begin: write_block
       mem_write(Addr,'bx);
       if (WEb === 1'bx)
	begin
         $display("(ERROR) %m: Unknown value detected on WEb at time ",$time);
        end
       else
        fork
          begin: wr_mem 
            #twp mem_write(Addr,Din);
          end
          begin: wr_wr
            #twes -> read_strobe;
          end
  
          forever @(Din)
            begin
              disable wr_mem;
              disable din_mem;   
              disable wr_wr;
              mem_write(Addr,'bx);
              din_changed = 1;
            end
 
          forever 
            begin: din_mem
              wait(din_changed) 
              fork
                #tdio -> read_strobe;
                #tds mem_write(Addr,Din);
              join
              din_changed = 0;
            end

          forever @(posedge WEb or Addr)
          disable write_block;
        join
      end   
        
//
// If address changes while WEb is low than address stable violation has occured
//
   always @(Addr)
     begin
       if (WEb !== 1'b1)
         begin
           $display("(ERROR) %m: Address of port changed while write-enable was active or unknown. Writing unknown to all addresses at time ",$time); 
	   ->addr_unstable;
         end
     end
//
// memory_write just set the global address and data register and
// activiates a wr_strobe event.
//
  task mem_write;           
   input [numaddr-1:0 ] addr;
   input [numbits-1 : 0 ] data;

   begin
     wdata = data;
     waddr = addr;
     -> wr_strobe;
   end
  endtask    

  task concurrent_wr;
   reg  conc;

   forever @(negedge WEb)
      begin: concurrent_check
        fork
           @(posedge WEb)
              disable concurrent_check;
       
          assign conc = (WEb1 == 1'b0 & Addr == Addr1) 
                        | (WEb2 == 1'b0 & Addr == Addr2);

            forever @(posedge conc)  
            begin
              disable write_block;
              $display("(ERROR) %m: Concurrent write. mem[%h]='bx at time %d \n",Addr,$time);
              mem_write(Addr,'bx);
            end              
            forever @(negedge conc)
               ->restart_wr;
        join
      end
  endtask                           

  initial
    concurrent_wr;

endmodule

// end of write_port module

