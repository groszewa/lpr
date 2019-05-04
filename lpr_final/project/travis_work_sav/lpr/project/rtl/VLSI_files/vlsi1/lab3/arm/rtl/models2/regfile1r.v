//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module regfile1r(IN0,R1,RE1,W,WE,OUT1);
  parameter N = 8;
  parameter WORDS = 16;
  parameter M = 4;
  parameter GROUP = "dpath1";
  parameter
        d_IN0 = 0,
        d_R1 = 0,
        d_RE1_r = 0,
        d_RE1_f = 0,
        d_W = 0,
        d_WE_r = 0,
        d_WE_f = 0,
        d_OUT1 = 1;
  input [(N - 1):0] IN0;
  input [(M - 1):0] R1;
  input  RE1;
  input [(M - 1):0] W;
  input  WE;
  output [(N - 1):0] OUT1;
  wire [(N - 1):0] IN0_temp;
  wire [(M - 1):0] R1_temp;
  wire  RE1_temp;
  wire [(M - 1):0] W_temp;
  wire  WE_temp;
  reg [(N - 1):0] OUT1_temp;
  reg  flag;
  reg  error_flag;
  reg [(N - 1):0] OUT2;
  reg [(N - 1):0] mem_array[(WORDS - 1):0];
  reg [(M - 1):0] W_old;
  integer i;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_R1) R1_temp = R1;
  assign #(d_RE1_r,d_RE1_f) RE1_temp = RE1;
  assign #(d_W) W_temp = W;
  assign #(d_WE_r,d_WE_f) WE_temp = WE;
  assign #(d_OUT1) OUT1 = OUT1_temp;
  initial
    begin
    flag = 1'b0;
    error_flag = 1'b0;
    end
  always
    @(W_temp)
      begin
      if(((WE_temp == 1'b1) && ($time !== 0)))
        begin
        error_flag = 1'b1;
        if((( | (W_temp & ( ~ W_temp))) === 1'bx))
          begin
          $display("(Error) %m: address changed to unknown while write enable is active at time %t unknown written to all addresses",$time);
          for(i = 0;(i < WORDS);i = (i + 1))
            mem_array[i] = 128'bx;
          end
        else        if((((W_temp >= 0) && (W_temp < WORDS)) && (((( | (W_old & ( ~ W_old))) !== 1'bx) && (W_old >= 0)) && (W_old < WORDS))))
          begin
          $display("(Error) %m: address change while write enable is active at time %t unknown value written to address %d and %d \n",$time,W_old,W_temp);
          mem_array[W_old] = 128'bx;
          mem_array[W_temp] = 128'bx;
          end
        else        if(((W_temp >= 0) && (W_temp < WORDS)))
          begin
          $display("(Error) %m: address change while write enable is active at time %t unknown value written to address %d \n",$time,W_temp);
          mem_array[W_temp] = 128'bx;
          end
        end
      W_old = W_temp;
      end
  always
    @(WE_temp or IN0_temp)
      begin
      if((WE_temp == 1'b1))
        begin
        if(((W_temp >= 0) && (W_temp < WORDS)))
          begin
          if((error_flag == 1'b0))
            mem_array[W_temp] = IN0_temp;
          if((W_temp == R1_temp))
            flag = ( ~ flag);
          end
        else
          begin
          $display("(Error) %m: Illegal value on W pin of regfile");
          end
        end
      else      if((WE_temp == 1'b0))
        error_flag = 1'b0;
      else
        begin
        $display("(Error) %m: Write enable signal is unknown at time %t unknown value written into address %d",$time,W_temp);
        mem_array[W_temp] = 128'bx;
        end
      end
  always
    @(flag or RE1_temp or R1_temp)
      begin
      if((RE1_temp == 1'b1))
        if(((R1_temp >= 0) && (R1_temp < WORDS)))
          OUT1_temp = mem_array[R1_temp];
        else
          OUT1_temp = 128'bx;
      else      if((RE1_temp == 1'b0))
        OUT1_temp = 128'bz;
      else
        OUT1_temp = 128'bx;
      end
  wire [127:0] IN0_tcheck = IN0;
  wire [127:0] W_tcheck = W;
  specify
    specparam
      t_hold_IN0 = 0,
      t_hold_W = 0,
      t_setup_W = 0;
    $hold(negedge WE , IN0_tcheck , t_hold_IN0);
    $hold(negedge WE , W_tcheck , t_hold_W);
    $setup(W_tcheck , posedge WE , t_setup_W);
  endspecify
endmodule
