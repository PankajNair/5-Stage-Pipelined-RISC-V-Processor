`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 13:04:41
// Design Name: 
// Module Name: testbench
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


module testbench();

logic clk = 0;
logic reset;
logic [31:0] store_data_m, data_address_m;
logic mem_write_m;

always #10 clk = ~clk;

processor_top uut(
.clk(clk),
.reset(reset),
.store_data_m(store_data_m),
.data_address_m(data_address_m),
.mem_write_m(mem_write_m));
  
initial 
begin
    reset = 1; 
    #10
    reset = 0;
end

always @(negedge clk)
begin
    if(mem_write_m) 
        begin
            if(data_address_m === 32'd100 & store_data_m === 32'd25) 
                begin
                    $display("Simulation succeeded");
                    $stop;
                end
            else if(data_address_m !== 32'd96) 
                begin
                    $display("Simulation failed");
                    $stop;
                end
        end
         
end

endmodule
