`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 02:35:52
// Design Name: 
// Module Name: control_unit
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


module control_unit(
input logic clk, reset,
input logic [6:0] op,
input logic [2:0] funct_3,
input logic	[6:0] funct_7,
input logic zero_e, negetive_e, carry_e, overflow_e,
input logic flush_e,
output logic result_src_e0, arith_result_src_e,
output logic mem_write_m,
output logic branch_jump_src_e, pc_src_e, alu_src_a_e, 
output logic reg_write_m, reg_write_w,
output logic [4:0] arith_control_e,
output logic [2:0] imm_src_d, load_src_m,
output logic [1:0] result_src_w, store_src_e,
output logic [1:0] alu_src_b_e
    );

logic branch_op, branch_d, branch_e, mem_write_d, mem_write_e, jump_d, jump_e;
logic alu_src_a_d, reg_write_d, reg_write_e, arith_result_src_d;
logic [4:0] arith_control_d;
logic [2:0] load_src_d, load_src_e, branch_src;
logic [1:0] arith_op_d, store_src_d;
logic [1:0] result_src_d, result_src_e, result_src_m;
logic [1:0] alu_src_b_d;

main_decoder main_decoder (
.op(op),
.mem_write(mem_write_d),
.branch(branch_d), 
.alu_src_a(alu_src_a_d), 
.reg_write(reg_write_d), 
.jump(jump_d),
.imm_src(imm_src_d),
.result_src(result_src_d),
.alu_src_b(alu_src_b_d),
.arith_op(arith_op_d)
	);

alu_decoder alu_decoder(
.funct_3(funct_3),
.funct_7(funct_7),
.arith_op(arith_op_d),
.arith_control(arith_control_d)
    );

branch_unit branch_unit(
.funct_3(funct_3),
.branch_src(branch_src)
    );
    
load_store_unit load_store_unit(
.funct_3(funct_3),
.load_src(load_src_d),
.store_src(store_src_d)
    );
    
control_register_DE pipeline_control_register_DE (
.clk(clk), 
.reset(reset), 
.clear(flush_e),
.reg_write_d(reg_write_d), 
.mem_write_d(mem_write_d), 
.jump_d(jump_d), 
.branch_d(branch_d), 
.alu_src_a_d(alu_src_a_d), 
.arith_result_src_d(arith_result_src_d),
.arith_control_d(arith_control_d), 
.load_src_d(load_src_d),
.alu_src_b_d(alu_src_b_d), 
.result_src_d(result_src_d), 
.store_src_d(store_src_d),  
.reg_write_e(reg_write_e), 
.mem_write_e(mem_write_e), 
.jump_e(jump_e), 
.branch_e(branch_e),  
.alu_src_a_e(alu_src_a_e), 
.arith_result_src_e(arith_result_src_e),
.arith_control_e(arith_control_e),
.load_src_e(load_src_e),
.alu_src_b_e(alu_src_b_e), 
.result_src_e(result_src_e), 
.store_src_e(store_src_e)
    );
 
control_register_EM pipeline_control_register_EM (
.clk(clk), 
.reset(reset),
.reg_write_e(reg_write_e), 
.mem_write_e(mem_write_e),
.load_src_e(load_src_e),
.result_src_e(result_src_e),  
.reg_write_m(reg_write_m), 
.mem_write_m(mem_write_m),
.load_src_m(load_src_m),
.result_src_m(result_src_m)
    );

control_register_MW pipeline_control_register_MW (
.clk(clk),
.reset(reset), 
.reg_write_m(reg_write_m), 
.result_src_m(result_src_m), 
.reg_write_w(reg_write_w), 
.result_src_w(result_src_w)
    );

always_comb
begin
    case(branch_src)
        3'b000: branch_op = zero_e;
        3'b001: branch_op = ~zero_e;
        3'b010: branch_op = negetive_e ^ overflow_e;
        3'b011: branch_op = ~carry_e;
        3'b100: branch_op = ~(negetive_e ^ overflow_e);
        3'b101: branch_op = carry_e;
        default: branch_op = 0;
    endcase
end

assign pc_src_e = (branch_e & branch_op) | jump_e;
assign arith_result_src_d = (op==7'b0110011 & funct_7 == 7'h01)? 1'b1: 1'b0;
assign result_src_e0 = result_src_e[0];
assign branch_jump_src_e = (op == 7'b1100111)? 1:0;

endmodule
