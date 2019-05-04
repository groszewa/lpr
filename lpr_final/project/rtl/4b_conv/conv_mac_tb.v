`timescale 1 ns / 100 ps

`define NUM_TESTS 1000


module conv_mac_tb ();
//--------------------------------------------------------- // inputs to the DUT are reg type
   reg clk_50;

   reg [3:0] input_bin_a, input_bin_b;
   reg [7:0] input_bin_c;
   
   wire [7:0] bin_out;
   
   integer    i;
   shortint   expected_result;
   
       
   
   
          
   
   
   
   
   

   
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
conv_mac dut(.a(input_bin_a),.b(input_bin_b),.c(input_bin_c),.z(bin_out));
   
                 




   

   
//---------------------------------------------------------- // create a 50Mhz clock
always
    #10 clk_50 = ~clk_50;   // every ten nanoseconds invert
//----------------------------------------------------------- // initial blocks are sequential and start at time 0
  initial
    begin

       $dumpfile ("conv_mac_tb.dump");
       $dumpvars(0,conv_mac_tb);
       
    $display($time, " << Starting the Simulation >>");
       clk_50 = 0;
       
       input_bin_a = 0;
       input_bin_b = 0;


       #10
       
       input_bin_a = 5;
       input_bin_b = 2;


         for(i=0;i<`NUM_TESTS;i=i+1)
         begin
            //$display("iteration %d",i);
            input_bin_a = $random();
            input_bin_b = $random();
            input_bin_c = $random();
            
            

           //@(posedge clk_50)
           //  begin
           //     $display("alex");
           //     cycle_count = cycle_count + 1;
           //  end

            //time_start = $time;
            expected_result = (input_bin_a * input_bin_b) + input_bin_c;
            
            
            
            
            //wait(op_finished);
            //time_end = $time;
            #20
            
            //expected_result = input_bin_a * input_bin_b;
            //cycle_count = time_end - time_start;
            //cycle_count_acc += cycle_count;
            
            
            $display("Test %d : a=%d, b=%d, c=%d, z=%d",i,input_bin_a,input_bin_b,input_bin_c,bin_out);
            

            if(expected_result != bin_out) begin
               $display("ERROR : a=%d, b=%d, c=%d, z=%d, expected=%d",input_bin_a,input_bin_b,input_bin_c,bin_out,expected_result);
            end
            
            
            //$display("alex : expected : %d * %d = %d", input_bin_a, input_bin_b, expected_result);
            //$display("alex : obtained : %d",bin_out);
            //rst = 1;
            //en  = 0;
            //cycle_count = 0;
            
            
              
         end


       
       
       
       
       
       
       
       
                                  
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

    
    
   ///$monitor($time, " rst=%b, en=%b, add_start=%b, wrap_mode_b=%b, bin_a=%h, bin_b=%h, bin_c=%h, sn_a=%b, sn_b=%b, sr_out_a=%h, sr_out_b=%h,sr_mul_out=%h,bin_out=%h"
   ///         ,rst
   ///         ,en
   ///         ,start_add
   ///         ,wrap_mode_b
   ///         ,input_bin_a
   ///         ,input_bin_b
   ///         ,(input_bin_c0 + input_bin_c1 + input_bin_c2 + input_bin_c3 + input_bin_c4 + input_bin_c5 + input_bin_c6 + input_bin_c7 + input_bin_c8 + input_bin_c9 + input_bin_c10 + input_bin_c11 + input_bin_c12 + input_bin_c13 + input_bin_c14 + input_bin_c15)
   ///         ,sn_out_a
   ///         ,sn_out_b
   ///         ,sr_out_a
   ///         ,sr_out_b
   ///         ,sr_mul_out
   ///         ,bin_out
   ///         );

    
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