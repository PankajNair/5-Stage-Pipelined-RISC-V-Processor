`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 12:53:44
// Design Name: 
// Module Name: processor_top
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

//For Simulation

//module processor_top(
//input logic clk, reset, 
//output logic [31:0] data_address_m, store_data_m,
//output logic mem_write_m
//    );

//logic [31:0] pc_f, instr_f, read_data_m;

//For FPGA Implementation

module processor_top(
input logic clk, reset, 
output logic [5:0] out_data,
output logic mem_write_m
    );

logic [31:0] pc_f, instr_f, read_data_m, data_address_m, store_data_m;
assign out_data = store_data_m[5:0];

processor_core processor_core (
.clk(clk), 
.reset(reset),
.instr_f(instr_f),
.read_data_m(read_data_m),
.mem_write_m(mem_write_m),
.pc_f(pc_f),
.arith_result_m(data_address_m), 
.store_data_m(store_data_m)
    );

inst_memory inst_memory (
.A(pc_f),
.RD(instr_f)
    );

data_memory data_memory (
.clk(clk), 
.WE(mem_write_m), 
.A(data_address_m), 
.WD(store_data_m), 
.RD(read_data_m)
    );

endmodule
