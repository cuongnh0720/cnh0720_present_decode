`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2024 09:54:13 PM
// Design Name: 
// Module Name: gen_key
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module gen_key(
    input logic[79:0] key,
    output logic [79:0] keygen
);

logic [79:0] key_reg;
logic [79:0] key_permute;
logic [3:0] key_sbox;
logic [4:0] key_xor;
logic [3:0] sbox_rom_t[0:15] = {4'hC, 4'h5, 4'h6, 4'hB,
                                4'h9, 4'h0, 4'hA, 4'hD,
                                4'h3, 4'hE, 4'hF, 4'h8,
                                4'h4, 4'h7, 4'h1, 4'h2};


always_comb begin
 key_reg = key;
    for (int i = 0; i < 31; i = i + 1) begin
        key_permute = {key_reg[18:0], key_reg[79:19]};
        key_sbox = sbox_rom_t[key_permute[79:76]];
        key_xor = key_permute[19:15] ^ (i + 1);
        key_reg = {key_sbox, key_permute[75:20], key_xor, key_permute[14:0]};
    end
    keygen <= key_reg;
end
//key31
endmodule
