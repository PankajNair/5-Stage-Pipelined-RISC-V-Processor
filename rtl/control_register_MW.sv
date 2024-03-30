`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 02:14:47
// Design Name: 
// Module Name: control_register_MW
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


module control_register_MW (
input logic clk, reset, 
input logic reg_write_m, 
input logic [1:0] result_src_m, 
output logic reg_write_w, 
output logic [1:0] result_src_w
    );

always_ff @(posedge clk, posedge reset) 
begin
    if(reset) 
        begin
            reg_write_w <= 0;
            result_src_w <= 0;           
        end
    else 
        begin
            reg_write_w <= reg_write_m;
            result_src_w <= result_src_m;
        end
end

endmodule
