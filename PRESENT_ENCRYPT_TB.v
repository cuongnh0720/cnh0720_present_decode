//======================================================================
//
// Design Name:    PRESENT Block Cipher
// Module Name:    PRESENT_ENCRYPT_TB
//
// Description:    Testbench of PRESENT Encryption Module
//
// Dependencies:
//              present_encrypt.v
//
// Language: Verilog 2001
// Author: Saied H. Khayat
// Date:   March 2011
// URL: https://github.com/saiedhk
//
// Copyright Notice: Free use of this library is permitted under the
// guidelines and in accordance with the MIT License (MIT).
// http://opensource.org/licenses/MIT
//
//======================================================================

`timescale 1ns/1ps
`define DEL 1

//`define PLAINTEXT 64'h0000000000000000
//`define PLAINTEXT0 64'h0000000000000001
//`define PLAINTEXT1 64'h0000000000000002
//`define PLAINTEXT2 64'h0000000000000003
//`define PLAINTEXT3 64'h0000000000000004
//`define PLAINTEXT4 64'h0000000000000005

`define PLAINTEXT 64'h5579C1387B228445
`define PLAINTEXT0 64'h5579C1387B228445
`define PLAINTEXT1 64'hd392f4ec58356aed
`define PLAINTEXT2 64'hd392f4ec58356aee
`define PLAINTEXT3 64'hd392f4ec58356aef
`define PLAINTEXT4 64'hd392f4ec58356af0

//`define PLAINTEXT0 64'h0000000000000000
//`define PLAINTEXT1 64'h834349fd8e99a23b
//`define PLAINTEXT2 64'h9281dcb8a883a38c
//`define PLAINTEXT3 64'hd392f4ec58356aeb
//`define PLAINTEXT4 64'h3e5380018fc28d70

`define KEY0   80'h00000000000000000000
`define KEY1   80'h00000000000000000000
`define KEY2   80'h88239f8276ec927c8dec
`define KEY3   80'h610dcecce9a001117102
`define KEY4   80'h01f43bbc9b2001545339

// Testbench module
module PRESENT_ENCRYPT_TB;

   // internal signals and registers
   wire [63:0] odat;
   reg [63:0] idat = 0;
   reg [79:0] key  = 0;
   wire done        ;  
   reg load        = 1'b0;
   reg clk         = 1'b0;
   reg reset       = 1'b0;

   // instantiate design under test
   PRESENT_ENCRYPT dut(odat,done,idat,key,load,clk);

   // clock generator
   always  #5 clk = ~clk;


   //
   initial
   begin
   //#100
   #100
      #10   load = 1'b1; idat = `PLAINTEXT; key = `KEY0;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT0; key = `KEY0;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT1; key = `KEY0;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT2; key = `KEY0;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT3; key = `KEY0;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT4; key = `KEY0;
      #10   load = 1'b0;


      #400  load = 1'b1; idat = `PLAINTEXT; key = `KEY1;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT0; key = `KEY1;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT1; key = `KEY1;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT2; key = `KEY1;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT3; key = `KEY1;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT4; key = `KEY1;
      #10   load = 1'b0;
#400  load = 1'b1; idat = `PLAINTEXT0; key = `KEY2;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT1; key = `KEY2;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT2; key = `KEY2;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT3; key = `KEY2;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT4; key = `KEY2;
      #10   load = 1'b0;

      #400  load = 1'b1; idat = `PLAINTEXT0; key = `KEY3;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT1; key = `KEY3;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT2; key = `KEY3;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT3; key = `KEY3;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT4; key = `KEY3;
      #10   load = 1'b0;

      #400  load = 1'b1; idat = `PLAINTEXT0; key = `KEY4;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT1; key = `KEY4;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT2; key = `KEY4;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT3; key = `KEY4;
      #10   load = 1'b0;
      #400  load = 1'b1; idat = `PLAINTEXT4; key = `KEY4;
      #10   load = 1'b0;

      #400 $finish;
   end


endmodule
