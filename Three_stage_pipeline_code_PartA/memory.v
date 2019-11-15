`include "define.v"
//Here memory is implemented as just reading from a file.

module memory( clk, rst, wen, addr, data_in, data_out);//This memory can be used as instruction as well as data memory

  input clk;
  input rst;
  input wen;					// if wen=1, we can write into memory and this is made used by datamemory. For Imem- wen=0
  input [`ISIZE-1:0] addr;      // address input  
  input [`DSIZE-1:0] data_in;   // data input				// file id selects which among the files given below (0 for imem) 
								// and (1 for D-mem inputs). For this assignment we are using fileid=0
  output [`DSIZE-1:0] data_out; // data output

  reg [`DSIZE-1:0] memory [0:32*`ISIZE-1]; // size of the memory
  //reg [8*`MAX_LINE_LENGTH:0] line; 		   // Line of text read from file


assign data_out = memory[addr];		   // Reading from the memory. 
										   

  always @(posedge clk)
    begin
      if(rst)
        begin
        memory[0] <= 32'h00000000;
        memory[1] <= 32'h05031000;
        memory[2] <= 32'h00430800;
        memory[3] <= 32'h0901F000;
        memory[4] <= 32'h1502F800;
        memory[5] <= 32'h03fa5000;
        memory[6] <= 32'h18E40001;
        memory[7] <= 32'h00000000;
        memory[8] <= 32'h00000000;
	end
      else
        begin
          if (wen)// active-high write enable
            begin            
              memory[addr] <= data_in;
            end
	end
    end

endmodule