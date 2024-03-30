`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 02:23:31
// Design Name: 
// Module Name: main_decoder
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


module main_decoder(
input logic [6:0] op,
output logic mem_write,
output logic branch, alu_src_a, reg_write, jump,
output logic [2:0] imm_src,
output logic [1:0] result_src,
output logic [1:0] alu_src_b,
output logic [1:0] arith_op
	);
	
logic [13:0] controls;
assign {reg_write, imm_src, alu_src_a, alu_src_b, mem_write, result_src, branch, arith_op, jump} = controls;

always_comb
	case(op)
	   7'b0110011: controls = 14'b1_xxx_0_00_0_00_0_01_0; //R-Type
	   7'b0010011: controls = 14'b1_000_0_01_0_00_0_01_0; //I-Type (ALU)
	   7'b0000011: controls = 14'b1_000_0_01_0_01_0_00_0; //I-Type (lw)
	   7'b1100111: controls = 14'b1_000_0_01_0_10_0_00_1; //I-Type (jalr)
	   7'b0100011: controls = 14'b0_001_0_01_1_00_0_00_0; //S-Type (sw)
	   7'b1100011: controls = 14'b0_010_0_00_0_00_1_00_0; //B-type
	   7'b1101111: controls = 14'b1_011_0_00_0_10_0_00_1; //J-Type (jal)
	   7'b0010111: controls = 14'b1_100_1_10_0_00_0_00_0; //U-Type (auipc)
	   7'b0110111: controls = 14'b1_100_1_01_0_00_0_00_0; //U-Type (lui)
	   7'b0000000: controls = 14'b0_000_0_00_0_00_0_00_0; //Reset
	   default: controls = 14'bx_xxx_x_xx_x_xx_x_xx_x;
	endcase
endmodule
