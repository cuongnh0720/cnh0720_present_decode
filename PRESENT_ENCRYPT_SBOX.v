//
// Copyright Notice: Free use of this library is permitted under the
// guidelines and in accordance with the MIT License (MIT).
// http://opensource.org/licenses/MIT
//
//======================================================================

`timescale 1ns/1ps

module PRESENT_ENCRYPT_SBOX (
   output reg [3:0] out,
   input      [3:0] in
);


always @(in)
    case (in)
        4'h0 : out = 4'h5;
        4'h1 : out = 4'hE;
        4'h2 : out = 4'hF;
        4'h3 : out = 4'h8;
        4'h4 : out = 4'hC;
        4'h5 : out = 4'h1;
        4'h6 : out = 4'h2;
        4'h7 : out = 4'hD;
        4'h8 : out = 4'hB;
        4'h9 : out = 4'h4;
        4'hA : out = 4'h6;
        4'hB : out = 4'h3;
        4'hC : out = 4'h0;
        4'hD : out = 4'h7;
        4'hE : out = 4'h9;
        4'hF : out = 4'hA;
    endcase

endmodule