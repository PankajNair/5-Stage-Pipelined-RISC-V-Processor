`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 21:45:45
// Design Name: 
// Module Name: register_EM
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


module register_EM (
input logic clk, reset,
input logic [31:0] arith_result_e, store_data_e,
input logic [31:0] pc_plus4_e,
input logic [4:0] rd_e, 
output logic [31:0] arith_result_m, store_data_m,
output logic [31:0] pc_plus4_m,
output logic [4:0] rd_m
    );

always_ff @( posedge clk, posedge reset ) 
begin 
    if(reset) 
        begin
            arith_result_m <= 0;
            store_data_m <= 0;
            rd_m <= 0; 
            pc_plus4_m <= 0;
        end
    else
        begin
            arith_result_m <= arith_result_e;
            store_data_m <= store_data_e;
            rd_m <= rd_e; 
            pc_plus4_m <= pc_plus4_e;        
        end
end

endmodule
