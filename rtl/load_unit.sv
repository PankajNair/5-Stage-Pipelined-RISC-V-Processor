`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 01:28:27
// Design Name: 
// Module Name: load_unit
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


module load_unit (
input logic [2:0] load_src,
input logic [31:0] read_data,
input logic [31:0] load_address,
output logic [31:0] load_data
    );

always_comb
begin
    case (load_src)
        3'b010: load_data = read_data;   //lw
        3'b001: case(load_address[1:0])    //lh
                    2'b00: load_data = {{16{read_data[15]}},read_data[15:0]};
                    2'b01: load_data = {{16{read_data[31]}},read_data[31:16]};
                    default: load_data = {{16{read_data[15]}},read_data[15:0]};
                endcase
        3'b000: case(load_address[1:0])    //lb
                    2'b00: load_data = {{24{read_data[7]}},read_data[7:0]};
                    2'b01: load_data = {{24{read_data[15]}},read_data[15:8]};
                    2'b10: load_data = {{24{read_data[23]}},read_data[23:16]};
                    2'b11: load_data = {{24{read_data[31]}},read_data[31:24]};
                endcase
        3'b100: case(load_address[1:0])    //lhu
                    2'b00: load_data = {16'b0,read_data[15:0]};
                    2'b01: load_data = {16'b0,read_data[31:16]};
                    default: load_data = {16'b0,read_data[15:0]};
                endcase
        3'b011: case(load_address[1:0])    //lbu
                    2'b00: load_data = {24'b0,read_data[7:0]};
                    2'b01: load_data = {24'b0,read_data[15:8]};
                    2'b10: load_data = {24'b0,read_data[23:16]};
                    2'b11: load_data = {24'b0,read_data[31:24]};
                endcase
        default: load_data = read_data;
    endcase
end

endmodule
