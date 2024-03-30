`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 20:38:28
// Design Name: 
// Module Name: load_store_unit
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


module load_store_unit(
input logic [2:0] funct_3,
output logic [2:0] load_src,
output logic [1:0] store_src
    );
    
always_comb
begin
    case(funct_3)
        3'h0: load_src =  3'b000; //lb
        3'h1: load_src = 3'b001; //lh
        3'h2: load_src = 3'b010; //lw
        3'h4: load_src = 3'b011; //lbu
        3'h5: load_src = 3'b100; //lhu
        default: load_src = 3'b010;
    endcase
end

always_comb
begin
    case(funct_3)
        3'h0: store_src = 2'b00; //sb
        3'h1: store_src = 2'b01; //sh
        3'h2: store_src = 2'b10; //sw
        default: store_src = 2'b10;
    endcase
end    
    
endmodule
