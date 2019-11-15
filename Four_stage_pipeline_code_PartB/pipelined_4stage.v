`timescale 1ns / 1ps
`include "define.v"

module pipelined_regfile_4stage(clk, rst, aluout_EXE_WB);

input clk;				
											
input	rst;

	
output [`DSIZE-1:0] aluout_EXE_WB;

wire [`DSIZE-1:0] aluout;
wire [31:0] inst_in_IF;
wire [31:0] inst_out;
wire [2:0] aluop;
wire [2:0] aluop_ID;
wire alusrc;
wire alusrc_ID;
wire regDST;
wire wen;
wire [`DSIZE-1:0] rdata1_reg;
wire [`DSIZE-1:0] rdata1_reg_ID;
wire [`DSIZE-1:0] rdata2_reg;
wire [`DSIZE-1:0] rdata2_reg_ID;
wire [`DSIZE-1:0] wdata_out;
wire [`ASIZE-1:0] waddr_out;

wire [`ISIZE - 1:0]nextPC;
wire [`ISIZE - 1:0]currPC;

PC P0(
.clk(clk),
.rst(rst),
.nextPC(currPC),
.currPC(currPC)
);

memory M0(
.clk(clk),
.rst(rst),
.wen(0),
.addr(currPC),
.data_in(aluout),
.data_out(inst_in_IF)
);

IF_ID IF0(
.clk(clk),
.rst(rst),
.instrin(inst_in_IF),
.instrout(inst_out));
wire [`ASIZE-1:0]waddr_WB; 
wire [`DSIZE-1:0]rdata2_imm = {16'b0,inst_out[15:0]};
wire [`DSIZE-1:0]rdata2_imm_ID;//Multiplexer to select the immediate value or rdata2 based on alusrc.
//when alusrc is 1 then connect immediate data to output else connect rdata2 to output

wire [`ASIZE-1:0]waddr_regDST=regDST ? inst_out[15:11] : inst_out[20:16];//Multiplexer to select the inst[15:11] or inst[20:16] as the waddr based on regDST.
//when regDST is 1 then connect inst[15:11] to output else connect inst[20:16] to output
wire [`ASIZE-1:0]waddr_regDST_ID;

//Here you need to instantiate the control , Alu , regfile and the delay registers.
//Instantiating the control unit
control C0(
.inst_cntrl(inst_out[31:26]),
.wen_cntrl(wen),
.alusrc_cntrl(alusrc),
.regdst_cntrl(regDST),
.aluop_cntrl(aluop));
//Instantiating the register file
regfile RF0(
.clk(clk),
.rst(rst),
.wen(wen),
.raddr1(inst_out[25:21]),
.raddr2(inst_out[20:16]),
.waddr(waddr_WB),
.wdata(aluout_EXE_WB),
.rdata1(rdata1_reg),
.rdata2(rdata2_reg));
//Instantiating the ID_EXE register
ID_EXEstage ID_EXE0(
.clk(clk),
.rst(rst),
.alusrc_cntrl_in(alusrc),
.aluop_cntrl_in(aluop),
.rdata1_in(rdata1_reg),
.rdata2_in(rdata2_reg),
.bit_extval_in(rdata2_imm),
.inp(waddr_regDST),
.alusrc_cntrl_out(alusrc_ID),
.aluop_cntrl_out(aluop_ID),
.rdata1_out(rdata1_reg_ID),
.rdata2_out(rdata2_reg_ID),
.bit_extval_out(rdata2_imm_ID),
.out(waddr_regDST_ID)
);

wire [`DSIZE-1:0]b_inp=alusrc_ID ? rdata2_imm_ID : rdata2_reg_ID;
//ALU Instantiation
alu ALU0(
.a(rdata1_reg_ID),
.b(b_inp),
.op(aluop_ID),
.out(aluout));



EXE_WBstage exe0(
.clk(clk),
.rst(rst),
.waddr_in(waddr_regDST_ID),
.aluoutput_in(aluout),
.waddr_out(waddr_WB),
.aluoutput_out(aluout_EXE_WB)
);								
 	 


endmodule


