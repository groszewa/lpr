`timescale 1 ns / 100 ps


module pipe_mul_tb ();
//--------------------------------------------------------- // inputs to the DUT are reg type
   reg clk_50;
   reg en;
   reg rst;

   reg [3:0] input_bin_a, input_bin_b;

   //reg       wrap_mode;
   
   reg       wrap_mode_a,wrap_mode_b;
   reg       en_sr_a,en_sr_b;

   reg       rst_out;
   
   
   
//-------------------------------------------------------- // outputs from the DUT are wire type
   //wire [3-1  :0] ctr3_out;
   //wire           ctr3_overflow;
   //
   //wire [2-1  :0] ctr2_out;
   //wire           ctr2_overflow;
   //wire [3:0] ctr4_out_a,ctr4_out_b;
   //wire       ctr4_overflow_a,ctr4b_overflow_b;
   //
   //wire           sn_out_a,sn_out_b,sn_mul_out;
   //
   ////wire [3:0]     bin_out;
   //wire           bin_out_overflow;
   //wire [15:0]    sr_out_a,sr_out_b;
   //wire [15:0]    sr_mul_out;
   //
   wire [7:0]    bin_out;
   
   
   
   
   
   

   
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

///////bin2stoch a   
/////prg_4b dut_prg4b_a (
/////  .clk(clk_50),
/////  .rst(rst),
/////  .en(en),
/////  .bin_in(input_bin_a),
/////  .sn_out(sn_out_a),
/////  .ctr_overflow(ctr4_overflow_a)         
/////);
/////
///////shiftreg_a  
/////shift_reg_16b dut_sr_a (
/////  .clk(clk_50),
/////  .scan_in(sn_out_a),
/////  .wrap_mode(wrap_mode_a),
/////  .en(en_sr_a),
/////  .rst(rst),
/////  .shiftreg_out(sr_out_a)
/////);
/////
/////   
/////
///////bin2stoch b
/////prg_4b dut_prg4b_b (
/////  .clk(clk_50),
/////  .rst(rst),
/////  .en(en),
/////  .bin_in(input_bin_b),
/////  .sn_out(sn_out_b),
/////  .ctr_overflow(ctr4_overflow_b)         
/////);
/////
///////shiftreg_b 
/////shift_reg_16b dut_sr_b (
/////  .clk(clk_50),
/////  .scan_in(sn_out_b),
/////  .wrap_mode(wrap_mode_b),
/////  .en(en_sr_b),
/////  .rst(rst),
/////  .shiftreg_out(sr_out_b)
/////);
/////
/////
/////   
/////
///////pipelined multiplier circuit
/////pipe_mul_16b dut_pipe_mul (
/////  .a(sr_out_a),
/////  .b(sr_out_b),
/////  .y(sr_mul_out)
/////);
/////                       
/////////stoch2bin out
///////counter #(
///////  .WIDTH (4)
///////) stoch2bin_out (
///////  .clk(clk_50),
///////  .rst(rst),
///////  .en(sn_mul_out),
///////  .out(bin_out),
///////  .overflow(bin_out_overflow)
///////);
/////
/////ctr_out_bank dut_ctr_out (
/////  .clk(clk_50),
/////  .rst(rst_out),
/////  .mul_in(sr_mul_out),
/////  .bin_out(bin_out)                      
/////);
   
                 

//top   
pipe_mul_top dut_pipe_mul_top (
  .clk(clk_50),
  .rst(rst),
  .en(en),
  .input_bin_a(input_bin_a),                               
  .input_bin_b(input_bin_b),
  .wrap_mode_b(wrap_mode_b),
  .en_sr_a(en_sr_a),
  .en_sr_b(en_sr_b),
  .rst_out(rst_out),
  .bin_out(bin_out)
);



   

   
//---------------------------------------------------------- // create a 50Mhz clock
always
    #10 clk_50 = ~clk_50;   // every ten nanoseconds invert
//----------------------------------------------------------- // initial blocks are sequential and start at time 0
  initial
    begin

       $dumpfile ("pipe_mul_tb.dump");
       $dumpvars(0,pipe_mul_tb);
       
    $display($time, " << Starting the Simulation >>");
       clk_50 = 0;
       en = 0;
       rst = 1;
       rst_out = 1;
       
       input_bin_a = 0;
       input_bin_b = 0;
       wrap_mode_a = 0;
       wrap_mode_b = 0;
       en_sr_a     = 0;
       en_sr_b     = 0;
       
       
       
       
       
       #10
       rst = 0;

       #10
       en  = 1;
       en_sr_a = 1;
       en_sr_b = 1;
       
       input_bin_a = 15;
       input_bin_b = 15;
       

       

         

       wait(pipe_mul_tb.dut_pipe_mul_top.ctr4_overflow_a == 1);

       en_sr_a = 0;
       wrap_mode_b = 1;
       rst_out = 0;
       
       
       
       #340

       

       
       
       
       
       
       
       
       
       
                                  
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
//    $monitor($time, " rst=%b, en=%b, bin_a=%h, bin_b=%h, ctr_a=%h, ctr_b=%h, ov_a=%b, ov_b=%b, sn_a=%b, sn_b=%b,mul_out=%b,bin_out=%h"
//             ,rst
//             ,en
//             ,input_bin_a
//             ,input_bin_b
//             ,pipe_mul_tb.dut_prg4b_a.ctr4_out
//             ,pipe_mul_tb.dut_prg4b_b.ctr4_out
//             ,ctr4_overflow_a
//             ,ctr4_overflow_b
//             ,sn_out_a
//             ,sn_out_b
//             ,sn_mul_out
//             ,bin_out);

    $monitor($time, " rst=%b, en=%b, wrap_mode_b=%b, bin_a=%h, bin_b=%h, ctr_a=%h, ctr_b=%h, ov_a=%b, ov_b=%b, sn_a=%b, sn_b=%b, sr_out_a=%h, sr_out_b=%h,sr_mul_out=%h,bin_out=%h"
             ,rst
             ,en
             ,wrap_mode_b
             ,input_bin_a
             ,input_bin_b
             ,pipe_mul_tb.dut_pipe_mul_top.dut_prg4b_a.ctr4_out
             ,pipe_mul_tb.dut_pipe_mul_top.dut_prg4b_a.ctr4_out
             ,pipe_mul_tb.dut_pipe_mul_top.ctr4_overflow_a
             ,pipe_mul_tb.dut_pipe_mul_top.ctr4_overflow_b
             ,pipe_mul_tb.dut_pipe_mul_top.sn_out_a
             ,pipe_mul_tb.dut_pipe_mul_top.sn_out_b
             ,pipe_mul_tb.dut_pipe_mul_top.sr_out_a
             ,pipe_mul_tb.dut_pipe_mul_top.sr_out_b
             ,pipe_mul_tb.dut_pipe_mul_top.sr_mul_out
             ,bin_out
             );

    
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