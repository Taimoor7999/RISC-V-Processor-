module Data_Memory(clk, A, WD, WE, RD, rst);

input clk, WE, rst;
input [31:0] A, WD;
output [31:0]RD;

reg [31:0] DATA_MEM [1023:0];

always @ (posedge clk)
begin
  if (WE == 1'b1)
    begin

    DATA_MEM[A] <= WD;

  end

end

assign RD = (rst == 1'b1) ? DATA_MEM[A] : 32'd0;

// initial begin
//   DATA_MEM[28] = 32'h00000020;
//   DATA_MEM[40] = 32'h00000002;
// end

initial begin
  DATA_MEM[0] = 32'h00000000;
  //mem[40] = 32'h00000002;
end

endmodule