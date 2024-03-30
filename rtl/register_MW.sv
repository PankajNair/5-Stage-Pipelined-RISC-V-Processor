`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 21:51:10
// Design Name: 
// Module Name: register_MW
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


module register_MW (
input logic clk, reset,
input logic [31:0] arith_result_m, load_data_m,  
input logic [4:0] rd_m, 
input logic [31:0] pc_plus4_m,
output logic [31:0] arith_result_w, load_data_w,
output logic [4:0] rd_w, 
output logic [31:0] pc_plus4_w
    );

always_ff @(posedge clk, posedge reset) 
begin 
    if (reset) 
        begin
            arith_result_w <= 0;
            load_data_w <= 0;          
            rd_w <= 0; 
            pc_plus4_w <= 0;
        end
    else 
        begin
            arith_result_w <= arith_result_m;
            load_data_w <= load_data_m;       
            rd_w <= rd_m; 
            pc_plus4_w <= pc_plus4_m;        
        end 
end

endmodule
