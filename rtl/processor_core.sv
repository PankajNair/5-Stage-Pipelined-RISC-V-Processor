`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 03:32:32
// Design Name: 
// Module Name: processor_core
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


module processor_core (
input logic clk, reset,
input logic [31:0] instr_f,
input logic [31:0] read_data_m,
output logic mem_write_m,
output logic [31:0] pc_f,
output logic [31:0] arith_result_m, store_data_m
    );
    
logic alu_src_a_e, reg_write_m, reg_write_w, branch_jump_src_e, pc_src_e, arith_result_src_e;
logic zero_e, negetive_e, carry_e, overflow_e;
logic stall_d, stall_f, flush_d, flush_e, result_src_e0;
logic [31:0] instr_d;
logic [4:0] arith_control_e;
logic [4:0] rs1_d, rs2_d, rs1_e, rs2_e;
logic [4:0] rd_e, rd_m, rd_w;
logic [2:0] imm_src_d, load_src_m;
logic [1:0] alu_src_b_e;
logic [1:0] result_src_w, store_src_e; 
logic [1:0] forward_a_e, forward_b_e;
    
datapath datapath (
.clk(clk), 
.reset(reset),
.reg_write_w(reg_write_w),
.branch_jump_src_e(branch_jump_src_e), 
.pc_src_e(pc_src_e), 
.alu_src_a_e(alu_src_a_e), 
.arith_result_src_e(arith_result_src_e),
.stall_d(stall_d), 
.stall_f(stall_f), 
.flush_d(flush_d), 
.flush_e(flush_e),
.instr_f(instr_f),
.read_data_m(read_data_m),
.arith_control_e(arith_control_e),
.imm_src_d(imm_src_d),
.load_src_m(load_src_m),
.alu_src_b_e(alu_src_b_e), 
.store_src_e(store_src_e),
.forward_a_e(forward_a_e), 
.forward_b_e(forward_b_e),
.result_src_w(result_src_w),
.zero_e(zero_e),
.negetive_e(negetive_e), 
.carry_e(carry_e), 
.overflow_e(overflow_e),
.pc_f(pc_f),
.instr_d(instr_d),
.arith_result_m(arith_result_m), 
.store_data_m(store_data_m),
.rs1_d(rs1_d), 
.rs2_d(rs2_d), 
.rs1_e(rs1_e), 
.rs2_e(rs2_e),
.rd_e(rd_e), 
.rd_m(rd_m), 
.rd_w(rd_w)
    ); 

control_unit control_unit (
.clk(clk), 
.reset(reset),
.op(instr_d[6:0]),
.funct_3(instr_d[14:12]),
.funct_7(instr_d[31:25]),
.zero_e(zero_e),
.negetive_e(negetive_e), 
.carry_e(carry_e), 
.overflow_e(overflow_e),
.flush_e(flush_e),
.result_src_e0(result_src_e0), 
.arith_result_src_e(arith_result_src_e),
.mem_write_m(mem_write_m),
.branch_jump_src_e(branch_jump_src_e), 
.pc_src_e(pc_src_e), 
.alu_src_a_e(alu_src_a_e), 
.reg_write_m(reg_write_m), 
.reg_write_w(reg_write_w),
.arith_control_e(arith_control_e),
.imm_src_d(imm_src_d), 
.load_src_m(load_src_m),
.result_src_w(result_src_w), 
.store_src_e(store_src_e),
.alu_src_b_e(alu_src_b_e)
    );

hazard_unit hazard_unit (
.reg_write_m(reg_write_m), 
.reg_write_w(reg_write_w),
.result_src_e0(result_src_e0), 
.pc_src_e(pc_src_e),
.rs1_d(rs1_d), 
.rs2_d(rs2_d), 
.rs1_e(rs1_e), 
.rs2_e(rs2_e),
.rd_e(rd_e), 
.rd_m(rd_m), 
.rd_w(rd_w),
.stall_d(stall_d), 
.stall_f(stall_f), 
.flush_d(flush_d), 
.flush_e(flush_e),
.forward_a_e(forward_a_e), 
.forward_b_e(forward_b_e)
    );
     
endmodule
