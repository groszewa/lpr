/****************************************/
/*					*/
/*	Filename: bm_tb.v		*/
/*	Function: tests booth multiplier*/
/*	Last Edit: 3/18/2018		*/
/*	Owner: Travis Lenz		*/
/*					*/
/****************************************/
`timescale 1 ns / 100 ps


module bm_tb ();
//--------------------------------------------------------- // inputs to the DUT are reg type
parameter WIDTH = 4;

   reg clk;
   reg rst;
   reg [WIDTH-1:0] a;
   reg [WIDTH-1:0] b;
   wire [(WIDTH*2)-1:0] c;
   
//-------------------------------------------------------- // outputs from the DUT are wire type

//--------------------------------------------------------- // instantiate the Device Under Test (DUT)
// using named instantiation
bm_4b U1 ( .a(a),
        .b(b),
        .c(c),
        .rst(rst),
        .clk(clk)
);
//---------------------------------------------------------- // create a 50Mhz clock
always
    #10 clk = ~clk;   // every ten nanoseconds invert
//----------------------------------------------------------- // initial blocks are sequential and start at time 0
  initial
    begin
	
       $dumpfile ("bm_tb.dump");
       $dumpvars(0,bm_tb);
       
    $display($time, " << Starting the Simulation >>");

	clk = 1'b0;
	rst = 1'b1;
	a = 4'b0;
	b = 4'b0;
	//c = 8'b0;

#20
	rst = 1'b0;
	a   = 4'b0111;
	b   = 4'b0001;
    
                                  
    //#1000;
    //wait (a == 4'hF && b == 4'hF)
    #100
    $display($time, " << Simulation Complete >>");
    $stop; // stop the simulation
    //$finish; //stop similation and give control back to OS
  end // initial begin


//-------------------------------------------------------------- // This initial block runs concurrently with the other
// blocks in the design and starts at time 0

/*  integer i,j;		//Automatic test block
   
 initial begin
    $monitor($time, "a=%h, b=%h, cin=%b, s=%h, cout=%b", a, b, c, rst, clk);
    for(i=0;i<256;i=i+1) begin
	#10 a[15:8] = i[7:0];
	for(j=0;j<256;j=j+1) begin
		#10 b[15:8] = j[7:0];
	end
	cin = i[0];
    end
    
   
    
// always @ (posedge clk_50)
    //   a = a+1;
    // end


  end
*/

endmodule 