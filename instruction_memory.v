module instruction_memory(A,RD,rst);

input [31:0] A;
output [31:0] RD;
input rst;

reg [31:0] mem [1023:0]; // mem has 1024 registers and every register is of 32 bits binary 

assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];

initial begin

    $readmemh("memfile.hex",mem);

end

// initial begin 
//     // mem[0] = 32'hFFC4A303;
//     // mem[1] = 32'h00832383;
//     // mem[2] = 32'h0064A423;
//     // mem[1] = 32'h00B62423;
//     mem[0] = 32'h0062E233;

// end

endmodule
