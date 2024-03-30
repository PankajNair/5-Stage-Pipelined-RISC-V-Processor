`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 21:07:05
// Design Name: 
// Module Name: register_FD
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


module register_FD (
input logic clk, reset, clear, enable,
input logic [31:0] instr_f, pc_f, pc_plus4_f,
output logic [31:0] instr_d, pc_d, pc_plus4_d
    );


always_ff @(posedge clk, posedge reset) 
begin
    if(reset) 
        begin
            instr_d <= 0;
            pc_d <= 0;
            pc_plus4_d <= 0;
        end
    else if(enable) 
        begin 
             if (clear) 
                 begin
                      instr_d <= 0;
                      pc_d <= 0;
                      pc_plus4_d <= 0;	 
                 end         
             else 
                 begin	 
                      instr_d <= instr_f;
                      pc_d <= pc_f;
                      pc_plus4_d <= pc_plus4_f;
                 end
        end
end

endmodule