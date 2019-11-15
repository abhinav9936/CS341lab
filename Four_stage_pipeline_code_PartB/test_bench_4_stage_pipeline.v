`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: IIT Goa
// Engineer:

// 
////////////////////////////////////////////////////////////////////////////////

module test_bench_4_stage_pipeline;

	// Inputs
	reg clk;
	reg rst;


	// Outputs

	wire [31:0] aluout_EXE_WB;

	// Instantiate the Unit Under Test (UUT)
	pipelined_regfile_4stage uut (
		.clk(clk), 
		.rst(rst), 
		.aluout_EXE_WB(aluout_EXE_WB)
	);

always #15 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk <= 0;
		rst <= 0;
		


		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        #10 rst <=1;
        #50 rst <=0;


	end
      
endmodule

