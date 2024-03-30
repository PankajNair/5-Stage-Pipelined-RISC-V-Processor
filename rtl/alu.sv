`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 22:25:41
// Design Name: 
// Module Name: alu
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


module alu (
input logic [31:0] A, B,
input logic [4:0] arith_control,
output logic signed [31:0] alu_result,
output logic zero, negetive, carry, overflow
    );

logic cout;
logic [31:0] sum;
assign {cout, sum} = A + (arith_control[0]? ~B:B) + arith_control[0];

always_comb
begin
    case(arith_control)
        5'h0: alu_result = $signed(sum);                        //add
        5'h1: alu_result = $signed(sum);                        //sub
        5'h2: alu_result = $signed(A) & $signed(B);             //and
        5'h3: alu_result = $signed(A) | $signed(B);             //or
        5'h4: alu_result = $signed(A) ^ $signed(B);             //xor
        5'h5: alu_result = {31'b0,($signed(A) < $signed(B))};   //slt
        5'h6: alu_result = {31'b0,(A<B)};                       //sltu
        5'h7: alu_result = $signed(A) << $signed(B);            //sll
        5'h8: alu_result = $signed(A) >>> $signed(B);           //sra
        5'h9: alu_result = $signed(A) >> $signed(B);            //srl
        default: alu_result = 32'bx;
    endcase
end

assign carry = cout & (~arith_control[1]);
assign zero = (alu_result == 32'b0);
assign negetive = alu_result[31];
assign overflow = ~(arith_control[0]^B[31]^A[31]) & (A[31]^sum[31]) & (~arith_control[1]);

endmodule
