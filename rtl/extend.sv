`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 22:13:06
// Design Name: 
// Module Name: extend
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


module extend (
input logic [2:0] imm_src, 
input logic [31:7] instr,
output logic [31:0] imm_ext
    );

always_comb
begin
	case(imm_src)
	3'b000: imm_ext = {{20{instr[31]}}, instr[31:20]};                                //I-Type
	3'b001: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};                   //S-Type
	3'b010: imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};   //B-Type
	3'b011: imm_ext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; //J-Type
	3'b100: imm_ext = {instr[31:12], 12'b0};	                                      //U-Type
	default: imm_ext = 32'bx;
	endcase
end 

endmodule
