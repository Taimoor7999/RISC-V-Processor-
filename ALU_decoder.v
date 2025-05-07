module ALU_decoder(ALUop, funct3, funct7, ALUControl, op);

output [2:0] ALUControl;
input [1:0] ALUop;
input [2:0] funct3;
input [6:0] funct7,op;

// wire concatenation;

// assign concatenation = {op,funct7};

assign ALUControl = (ALUop == 2'b00) ? 3'b000:
                    (ALUop == 2'b01) ? 3'b001:
                    ((ALUop == 2'b10) & (funct3 == 3'b000) & (({op[5],funct7[5]} == 2'b00) | 
                    ({op[5],funct7[5]} == 2'b01) | ({op[5],funct7[5]} == 2'b10))) ? 3'b000 :
                    ((ALUop == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b11))  ? 3'b001 :
                      
                    //((ALUop == 2'b10) & (funct3 == 3'b000) & (concatenation == 2'b11))  ? 3'b001 :
                    //((ALUop == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} != 2'b11)) ? 3'b000 : 

                    ((ALUop == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : 
                    ((ALUop == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :
                    ((ALUop == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 3'b000;
 
endmodule