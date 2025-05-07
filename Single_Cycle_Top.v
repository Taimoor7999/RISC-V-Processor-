`include "instruction_memory.v"
`include "Program_counter.v"
`include "Data_Memory.v"
`include "Register_files.v"
`include "Sign_Extend.v"
`include "ALU_advance.v"
`include "Control_Unit_Top.v"
`include "PC_Adder.v"
`include "MUX.v"

module Single_Cycle_Top(clk, rst);

input clk, rst;

wire [31:0] PC_TOP, RD_INSTR,RD1_TOP,Imm_Ext_TOP,ALUResult,ReadData,PCPlus4,RD2_TOP,SrcB,Result;
wire [2:0] ALU_Control_Top;
wire [1:0] ImmSrc;
wire RegWrite,MemWrite,ALUSrc,ResultSrc;

Program_counter Program_counter (
    .pc_next(PCPlus4), 
    .pc(PC_TOP), 
    .clk(clk), 
    .rst(rst)
);

instruction_memory instruction_memory (
    .A(PC_TOP),
    .RD(RD_INSTR),
    .rst(rst)
);

Register_files Register_files (
    .A1(RD_INSTR[19:15]), 
    .A2(RD_INSTR[24:20]), 
    .A3(RD_INSTR[11:7]), 
    .RD1(RD1_TOP), 
    .RD2(RD2_TOP), 
    .clk(clk), 
    .rst(rst), 
    .WD3(Result), 
    .WE3(RegWrite)
);

Sign_Extend Sign_Extend(
    .In(RD_INSTR), 
    .Imm_Ext(Imm_Ext_TOP),
    .ImmSrc(ImmSrc[0])
);

ALU_advance ALU_advance (
    .A(RD1_TOP),
    .B(SrcB),
    .ALUcontrol(ALU_Control_Top),
    .Result(ALUResult),
    .N(),
    .Z(),
    .C(),
    .V()
);

Control_Unit_Top Control_Unit_Top(
    .op(RD_INSTR[6:0]),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(),
    .funct3(RD_INSTR[14:12]),
    .funct7(),
    .ALUControl(ALU_Control_Top)
);

Data_Memory Data_Memory(
    .clk(clk), 
    .rst(rst),
    .A(ALUResult), 
    .WD(RD2_TOP), 
    .WE(MemWrite), 
    .RD(ReadData)
);

PC_Adder PC_Adder (
    .a(PC_TOP),
    .b(32'd4),
    .c(PCPlus4)
);

MUX Register_Files_and_Extend_to_ALU(
    .a(RD2_TOP),
    .b(Imm_Ext_TOP),
    .c(SrcB),
    .s(ALUSrc)
);

MUX ALU_and_Data_Memory_to_Register_Files(
    .a(ALUResult),
    .b(ReadData),
    .c(Result),
    .s(ResultSrc)
);

endmodule