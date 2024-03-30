`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 22:47:21
// Design Name: 
// Module Name: flipflop
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


module flipflop(
input logic clk, reset, enable,
input logic [31:0] D,
output logic [31:0] Q);
					
always_ff @(posedge clk, posedge reset)
begin	
    if(reset) 
        Q <= 0;
    else if(enable) 
        Q <= D;
end

endmodule
