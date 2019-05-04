`timescale 1 ns / 100 ps


module dsc_mac_tb ();
//--------------------------------------------------------- // inputs to the DUT are reg type
   reg clk_50;
   reg en;
   reg rst;

   reg en_c;
   

   reg [3:0] input_bin_a, input_bin_b;
   reg [7:0] input_bin_c;
   
   
   
   
//-------------------------------------------------------- // outputs from the DUT are wire type
   //wire [3-1  :0] ctr3_out;
   //wire           ctr3_overflow;
   //
   //wire [2-1  :0] ctr2_out;
   //wire           ctr2_overflow;
   wire [3:0] ctr4_out_a,ctr4_out_b;
   wire       ctr4_overflow_a,ctr4b_overflow_b,ctr_overflow_c;

   
   
   wire           sn_out_a,sn_out_b,sn_out_c,sn_mul_out;

   wire [7:0]     bin_out;
   wire           bin_out_overflow;
   wire           start_add,op_end;

   wire           sn_add_out;
          
   
   
   
   
   

   
//--------------------------------------------------------- // instantiate the Device Under Test (DUT)
// using named instantiation



//counter #(
//   .WIDTH (4)
//) dut_ctr4 (
//  .clk(clk_50),
//  .rst(rst),
//  .en(en),
//  .out(ctr4_out),
//  .overflow(ctr4_overflow)
//);
//
//
//   //comparator2 dut_comp2 ( .a(input_bin), .b(ctr2_out), .y(sn_out));
//
//   comp_4b     dut_comp4 (.a(input_bin), .b(ctr4_out), .a_gt_b(sn_out));

//bin2stoch a   
prg_4b dut_prg4b_a (
  .clk(clk_50),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_a),
  .sn_out(sn_out_a),
  .ctr_overflow(ctr4_overflow_a)         
);

//bin2stoch b
prg_4b dut_prg4b_b (
  .clk(ctr4_overflow_a),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_b),
  .sn_out(sn_out_b),
  .ctr_overflow(ctr4_overflow_b)         
);

//control counter
counter #(
  .WIDTH (1)
) control (
  .clk(ctr4_overflow_b),
  .rst(rst),
  .en(en),
  .out(start_add),
  .overflow(op_end)
);
           

//multiplier circuit
det_stoch_mul dut_mul (
  .a(sn_out_a),
  .b(sn_out_b),
  .y(sn_mul_out)
);

prg_8b dut_prg8b_c (
  .clk(clk_50),
  .rst(rst),
  .en(en_c),
  .bin_in(input_bin_c),
  .sn_out(sn_out_c),
  .ctr_overflow(ctr8_overflow_c)         
);

det_stoch_scale_add dut_adder (
  .a(sn_mul_out),
  .b(sn_out_c),
  .s(start_add),
  .y(sn_add_out)
);

                       
//stoch2bin out
counter #(
  .WIDTH (8)
) stoch2bin_out (
  .clk(clk_50),
  .rst(rst),
  .en(sn_add_out),
  .out(bin_out),
  .overflow(bin_out_overflow)
);
                 




   

   
//---------------------------------------------------------- // create a 50Mhz clock
always
    #10 clk_50 = ~clk_50;   // every ten nanoseconds invert
//----------------------------------------------------------- // initial blocks are sequential and start at time 0
  initial
    begin

       $dumpfile ("dsc_mac_tb.dump");
       $dumpvars(0,dsc_mac_tb);
       
    $display($time, " << Starting the Simulation >>");
       clk_50 = 0;
       en = 0;
       en_c = 0;
       
       rst = 1;
       input_bin_a = 0;
       input_bin_b = 0;
       input_bin_c = 0;
       
       
       
       #10
       rst = 0;

       #10
       en  = 1;
       input_bin_a = 5;
       input_bin_b = 2;
       input_bin_c = 50;
       

       wait(ctr4_overflow_b == 1);
       en_c = 1;
       

       

         

       wait(op_end == 1);
       
       //#10

       

       
       
       
       
       
       
       
       
       
                                  
    //wait ((ctr3_out == 8'hff))
    
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
    $monitor($time, " rst=%b, en=%b, bin_a=%h, bin_b=%h, bin_c=%h, ctr_a=%h, ctr_b=%h, ov_a=%b, ov_b=%b, start_add=%b, sn_a=%b, sn_b=%b, mul_out=%b, ctr_c=%h, sn_c=%b, add_out=%h, bin_out=%h"
             ,rst
             ,en
             ,input_bin_a
             ,input_bin_b
             ,input_bin_c
             ,dsc_mac_tb.dut_prg4b_a.ctr4_out
             ,dsc_mac_tb.dut_prg4b_b.ctr4_out
             ,ctr4_overflow_a
             ,ctr4_overflow_b
             ,start_add
             ,sn_out_a
             ,sn_out_b
             ,sn_mul_out
             ,dsc_mac_tb.dut_prg8b_c.ctr8_out
             ,sn_out_c
             ,sn_add_out
             ,bin_out);
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