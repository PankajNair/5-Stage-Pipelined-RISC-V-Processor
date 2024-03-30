`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 22:49:23
// Design Name: 
// Module Name: datapath
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


module datapath(
input logic clk, reset,
input logic reg_write_w,
input logic branch_jump_src_e, pc_src_e, alu_src_a_e, arith_result_src_e,
input logic stall_d, stall_f, flush_d, flush_e,
input logic [31:0] instr_f,
input logic [31:0] read_data_m,
input logic [4:0] arith_control_e,
input logic [2:0] imm_src_d,
input logic [2:0] load_src_m,
input logic [1:0] alu_src_b_e, store_src_e,
input logic [1:0] forward_a_e, forward_b_e,
input logic [1:0] result_src_w,
output logic zero_e, negetive_e, carry_e, overflow_e,
output logic [31:0] pc_f,
output logic [31:0] instr_d,
output logic [31:0] arith_result_m, store_data_m,
output logic [4:0] rs1_d, rs2_d, rs1_e, rs2_e,
output logic [4:0] rd_e, rd_m, rd_w
    );

logic [31:0] pc_d, pc_e, arith_result_e, arith_result_w, store_data_e, load_data_m, load_data_w;
logic [31:0] pc_next_f, pc_plus4_f, pc_plus4_d, pc_plus4_e, pc_plus4_m, pc_plus4_w, pc_target_e, branch_jump_target_e;
logic [31:0] alu_result_e, mult_result_e, write_data_e;
logic [31:0] imm_ext_d, imm_ext_e;
logic [31:0] src_a_result, src_a_e, src_b_e;
logic [31:0] rd1_d, rd2_d, rd1_e, rd2_e;
logic [31:0] result_w;
logic [4:0] rd_d;

assign rs1_d = instr_d[19:15];
assign rs2_d = instr_d[24:20];		
assign rd_d = instr_d[11:7];

//Fetch Stage

mux_2 branch_jump_mux (
.A(pc_target_e), 
.B(arith_result_e), 
.S(branch_jump_src_e), 
.Y(branch_jump_target_e)
    );

mux_2 pc_mux (
.A(pc_plus4_f), 
.B(branch_jump_target_e), 
.S(pc_src_e), 
.Y(pc_next_f)
    );

flipflop pc_flipflop (
.clk(clk), 
.reset(reset), 
.enable(~stall_f), 
.D(pc_next_f), 
.Q(pc_f)
    );

adder pc_adder_4 (
.A(pc_f), 
.B(32'h4), 
.Y(pc_plus4_f)
    );

// Fetch - Decode Pipeline Register

register_FD pipeline_register_FD (
.clk(clk), 
.reset(reset), 
.clear(flush_d), 
.enable(~stall_d),
.instr_f(instr_f), 
.pc_f(pc_f), 
.pc_plus4_f(pc_plus4_f),
.instr_d(instr_d), 
.pc_d(pc_d), 
.pc_plus4_d(pc_plus4_d)
    );
    
//Decode Stage

reg_file reg_file (
.clk(clk), 
.WE3(reg_write_w), 
.RA1(rs1_d), 
.RA2(rs2_d), 
.WA3(rd_w), 
.WD3(result_w), 
.RD1(rd1_d), 
.RD2(rd2_d)
    );
    
extend extend (
.instr(instr_d[31:7]), 
.imm_src(imm_src_d), 
.imm_ext(imm_ext_d)
    );
    
// Decode - Execute Pipeline Register	

register_DE pipeline_register_DE(
.clk(clk), 
.reset(reset), 
.clear(flush_e),
.rd1_d(rd1_d), 
.rd2_d(rd2_d), 
.pc_d(pc_d),
.imm_ext_d(imm_ext_d), 
.pc_plus4_d(pc_plus4_d),
.rs1_d(rs1_d), 
.rs2_d(rs2_d), 
.rd_d(rd_d), 
.rd1_e(rd1_e), 
.rd2_e(rd2_e), 
.pc_e(pc_e),
.imm_ext_e(imm_ext_e), 
.pc_plus4_e(pc_plus4_e),
.rs1_e(rs1_e), 
.rs2_e(rs2_e), 
.rd_e(rd_e)
    );

// Execute Stage

mux_3 forward_a_mux (
.A(rd1_e), 
.B(result_w), 
.C(arith_result_m), 
.S(forward_a_e), 
.Y(src_a_result)
    );

mux_2 src_a_mux (
.A(src_a_result), 
.B(32'h0), 
.S(alu_src_a_e), 
.Y(src_a_e)
    );

mux_3 forward_b_mux (
.A(rd2_e), 
.B(result_w), 
.C(arith_result_m), 
.S(forward_b_e), 
.Y(write_data_e)
    );

mux_3 src_b_mux (
.A(write_data_e), 
.B(imm_ext_e), 
.C(pc_target_e), 
.S(alu_src_b_e), 
.Y(src_b_e)
    ); 

adder pc_adder_branch (
.A(pc_e), 
.B(imm_ext_e),
.Y(pc_target_e)
    );
 
alu alu (
.A(src_a_e), 
.B(src_b_e), 
.arith_control(arith_control_e), 
.alu_result(alu_result_e),
.zero(zero_e),
.negetive(negetive_e), 
.carry(carry_e), 
.overflow(overflow_e)
    );

multiply multiply(
.A(src_a_e), 
.B(write_data_e),
.mult_control(arith_control_e),
.mult_result(mult_result_e)
    );

mux_2 arith_result_mux (
.A(alu_result_e), 
.B(mult_result_e), 
.S(arith_result_src_e), 
.Y(arith_result_e)
    );

store_unit store_unit (
.store_src(store_src_e),
.write_data(write_data_e),
.store_address(arith_result_e),
.store_data(store_data_e)
    );
    
// Execute - Memory Pipeline Register

register_EM pipeline_register_EM(
.clk(clk), 
.reset(reset),
.arith_result_e(arith_result_e), 
.store_data_e(store_data_e),
.pc_plus4_e(pc_plus4_e),
.rd_e(rd_e), 
.arith_result_m(arith_result_m), 
.store_data_m(store_data_m),
.pc_plus4_m(pc_plus4_m),
.rd_m(rd_m)
    );

// Memory Stage

load_unit load_unit (
.load_src(load_src_m),
.read_data(read_data_m),
.load_address(arith_result_m),
.load_data(load_data_m)
    );

// Memory - Writeback Pipeline Register

register_MW pipeline_register_MW(
.clk(clk), 
.reset(reset),
.arith_result_m(arith_result_m), 
.load_data_m(load_data_m),  
.rd_m(rd_m), 
.pc_plus4_m(pc_plus4_m),
.arith_result_w(arith_result_w), 
.load_data_w(load_data_w),
.rd_w(rd_w), 
.pc_plus4_w(pc_plus4_w)
    );

// Writeback Stage

mux_3 result_mux (
.A(arith_result_w), 
.B(load_data_w), 
.C(pc_plus4_w), 
.S(result_src_w), 
.Y(result_w)
    ); 

endmodule
