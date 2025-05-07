module Fetch_Cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

input clk,rst,PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD, PCD, PCPlus4D;

wire [31:0] PCPlus4F, PC_F, PCF, InstrF;
reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;

MUX PC_MUX(

    .a(PCPlus4F),
    .b(PCTargetE),
    .c(PC_F),
    .s(PCSrcE)
);

Program_counter PC_Module(

    .pc_next(PC_F), 
    .pc(PCF), 
    .clk(clk), 
    .rst(rst)
);

instruction_memory IMeM(
    
    .A(PCF),
    .RD(InstrF),
    .rst(rst)
);

PC_Adder PC_Adder_Fetch(

    .a(PCF),
    .b(32'h00000004),
    .c(PCPlus4F)
);

always @(posedge clk or negedge rst)
begin
  if (rst == 1'b0) begin
    InstrF_reg <= 32'h00000000;
    PCF_reg <= 32'h00000000;
    PCPlus4F_reg <= 32'h00000000;
  end

  else begin
    InstrF_reg <= InstrF;
    PCF_reg <= PCF;
    PCPlus4F_reg <= PCPlus4F;
   end
end

assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
assign PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
assign PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;

endmodule