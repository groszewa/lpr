`timescale 1 ns / 100 ps


module pipe_mac_tb ();
//--------------------------------------------------------- // inputs to the DUT are reg type
   reg clk_50;
   reg en;
   reg rst;

   reg [3:0] input_bin_a, input_bin_b;

   reg       wrap_mode;
   
   reg       wrap_mode_a,wrap_mode_b;
   reg       en_sr_a,en_sr_b;

   reg       rst_out;

   reg [3:0] input_bin_c0,input_bin_c1,input_bin_c2,input_bin_c3,input_bin_c4,input_bin_c5,input_bin_c6,input_bin_c7,input_bin_c8,input_bin_c9,input_bin_c10,input_bin_c11,input_bin_c12,input_bin_c13,input_bin_c14,input_bin_c15;
   
   reg       en_c_bank;
   reg       start_add;
       
   
   
//-------------------------------------------------------- // outputs from the DUT are wire type
   //wire [3-1  :0] ctr3_out;
   //wire           ctr3_overflow;
   //
   //wire [2-1  :0] ctr2_out;
   //wire           ctr2_overflow;
   wire [3:0] ctr4_out_a,ctr4_out_b;
   wire       ctr4_overflow_a,ctr4b_overflow_b;
   
   wire           sn_out_a,sn_out_b,sn_mul_out;

   //wire [3:0]     bin_out;
   wire           bin_out_overflow;

   wire [15:0]    sr_out_a,sr_out_b;
   wire [15:0]    sr_mul_out;

   wire [7:0]    bin_out;

   wire          sn_out_c0,sn_out_c1,sn_out_c2,sn_out_c3,sn_out_c4,sn_out_c5,sn_out_c6,sn_out_c7,sn_out_c8,sn_out_c9,sn_out_c10,sn_out_c11,sn_out_c12,sn_out_c13,sn_out_c14,sn_out_c15;
   wire [15:0]         sr_add_out;
          
   
   
   
   
   

   
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

//shiftreg_a  
shift_reg_16b dut_sr_a (
  .clk(clk_50),
  .scan_in(sn_out_a),
  .wrap_mode(wrap_mode_a),
  .en(en_sr_a),
  .rst(rst),
  .shiftreg_out(sr_out_a)
);

   

//bin2stoch b
prg_4b dut_prg4b_b (
  .clk(clk_50),
  .rst(rst),
  .en(en),
  .bin_in(input_bin_b),
  .sn_out(sn_out_b),
  .ctr_overflow(ctr4_overflow_b)         
);

//shiftreg_b 
shift_reg_16b dut_sr_b (
  .clk(clk_50),
  .scan_in(sn_out_b),
  .wrap_mode(wrap_mode_b),
  .en(en_sr_b),
  .rst(rst),
  .shiftreg_out(sr_out_b)
);


   

//pipelined multiplier circuit
pipe_mul_16b dut_pipe_mul (
  .a(sr_out_a),
  .b(sr_out_b),
  .y(sr_mul_out)
);

//split c inputs
prg4b_bank dut_prg4b_bank_c (
  .clk(clk_50),
  .rst(rst),
  .en(en_c_bank),
  .bin_in0(input_bin_c0),
  .bin_in1(input_bin_c1),
  .bin_in2(input_bin_c2),
  .bin_in3(input_bin_c3),
  .bin_in4(input_bin_c4),
  .bin_in5(input_bin_c5),
  .bin_in6(input_bin_c6),
  .bin_in7(input_bin_c7),
  .bin_in8(input_bin_c8),
  .bin_in9(input_bin_c9),
  .bin_in10(input_bin_c10),
  .bin_in11(input_bin_c11),
  .bin_in12(input_bin_c12),
  .bin_in13(input_bin_c13),
  .bin_in14(input_bin_c14),
  .bin_in15(input_bin_c15),                           
  .sn_out0(sn_out_c0),
  .sn_out1(sn_out_c1),
  .sn_out2(sn_out_c2),
  .sn_out3(sn_out_c3),
  .sn_out4(sn_out_c4),
  .sn_out5(sn_out_c5),
  .sn_out6(sn_out_c6),
  .sn_out7(sn_out_c7),
  .sn_out8(sn_out_c8),
  .sn_out9(sn_out_c9),
  .sn_out10(sn_out_c10),
  .sn_out11(sn_out_c11),
  .sn_out12(sn_out_c12),
  .sn_out13(sn_out_c13),
  .sn_out14(sn_out_c14),
  .sn_out15(sn_out_c15)                                                      
);
   

pipe_scale_add_16b dut_scale_add (
  .a(sr_mul_out),
  .b0(sn_out_c0),
  .b1(sn_out_c1),
  .b2(sn_out_c2),
  .b3(sn_out_c3),
  .b4(sn_out_c4),
  .b5(sn_out_c5),
  .b6(sn_out_c6),
  .b7(sn_out_c7),
  .b8(sn_out_c8),
  .b9(sn_out_c9),
  .b10(sn_out_c10),
  .b11(sn_out_c11),
  .b12(sn_out_c12),
  .b13(sn_out_c13),
  .b14(sn_out_c14),
  .b15(sn_out_c15),
  .s(start_add),
  .y(sr_add_out)
);
   
                       

ctr_out_bank dut_ctr_out (
  .clk(clk_50),
  .rst(rst_out),
  .mul_in(sr_add_out),
  .bin_out(bin_out)                      
);
   
                 




   

   
//---------------------------------------------------------- // create a 50Mhz clock
always
    #10 clk_50 = ~clk_50;   // every ten nanoseconds invert
//----------------------------------------------------------- // initial blocks are sequential and start at time 0
  initial
    begin

       $dumpfile ("pipe_mac_tb.dump");
       $dumpvars(0,pipe_mac_tb);
       
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
       en_c_bank   = 0;
       start_add   = 0;

       input_bin_c0 = 0;
       input_bin_c1 = 0;
       input_bin_c2 = 0;
       input_bin_c3 = 0;
       input_bin_c4 = 0;
       input_bin_c5 = 0;
       input_bin_c6 = 0;
       input_bin_c7 = 0;
       input_bin_c8 = 0;
       input_bin_c9 = 0;
       input_bin_c10 = 0;
       input_bin_c11 = 0;
       input_bin_c12 = 0;
       input_bin_c13 = 0;
       input_bin_c14 = 0;
       input_bin_c15 = 0;
       
       
       
       
       
       
       
       #10
       rst = 0;

       #10
       en  = 1;
       en_sr_a = 1;
       en_sr_b = 1;
       
       input_bin_a = 5;
       input_bin_b = 2;

       //sum = 49
       input_bin_c0 = 1;
       input_bin_c1 = 2;
       input_bin_c2 = 3;
       input_bin_c3 = 4;
       input_bin_c4 = 3;
       input_bin_c5 = 2;
       input_bin_c6 = 1;
       input_bin_c7 = 2;
       input_bin_c8 = 3;
       input_bin_c9 = 4;
       input_bin_c10 = 5;
       input_bin_c11 = 6;
       input_bin_c12 = 7;
       input_bin_c13 = 3;
       input_bin_c14 = 2;
       input_bin_c15 = 1;

       //result should = 49+10 = 59 = 3B

         

       wait(ctr4_overflow_a == 1);

       en_sr_a = 0;
       wrap_mode_b = 1;
       rst_out = 0;
       
       
       
       #340

       start_add = 1;
       en_c_bank = 1;
       
       

       #320
       
       
       
       
       
       
       
       
                                  
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

    
    
    $monitor($time, " rst=%b, en=%b, add_start=%b, wrap_mode_b=%b, bin_a=%h, bin_b=%h, bin_c=%h, sn_a=%b, sn_b=%b, sr_out_a=%h, sr_out_b=%h,sr_mul_out=%h,bin_out=%h"
             ,rst
             ,en
             ,start_add
             ,wrap_mode_b
             ,input_bin_a
             ,input_bin_b
             ,(input_bin_c0 + input_bin_c1 + input_bin_c2 + input_bin_c3 + input_bin_c4 + input_bin_c5 + input_bin_c6 + input_bin_c7 + input_bin_c8 + input_bin_c9 + input_bin_c10 + input_bin_c11 + input_bin_c12 + input_bin_c13 + input_bin_c14 + input_bin_c15)
             ,sn_out_a
             ,sn_out_b
             ,sr_out_a
             ,sr_out_b
             ,sr_mul_out
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