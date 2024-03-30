`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 22:34:20
// Design Name: 
// Module Name: multiply
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


module multiply (
input logic [31:0] A, B,
input logic [4:0] mult_control,
output logic signed [31:0] mult_result
    );

logic signed [63:0] p_ss, p_su, p_uu, d_ss, d_uu;

mult_gen_0_ss multiplier_ss (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .P(p_ss)    // output wire [63 : 0] P
);

mult_gen_0_su multiplier_su (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .P(p_su)    // output wire [63 : 0] P
);

mult_gen_0_uu multiplier_uu (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .P(p_uu)    // output wire [63 : 0] P
);


always_comb
begin
    case(mult_control)
        5'ha: mult_result = p_ss[31:0];                 //mul
        5'hb: mult_result = p_ss[63:32];                //mulh
        5'hc: mult_result = p_su[63:32];                //mulsu
        5'hd: mult_result = p_uu[63:32];                //mulu
        default: mult_result = 32'bx;
    endcase
end

endmodule
