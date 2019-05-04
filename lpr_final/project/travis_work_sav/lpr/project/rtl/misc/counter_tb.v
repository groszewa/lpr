`timescale 1 ns / 100 ps


module counter_tb ();
//--------------------------------------------------------- // inputs to the DUT are reg type
   reg clk_50;
   reg en;
   reg rst;
   
   
//-------------------------------------------------------- // outputs from the DUT are wire type
   wire [32-1 :0] ctr32_out;
   wire [16-1 :0] ctr16_out;
   wire [8-1  :0] ctr8_out;
   wire [4-1  :0] ctr4_out;

   
//--------------------------------------------------------- // instantiate the Device Under Test (DUT)
// using named instantiation

counter #(
   .WIDTH (32)
) dut_ctr32 (
  .clk(clk_50),
  .rst(rst),
  .en(en),
  .out(ctr32_out)
);

counter #(
   .WIDTH (16)
) dut_ctr16 (
  .clk(clk_50),
  .rst(rst),
  .en(en),
  .out(ctr16_out)
);

counter #(
   .WIDTH (8)
) dut_ctr8 (
  .clk(clk_50),
  .rst(rst),
  .en(en),
  .out(ctr8_out)
);

counter #(
   .WIDTH (4)
) dut_ctr4 (
  .clk(clk_50),
  .rst(rst),
  .en(en),
  .out(ctr4_out)
);

   

   
//---------------------------------------------------------- // create a 50Mhz clock
always
    #10 clk_50 = ~clk_50;   // every ten nanoseconds invert
//----------------------------------------------------------- // initial blocks are sequential and start at time 0
  initial
    begin

       $dumpfile ("counter_tb.dump");
       $dumpvars(0,counter_tb);
       
    $display($time, " << Starting the Simulation >>");
       clk_50 = 0;
       en = 0;
       rst = 1;
       #50
       rst = 0;
       #20

         
       en = 1;
       
       
       
       
       
       
       
                                  
    wait ((ctr8_out == 8'hff))
    
    //wait ({a,b,par,c} == 10'b1111111111)
    //#1000
    $display($time, " << Simulation Complete >>");
    //$stop; // stop the simulation
    $finish; //stop similation and give control back to OS
  end // initial begin


//-------------------------------------------------------------- // This initial block runs concurrently with the other
// blocks in the design and starts at time 0
   //integer i;
   //reg    parity_check;
   //reg    c_one_hot;
   //reg    input_good;
   
   
   
   
 initial begin
    //$monitor($time, " A=%b%b%b, B=%b%b%b, par=%b C=%b%b%b, X=%b%b%b, XC=%b, XE=%b%b, Y=%b%b%b, YC=%b YE=%b%b",a[2],a[1],a[0],b[2],b[1],b[0],par,c[2],c[1],c[0],x[2],x[1],x[0],xc,xe[1],xe[0],y[2],y[1],y[0],yc,ye[1],ye[0]);
    $monitor($time, " rst=%b, en=%b, ctr32_out=%h, ctr16_out=%h, ctr8_out=%h, ctr4_out=%h",rst,en,ctr32_out,ctr16_out,ctr8_out,ctr4_out);
    //$monitor($time, "outputs: x0=%b, x1=%h, x2=%b, xc=%b, xe0=%b, xe1=%b, y0=%b, y1=%b, y2=%b, yc=%b, ye0=%b, ye1=%b",x0,x1,x2,xc,xe0,xe1,y0,y1,y2,yc,ye0,ye1);
    ///for(i=0;i<1024;i=i+1) begin
    ///   #10 a   =  i[9:7];
    ///       b   =  i[6:4];
    ///       par =  i[3];
    ///       c   =  i[2:0];
    ///   
    ///   parity_check = a[2]^a[1]^a[0]^b[2]^b[1]^b[0]^par;
    ///   c_one_hot = (c==4||c==2||c==1);
    ///   input_good = parity_check & c_one_hot;       
    ///end
    
    
 
   
    
    
    
// always @ (posedge clk_50)
    //   a = a+1;
    // end
     
  end
//-------------------------------------------------------------- // The load_count task loads the counter with the value passed
//  task load_count;
//     input [3:0] load_value;
//     begin
//@(negedge clk_50);
//$display($time, " << Loading the counter with %h >>", load_value); load_l = 1’b0;
//count_in = load_value;
//@(negedge clk_50);
//load_l = 1’b1;
//     end
//  endtask //of load_count
endmodule //of cnt16_tb