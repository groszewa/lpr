//------------------------------------------------------
// Copyright 1992, 1993 Cascade Design Automation Corporation.
//------------------------------------------------------
module regfile2r(IN0,R1,R2,RE1,RE2,W,WE,OUT1,OUT2);
  parameter N = 8;
  parameter WORDS = 16;
  parameter M = 4;
  parameter GROUP = "dpath1";
  parameter
        d_IN0 = 0,
        d_R1 = 0,
        d_R2 = 0,
        d_RE1_r = 0,
        d_RE1_f = 0,
        d_RE2_r = 0,
        d_RE2_f = 0,
        d_W = 0,
        d_WE_r = 0,
        d_WE_f = 0,
        d_OUT1 = 1,
        d_OUT2 = 1;
  input [(N - 1):0] IN0;
  input [(M - 1):0] R1;
  input [(M - 1):0] R2;
  input  RE1;
  input  RE2;
  input [(M - 1):0] W;
  input  WE;
  output [(N - 1):0] OUT1;
  output [(N - 1):0] OUT2;
  wire [(N - 1):0] IN0_temp;
  wire [(M - 1):0] R1_temp;
  wire [(M - 1):0] R2_temp;
  wire  RE1_temp;
  wire  RE2_temp;
  wire [(M - 1):0] W_temp;
  wire  WE_temp;
  reg [(N - 1):0] OUT1_temp;
  reg [(N - 1):0] OUT2_temp;
  reg  flag1;
  reg  flag2;
  reg  error_flag;
  reg [(M - 1):0] W_old;
  reg [(N - 1):0] mem_array[(WORDS - 1):0];
  integer i;
  assign #(d_IN0) IN0_temp = IN0;
  assign #(d_R1) R1_temp = R1;
  assign #(d_R2) R2_temp = R2;
  assign #(d_RE1_r,d_RE1_f) RE1_temp = RE1;
  assign #(d_RE2_r,d_RE2_f) RE2_temp = RE2;
  assign #(d_W) W_temp = W;
  assign #(d_WE_r,d_WE_f) WE_temp = WE;
  assign #(d_OUT1) OUT1 = OUT1_temp;
  assign #(d_OUT2) OUT2 = OUT2_temp;
  initial
    begin
    flag1 = 1'b0;
    flag2 = 1'b0;
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
            flag1 = ( ~ flag1);
          if((W_temp == R2_temp))
            flag2 = ( ~ flag2);
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
    @(flag1 or RE1_temp or R1_temp)
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
  always
    @(flag2 or RE2_temp or R2_temp)
      begin
      if((RE2_temp == 1'b1))
        if(((R2_temp >= 0) && (R2_temp < WORDS)))
          OUT2_temp = mem_array[R2_temp];
        else
          OUT2_temp = 128'bx;
      else      if((RE2_temp == 1'b0))
        OUT2_temp = 128'bz;
      else
        OUT2_temp = 128'bx;
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
