module Decode_Cycle(clk, rst, InstrD, PCPlus4D, RegWriteW, RDW, ResultW, RegWriteE, 
                    ALUSrcE, ResultSrcE, BranchE,  ALUControlE, RD1_E, RD2_E, 
                    Imm_Ext_E, RD_E, PCE, PCPlus4E, RS1_E, RS2_E, PCD, MemWriteE);

input clk, rst, RegWriteW;
input [31:0] InstrD, PCD, PCPlus4D, ResultW;
input [4:0] RDW;

output RegWriteE,ALUSrcE,MemWriteE,BranchE, ResultSrcE;
output [2:0] ALUControlE;
output [31:0] RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E;
output [4:0] RS1_E, RS2_E, RD_E;

wire RegWriteD, ALUSrcD, MemWriteD, BranchD, ResultSrcD;
wire [1:0] ImmSrcD;
wire [2:0] ALUControlD;
wire [31:0] RD1_D, RD2_D, Imm_Ext_D; 

reg RegWriteD_reg, ALUSrcD_reg, MemWriteD_reg, ResultSrcD_reg, BranchD_reg;
reg [2:0] ALUControlD_reg; 
reg [31:0] RD1_D_reg, RD2_D_reg, Imm_Ext_D_reg, PCPlus4D_reg, PCD_reg; 
reg [4:0] RS2_D_reg, RS1_D_reg, RD_D_reg;
 
Control_Unit_Top control(
    .op(InstrD[6:0]),
    .RegWrite(RegWriteD),
    .ImmSrc(ImmSrcD),
    .ALUSrc(ALUSrcD),
    .MemWrite(MemWriteD),
    .ResultSrc(ResultSrcD),
    .Branch(BranchD),
    .funct3(InstrD[14:12]),
    .funct7(InstrD[31:25]),
    .ALUControl(ALUControlD)
);

Register_files rf (
    .A1(InstrD[19:15]), 
    .A2(InstrD[24:20]), 
    .A3(RDW), 
    .RD1(RD1_D), 
    .RD2(RD2_D), 
    .clk(clk), 
    .rst(rst), 
    .WD3(ResultW),
    .WE3(RegWriteW)
);

Sign_Extend extension(
    .In(InstrD[31:0]), 
    .Imm_Ext(Imm_Ext_D),
    .ImmSrc(ImmSrcD)
);

always @(posedge clk or negedge rst) begin

    if(rst == 1'b0) begin
            RegWriteD_reg <= 1'b0;
            ALUSrcD_reg <= 1'b0;
            MemWriteD_reg <= 1'b0;
            ResultSrcD_reg <= 1'b0;
            BranchD_reg <= 1'b0;
            ALUControlD_reg <= 3'b000;
            RD1_D_reg <= 32'h00000000; 
            RD2_D_reg <= 32'h00000000; 
            Imm_Ext_D_reg <= 32'h00000000;
            RD_D_reg <= 5'h00;
            PCD_reg <= 32'h00000000; 
            PCPlus4D_reg <= 32'h00000000;
            RS1_D_reg <= 5'h00;
            RS2_D_reg <= 5'h00;
    end
    else begin
            RegWriteD_reg <= RegWriteD;
            ALUSrcD_reg <= ALUSrcD;
            MemWriteD_reg <= MemWriteD;
            ResultSrcD_reg <= ResultSrcD;
            BranchD_reg <= BranchD;
            ALUControlD_reg <= ALUControlD;
            RD1_D_reg <= RD1_D; 
            RD2_D_reg <= RD2_D; 
            Imm_Ext_D_reg <= Imm_Ext_D;
            RD_D_reg <= InstrD[11:7];
            PCD_reg <= PCD; 
            PCPlus4D_reg <= PCPlus4D;
            RS1_D_reg <= InstrD[19:15];
            RS2_D_reg <= InstrD[24:20];
    end
end

assign RegWriteE = RegWriteD_reg;
assign ALUSrcE = ALUSrcD_reg;
assign MemWriteE = MemWriteD_reg;
assign ResultSrcE = ResultSrcD_reg;
assign BranchE = BranchD_reg;
assign ALUControlE = ALUControlD_reg;
assign RD1_E = RD1_D_reg;
assign RD2_E = RD2_D_reg;
assign Imm_Ext_E = Imm_Ext_D_reg;
assign RD_E = RD_D_reg;
assign PCE = PCD_reg;
assign PCPlus4E = PCPlus4D_reg;
assign RS1_E = RS1_D_reg;
assign RS2_E = RS2_D_reg;

endmodule