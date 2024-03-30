`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 02:18:53
// Design Name: 
// Module Name: alu_decoder
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


module alu_decoder(
input logic [2:0] funct_3,
input logic	[6:0] funct_7,
input logic [1:0] arith_op,
output logic [4:0] arith_control
    );

always_comb
begin
    case(arith_op)
        2'b00: arith_control = 5'h0;                                     //Add for Load/Store
        2'b01: case(funct_3)                                             //R-type or I-type ALU/Multiply
                   3'h0: if (funct_7 == 7'h20)      
                               arith_control = 5'h1;                     //sub
                         else if(funct_7 == 7'h01)
                               arith_control = 5'ha;                     //mul
                         else 
                               arith_control = 5'h0;                     //add, addi
                   3'h1: arith_control = (funct_7 == 7'h01)? 5'hb:5'h7;  //mulh, sll, slli
                   3'h2: arith_control = (funct_7 == 7'h01)? 5'hc:5'h5;  //mulsu, slt, slti
                   3'h3: arith_control = (funct_7 == 7'h01)? 5'hd:5'h6;  //mulu, sltu, sltui
                   3'h4: arith_control = 5'h4;                           //xor
                   3'h5: if (funct_7 == 7'h20) 
                               arith_control = 5'h8;                     //sra
                         else
                               arith_control = 5'h9;                     //srl        
                   3'h6: arith_control = 5'h3;                           //rem, or, ori
                   3'h7: arith_control = 5'h2;                           //remu, and, andi
                   default: arith_control = 5'bx; 
               endcase
        default: arith_control = 5'bx;
    endcase
end

endmodule
