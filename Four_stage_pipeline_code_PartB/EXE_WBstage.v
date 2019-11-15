`include "define.v"

module EXE_WBstage (
	
	input  clk,  rst,
	input  [4:0] waddr_in,
	input [`DSIZE-1:0] aluoutput_in,
	output reg [4:0] waddr_out,
	output reg [`DSIZE-1:0] aluoutput_out
);

always @ (posedge clk) begin
	if (rst)
	begin
		waddr_out <= 0;
		aluoutput_out <= 0;
	end
	else
	begin
		waddr_out <= waddr_in;
        aluoutput_out <= aluoutput_in;
	
	end
end 



//EXE_WWB register to save the values.


endmodule


