`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 01:51:07
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit (
input logic reg_write_m, reg_write_w,
input logic result_src_e0, pc_src_e,
input logic [4:0] rs1_d, rs2_d, rs1_e, rs2_e,
input logic [4:0] rd_e, rd_m, rd_w,
output logic stall_d, stall_f, flush_d, flush_e,
output logic [1:0] forward_a_e, forward_b_e
    );

logic lw_stall;

always_comb 
begin
    forward_a_e = 2'b00;
    forward_b_e = 2'b00;
    if ((rs1_e == rd_m) & (reg_write_m) & (rs1_e != 0))
        forward_a_e = 2'b10; 
    else if ((rs1_e == rd_w) & (reg_write_w) & (rs1_e != 0))
        forward_a_e = 2'b01;
    if ((rs2_e == rd_m) & (reg_write_m) & (rs2_e != 0))
        forward_b_e = 2'b10;
    else if ((rs2_e == rd_w) & (reg_write_w) & (rs2_e != 0))
        forward_b_e = 2'b01;
end

assign lw_stall = (result_src_e0 == 1) & ((rd_e == rs1_d) | (rd_e == rs2_d));
assign stall_f = lw_stall;
assign stall_d = lw_stall;
	
assign flush_e = lw_stall | pc_src_e;
assign flush_d = pc_src_e;

endmodule

