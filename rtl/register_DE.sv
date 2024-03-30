`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 21:33:28
// Design Name: 
// Module Name: register_DE
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


module register_DE (
input logic clk, reset, clear,
input logic [31:0] rd1_d, rd2_d, pc_d,
input logic [31:0] imm_ext_d, pc_plus4_d,
input logic [4:0] rs1_d, rs2_d, rd_d, 
output logic [31:0] rd1_e, rd2_e, pc_e,
output logic [31:0] imm_ext_e, pc_plus4_e,
output logic [4:0] rs1_e, rs2_e, rd_e
    );

always_ff @(posedge clk, posedge reset) 
begin
    if(reset) 
        begin
            rd1_e <= 0;
            rd2_e <= 0;
            pc_e <= 0;
            rs1_e <= 0;
            rs2_e <= 0;
            rd_e <= 0;
            imm_ext_e <= 0;
            pc_plus4_e <= 0;
        end

    else if(clear) 
        begin
            rd1_e <= 0;
            rd2_e <= 0;
            pc_e <= 0;
            rs1_e <= 0;
            rs2_e <= 0;
            rd_e <= 0;
            imm_ext_e <= 0;
            pc_plus4_e <= 0;
        end
    else 
        begin
            rd1_e <= rd1_d;
            rd2_e <= rd2_d;
            pc_e <= pc_d;
            rs1_e <= rs1_d;
            rs2_e <= rs2_d;
            rd_e <= rd_d;
            imm_ext_e <= imm_ext_d;
            pc_plus4_e <= pc_plus4_d;
        end
end

endmodule
