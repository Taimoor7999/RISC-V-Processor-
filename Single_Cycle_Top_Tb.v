module Single_Cycle_Top_Tb();

reg clk = 1'b0,rst;

Single_Cycle_Top Single_Cycle_Top(
    .clk(clk),
    .rst(rst)
);

initial begin
    $dumpfile("any name.vcd");
    $dumpvars(0);
end

always begin
    #50;
    clk =~ clk;
end

initial begin
    rst = 1'b0;
    #100;
    rst = 1'b1;
    #700;
    $finish;
end

endmodule