//
// read_port handles the read operation of a given port of a multi-port ram
//
module read_port(A,OEb,PDb);      
parameter numbits = 8;
parameter access_dly = 5;
parameter toes = 4;
parameter tpds = 3;
input [numbits-1:0] A;
input OEb,PDb;  

/* internally used events */
event check_oe_and_pd;

/* externally used events */
event read_strobe;          
event outz_strobe;
event outx_strobe;
event outpd_strobe;

/* externally accessed registers */
reg  [numbits-1 :0] raddr;
                                   
/* internally used registers */
reg a_changed, pd_changed, oe_changed;

//
// when there is an address change and the ram is active ,
// (ie. power-down is not active and output is enabled) a memory read
// is scheduled through a read_strobe event.
//
  always @(A)
    begin
       disable a_dout;
       a_changed =1;
    end

   always
    begin: a_dout
       wait(a_changed);
       #access_dly 
       -> check_oe_and_pd;
       a_changed = 0;
   end

   always @(check_oe_and_pd)
    begin
       if (OEb == 1'b0 && PDb == 1)
         mem_read(A);
    end         
    
//
// when there is a change on PDb (power-down mode), the following
// portion is actived.  when the ram is powered down the output goes
// to all 1's , through outpd_strobe.  And when it is inactiviated
// it forces a read_strobe.
//
 
   always @(PDb) 
    begin
     if (OEb == 1'b0)
        begin
         disable pd_dout;
         pd_changed = 1;
        end
    end
  
   always 
    begin: pd_dout
       wait (pd_changed)
       pd_changed = 0;
       if (PDb == 1'b0)
         #tpds -> outpd_strobe;
       else if (PDb == 1'b1)
          begin                
             raddr = A;
             #tpds -> read_strobe;
          end
       else
          #tpds -> outx_strobe;
    end
//
// When the OEb is enabled a read_strobe is generated and when it is
// disabled a outz_strobe is generated.   
//
    always @(OEb)
     begin
        disable oe_dout;
        oe_changed = 1;
     end    

    always 
     begin: oe_dout
         wait (oe_changed)
         oe_changed = 0;
         if (OEb == 1'b1)
           #toes -> outz_strobe;
         else if (OEb == 1'b0)
           begin
             if (PDb == 1'b1)
              begin
               raddr = A;
               #toes -> read_strobe;
              end
             else if (PDb == 1'b0)
               #toes -> outpd_strobe;
             else
               #toes -> outx_strobe;
           end
         else
           #toes -> outx_strobe;
     end 
     
//
// mem_read just sets the global raddr register and activiates a 
// read_strobe event
//                  

  task mem_read;
   input [numbits-1:0] A;
     begin
        raddr = A;
        -> read_strobe;
     end
  endtask

endmodule

//  end of read_port

