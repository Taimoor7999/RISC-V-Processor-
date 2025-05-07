module Write_Back_Cycle(clk, rst, ResultSrcW, PCPlus4W, ALU_ResultW, ReadDataW, ResultW);

input clk, rst, ResultSrcW;
input [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

output [31:0] ResultW;

MUX result_MUX(
    .a(ALU_ResultW),
    .b(ReadDataW),
    .c(ResultW),
    .s(ResultSrcW)
);

endmodule