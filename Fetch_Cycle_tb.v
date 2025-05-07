module Fetch_Cycle_tb();

reg rst,PCSrcE;
reg clk=1;
reg [31:0] PCTargetE;
wire [31:0] InstrD, PCD, PCPlus4D;

Fetch_Cycle dut(
    .clk(clk), 
    .rst(rst), 
    .PCSrcE(PCSrcE), 
    .PCTargetE(PCTargetE), 
    .InstrD(InstrD), 
    .PCD(PCD), 
    .PCPlus4D(PCPlus4D)
);

always begin
    clk = ~clk;
    #50;
end

initial begin
    $dumpfile("Fetch_Cycle_tb_Simulation.vcd");
    $dumpvars(0);
end

initial begin
    rst = 1'b0;
    #200;
    rst = 1'b1;
    PCSrcE = 1'b0;
    PCTargetE = 32'b00000000;
    #900;
    // rst = 1'b0;
    // #200;
    $finish;
end

endmodule