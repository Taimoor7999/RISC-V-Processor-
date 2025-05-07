`include "ALU_decoder.v"
`include "Main_Decoder.v"

module Control_Unit_Top(op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

    input [6:0]op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc;
    output [2:0]ALUControl;
  
    wire [1:0] ALUop;

Main_Decoder Main_Decoder(
                .op(op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUop(ALUop)
);

ALU_decoder ALU_decoder(
        .ALUop(ALUop), 
        .funct3(funct3), 
        .funct7(funct7), 
        .ALUControl(ALUControl), 
        .op(op)
);

endmodule