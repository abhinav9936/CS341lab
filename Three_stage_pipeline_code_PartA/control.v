//control unit for write enable and ALU control

`include "define.v"

module control(
  input [5:0] inst_cntrl, 
  output reg wen_cntrl,
  output reg alusrc_cntrl,
  output reg regdst_cntrl,
  output reg [2:0] aluop_cntrl
  );
  
  always@(inst_cntrl)
  begin
 
    case(inst_cntrl)
			`ADD: begin
					wen_cntrl=1;
					alusrc_cntrl=0;
					regdst_cntrl=1;
					aluop_cntrl=inst_cntrl[2:0];
			end
        `SUB: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
					 regdst_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
        end
        `AND: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
					 regdst_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
        end
        `XOR: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
					 regdst_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
        end
     
        `COM: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
					 regdst_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
        end
        `MUL: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
					 regdst_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
			end
		`ADDI: begin
                wen_cntrl=1;
					 alusrc_cntrl=1;
					 regdst_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
        end
		  
		default: begin
				wen_cntrl=1;//the default condition is set for R type inst
				alusrc_cntrl=0;
				regdst_cntrl=1;
				aluop_cntrl=inst_cntrl[2:0];
		end	
		
    endcase
  end
  
endmodule
