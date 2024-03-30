`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 20:11:22
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(
input logic [2:0] funct_3,
output logic [2:0] branch_src
    );

always_comb
begin
    case(funct_3)
        3'h0: branch_src = 3'b000; //beq
        3'h1: branch_src = 3'b001; //bne
        3'h4: branch_src = 3'b010; //blt
        3'h5: branch_src = 3'b011; //bge
        3'h6: branch_src = 3'b100; //bltu
        3'h7: branch_src = 3'b101; //bgeu
        default: branch_src = 3'b000;
    endcase
end

endmodule
