`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 12:48:50
// Design Name: 
// Module Name: data_memory
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


module data_memory(
input logic clk, WE, 
input logic [31:0] A, WD, 
output logic [31:0] RD
    );
		
logic [31:0] DM [63:0];

always_ff @(posedge clk)
begin
    if(WE) 
        DM[A[31:2]] <= WD;
end

assign RD = DM[A[31:2]];
	
endmodule