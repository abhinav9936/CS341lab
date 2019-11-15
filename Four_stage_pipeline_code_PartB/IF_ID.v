`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2019 23:26:02
// Design Name: 
// Module Name: IF_ID
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

module IF_ID(
	
	input  clk, 
    input rst,	
	input [`ISIZE-1:0] instrin, 

	output reg [`ISIZE-1:0] instrout
	
);




always @ (posedge clk) begin
	if (rst)
	begin
		instrout <= 0;
	end
	else
	begin
		instrout <= instrin;
	
	end
end 

endmodule
