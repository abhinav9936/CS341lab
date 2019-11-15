`include "define.v"

module ID_EXEstage (
	
	input  clk,  
	input  rst, 
    input  alusrc_cntrl_in,
    input [2:0] aluop_cntrl_in,
    input  [`DSIZE-1:0] rdata1_in,
    input  [`DSIZE-1:0] rdata2_in,
    input [`ISIZE-1:0] bit_extval_in, 
    input  [4:0] inp,  
    output  reg alusrc_cntrl_out,
    output  reg [2:0] aluop_cntrl_out,
    output  reg [`DSIZE-1:0] rdata1_out,
    output  reg [`DSIZE-1:0] rdata2_out,
    output  reg [`ISIZE-1:0] bit_extval_out,
    output reg [4:0] out
);

always @ (posedge clk) begin
	if (rst)
	begin
		alusrc_cntrl_out <= 0;
		aluop_cntrl_out <= 0;
		rdata1_out <= 0;
		rdata2_out <= 0;
		bit_extval_out <= 0;
		out <= 0;
	end
	else
	begin
		alusrc_cntrl_out <= alusrc_cntrl_in;
        aluop_cntrl_out <= aluop_cntrl_in;
        rdata1_out <= rdata1_in;
        rdata2_out <= rdata2_in;
        bit_extval_out <= bit_extval_in;
        out <= inp;
	
	end
end 

endmodule


//Here we need not take write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.


