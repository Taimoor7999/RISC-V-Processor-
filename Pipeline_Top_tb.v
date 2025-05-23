module Pipeline_Top_tb();

reg clk = 1'b0,rst;

Pipeline_Top dut(
    .clk(clk),
    .rst(rst)
);

always begin
    clk =~ clk;
    #50;
end

initial begin
    rst <= 1'b0;
    #200;
    rst <= 1'b1;
    #1000;
    $finish;
end

initial begin
    $dumpfile("Pipeline_Top_tb_Simulation.vcd");
    $dumpvars(0);
end

endmodule