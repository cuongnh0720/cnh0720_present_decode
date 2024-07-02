`timescale 1ns/1ps

//`define DEBUG
`define PRINT_TEST_VECTORS

module PRESENT_ENCRYPT (
        output [63:0] odat,   // data output port
        output        done,
        input  [63:0] idat,   // data input port
        input  [79:0] key,    // key input port
        input         load,   // data load command
        input         clk     // clock
    );

//---------wires, registers----------
reg done_reg;
reg  [79:0] kreg;  
wire [79:0] kreg1;               // key register 31
reg  [63:0] dreg;               // data register
reg  [4:0]  round;              // round counter
wire [63:0] dat1,dat2,dat3;     // intermediate data
wire [79:0] kdat1,kdat2;        // intermediate subkey data

 gen_key gen_key( .key(key), .keygen(kreg1) );
//---------combinational processes----------

assign dat1 = dreg ^ kreg[79:16];        // add round key
assign odat = dat1;                      // output ciphertext

// key update
assign kdat1        = {kreg[60:0], kreg[79:61]}; // key permute rotate key 61 bits to the left
assign kdat2[79:39 ] = kdat1[79:39 ];
assign kdat2[38:34] = kdat1[38:34] ^ round;  // keyxor xor key data and round counter
assign kdat2[33:19] = kdat1[33:19];
assign kdat2[14:0] = kdat1[14:0];


//---------instantiations--------------------

// instantiate 16 substitution boxes (s-box) for encryption
PRESENT_ENCRYPT_PBOX UPBOX    ( .out(dat2), .in(dat1) );
genvar i;
generate
    for (i=0; i<64; i=i+4) begin: sbox_loop
       PRESENT_ENCRYPT_SBOX USBOX( .out(dat3[i+3:i]), .in(dat2[i+3:i]) );
    end
endgenerate

// instantiate pbox (p-layer)
//sboxkey
// instantiate substitution box (s-box) for key expansion
PRESENT_ENCRYPT_SBOX USBOXKEY ( .out(kdat2[18:15]), .in(kdat1[18:15]) );


//---------sequential processes----------

// Load data
always @(posedge clk)
begin
   if (load)
      dreg <= idat;
   else
      dreg <= dat3;
end

// Load/reload key into key register
always @(posedge clk)
begin
   if (load)
      kreg <= kreg1;
   else
      kreg <= kdat2;
end

// Round counter
always @(posedge clk)
begin
   if (load)
      round <= 5'b11111;
   else
      round <= round - 1;  
      done_reg<=1'b0;
 if (round == 5'b00001)
   done_reg <=1'b1; 
//   round <= round + 1;
end
assign done = done_reg;
//-------------------Debug stuff -------------------

// To print key1 and key32
`ifdef PRINT_KEY_VECTORS
always @(posedge clk)
begin
   if (round==0)
      $display("KEYVECTOR=> key1=%x  key32=%x",key,kreg);
end
`endif

// To print test vectors at simulation time
`ifdef PRINT_TEST_VECTORS
always @(posedge clk)
begin
   if (round==0)
      $display("TESTVECTOR=> ", $time, " plaintext=%x  key=%x  ciphertext=%x",idat,key,odat);
end
`endif

// To inspect internal signals at simulation
`ifdef DEBUG
always @(posedge clk)
begin
      $display("D=> ", $time, " %d  %x  %x  %x  %x  %x  %x",round,idat,dreg,dat1,dat2,dat3,odat);
      $display("K=> ", $time, " %d  %x  %x  %x",round,kreg,kdat1,kdat2);
end
`endif



endmodule
