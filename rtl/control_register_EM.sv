`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 02:10:59
// Design Name: 
// Module Name: control_register_EM
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


module control_register_EM (
input logic clk, reset,
input logic reg_write_e, mem_write_e,
input logic [2:0] load_src_e,
input logic [1:0] result_src_e,  
output logic reg_write_m, mem_write_m,
output logic [2:0] load_src_m,
output logic [1:0] result_src_m
    );

always_ff @(posedge clk, posedge reset) 
begin
    if(reset) 
        begin
            reg_write_m <= 0;
            mem_write_m <= 0;
            result_src_m <= 0;
            load_src_m <= 0;
        end
    else 
        begin
            reg_write_m <= reg_write_e;
            mem_write_m <= mem_write_e;
            result_src_m <= result_src_e; 
            load_src_m <= load_src_e;
        end
end

endmodule
