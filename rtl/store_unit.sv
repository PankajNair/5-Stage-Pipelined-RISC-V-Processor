`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 00:00:34
// Design Name: 
// Module Name: store_unit
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


module store_unit (
input logic [1:0] store_src,
input logic [31:0] write_data,
input logic [31:0] store_address,
output logic [31:0] store_data
    );

always_comb
begin
    case(store_src)
    2'b10: store_data = write_data;  //sw
    2'b01: case(store_address[1:0])  //sh
            2'b00: store_data = {{16{write_data[15]}},write_data[15:0]};
            2'b01: store_data = {{16{write_data[31]}},write_data[31:16]};
            default: store_data = {{16{write_data[15]}},write_data[15:0]};
           endcase
    2'b00: case(store_address[1:0])  //sb
            2'b00: store_data = {{24{write_data[7]}},write_data[7:0]};
            2'b01: store_data = {{24{write_data[15]}},write_data[15:8]};
            2'b10: store_data = {{24{write_data[23]}},write_data[23:16]};
            2'b11: store_data = {{24{write_data[31]}},write_data[31:24]};
           endcase
    default: store_data = write_data;
    endcase
end

endmodule
