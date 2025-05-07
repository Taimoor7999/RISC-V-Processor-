//New Files (Only Pipeline)

`include "Fetch_Cycle.v"
`include "Decode_Cycle.v"
`include "Execute_Cycle.v"
`include "Memory_Cycle.v"
`include "Write_Back_Cycle.v"
`include "Hazard_Unit.v"

//Old Files (Single Cycle)

`include "Program_counter.v"
`include "PC_Adder.v"
`include "MUX.v"
`include "MUX_3_to_1.v"
`include "instruction_memory.v"
`include "Control_Unit_Top.v"
`include "Register_files.v"
`include "Sign_Extend.v"
`include "ALU_advance.v"
`include "Data_Memory.v"

module Pipeline_Top(clk, rst);

input clk, rst;

wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,
     RegWriteM, MemWriteM, ResultSrcM;
wire ResultSrcW;
wire [2:0] ALUControlE;
wire [4:0] RDW, RD_E, RS1_E, RS2_E, RD_M;
wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1_E, RD2_E, Imm_Ext_E,  
            PCPlus4E, PCPlus4M, WriteDataM, ALU_ResultM, PCPlus4W, ALU_ResultW, 
            ReadDataW, PCE;
wire [1:0] ForwardAE, ForwardBE ;

Fetch_Cycle Fetch (
    .clk(clk), 
    .rst(rst),
    .PCSrcE(PCSrcE), 
    .PCTargetE(PCTargetE), 
    .InstrD(InstrD), 
    .PCD(PCD), 
    .PCPlus4D(PCPlus4D)
);

Decode_Cycle Decode(
    .clk(clk), 
    .rst(rst), 
    .InstrD(InstrD), 
    .PCD(PCD), 
    .PCPlus4D(PCPlus4D), 
    .RegWriteW(RegWriteW), 
    .RDW(RDW), 
    .ResultW(ResultW), 
    .RegWriteE(RegWriteE), 
    .ALUSrcE(ALUSrcE), 
    .MemWriteE(MemWriteE), 
    .ResultSrcE(ResultSrcE), 
    .BranchE(BranchE),  
    .ALUControlE(ALUControlE), 
    .RD1_E(RD1_E), 
    .RD2_E(RD2_E), 
    .Imm_Ext_E(Imm_Ext_E), 
    .RD_E(RD_E), 
    .PCE(PCE), 
    .PCPlus4E(PCPlus4E), 
    .RS1_E(RS1_E), 
    .RS2_E(RS2_E)
);

Execute_Cycle Execute(
    .clk(clk), 
    .rst(rst), 
    .RegWriteE(RegWriteE),
    .ALUSrcE(ALUSrcE), 
    .MemWriteE(MemWriteE), 
    .ResultSrcE(ResultSrcE), 
    .BranchE(BranchE), 
    .ALUControlE(ALUControlE), 
    .RD1_E(RD1_E), 
    .RD2_E(RD2_E), 
    .Imm_Ext_E(Imm_Ext_E), 
    .RD_E(RD_E), 
    .PCE(PCE), 
    .PCPlus4E(PCPlus4E), 
    .PCTargetE(PCTargetE),
    .RegWriteM(RegWriteM), 
    .MemWriteM(MemWriteM), 
    .ResultSrcM(ResultSrcM), 
    .RD_M(RD_M), 
    .PCPlus4M(PCPlus4M), 
    .WriteDataM(WriteDataM), 
    .ALU_ResultM(ALU_ResultM), 
    .PCSrcE(PCSrcE),
    .ForwardA_E(ForwardAE), 
    .ForwardB_E(ForwardBE),
    .ResultW(ResultW)
);

Memory_Cycle Memory(
    .clk(clk), 
    .rst(rst), 
    .RegWriteM(RegWriteM), 
    .MemWriteM(MemWriteM), 
    .ResultSrcM(ResultSrcM), 
    .RD_M(RD_M), 
    .PCPlus4M(PCPlus4M), 
    .WriteDataM(WriteDataM), 
    .ALU_ResultM(ALU_ResultM), 
    .PCPlus4W(PCPlus4W), 
    .ALU_ResultW(ALU_ResultW), 
    .ReadDataW(ReadDataW),
    .RD_W(RDW), 
    .RegWriteW(RegWriteW), 
    .ResultSrcW(ResultSrcW)
);

Write_Back_Cycle Write_Back(
    .clk(clk), 
    .rst(rst), 
    .ResultSrcW(ResultSrcW), 
    .PCPlus4W(PCPlus4W), 
    .ALU_ResultW(ALU_ResultW), 
    .ReadDataW(ReadDataW), 
    .ResultW(ResultW)
);

Hazard_Unit Forwarding_block (
    .rst(rst), 
    .RegWriteM(RegWriteM), 
    .RegWriteW(RegWriteW), 
    .RD_M(RD_M), 
    .RD_W(RDW), 
    .Rs1_E(RS1_E), 
    .Rs2_E(RS2_E), 
    .ForwardAE(ForwardAE), 
    .ForwardBE(ForwardBE)
); 

endmodule