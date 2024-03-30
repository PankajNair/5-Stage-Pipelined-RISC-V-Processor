`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 22:03:26
// Design Name: 
// Module Name: reg_file
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


module reg_file (
input logic clk, WE3,
input logic [4:0] RA1, RA2, WA3,
input logic [31:0] WD3,
output logic [31:0] RD1, RD2
    );
    
logic [31:0] rf [31:0];

initial 
begin
    for(int i=0;i<32;i++)
        rf[i] = i;
end

always_ff @(negedge clk)
begin
    if(WE3)
        begin
            if(WA3 != 0)
                rf[WA3] <= WD3;
            else
                rf[0] <= 0;
        end
end

assign RD1 = (RA1!=0)? rf[RA1]: 0;
assign RD2 = (RA2!=0)? rf[RA2]: 0;

endmodule
