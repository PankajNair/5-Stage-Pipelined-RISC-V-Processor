`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 12:51:35
// Design Name: 
// Module Name: inst_memory
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


module inst_memory(
input logic [31:0] A,
output logic [31:0] RD
    );

logic [31:0] IM [63:0];

initial
begin
    $readmemh("riscvtest.mem", IM);
end

assign RD = IM[A[31:2]];
    
endmodule
