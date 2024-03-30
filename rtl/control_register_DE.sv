`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 02:00:27
// Design Name: 
// Module Name: control_register_DE
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


module control_register_DE (
input logic clk, reset, clear,
input logic reg_write_d, mem_write_d, jump_d, branch_d, alu_src_a_d, arith_result_src_d,
input logic [4:0] arith_control_d, 
input logic [2:0] load_src_d,
input logic [1:0] alu_src_b_d, result_src_d, store_src_d,  
output logic reg_write_e, mem_write_e, jump_e, branch_e,  alu_src_a_e, arith_result_src_e,
output logic [4:0] arith_control_e,
output logic [2:0] load_src_e,
output logic [1:0] alu_src_b_e, result_src_e, store_src_e
    );

always_ff @(posedge clk, posedge reset) 
begin
	if(reset) 
        begin
            reg_write_e <= 0;
            mem_write_e <= 0;
            jump_e <= 0;
            branch_e <= 0; 
            alu_src_a_e <= 0;
            alu_src_b_e <= 0;
            result_src_e <= 0;
            arith_control_e <= 0;   
            arith_result_src_e <= 0;     
            load_src_e <= 0;  
            store_src_e <= 0;
        end
	else if(clear) 
	   begin
			reg_write_e <= 0;
			mem_write_e <= 0;
			jump_e <= 0;
			branch_e <= 0; 
			alu_src_a_e <= 0;
			alu_src_b_e <= 0;
			result_src_e <= 0;
			arith_control_e <= 0;   
			arith_result_src_e <= 0; 	
			load_src_e <= 0;	
			store_src_e <= 0;	
		end	
	else 
	   begin
			reg_write_e <= reg_write_d;
			mem_write_e <= mem_write_d;
			jump_e <= jump_d;
			branch_e <= branch_d; 
			alu_src_a_e <= alu_src_a_d;
			alu_src_b_e <= alu_src_b_d;
			result_src_e <= result_src_d;
			arith_control_e <= arith_control_d;   
			arith_result_src_e <= arith_result_src_d;
			load_src_e <= load_src_d;
			store_src_e <= store_src_d;
		end
end

endmodule
