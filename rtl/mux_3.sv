`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 22:41:31
// Design Name: 
// Module Name: mux_3
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


module mux_3(
input logic [31:0] A, B, C,
input logic [1:0] S,
output logic [31:0] Y
    );

assign Y = (S[1])? C:((S[0])? B:A);

endmodule