module ALU_advance(A,B,ALUcontrol,Result,N,Z,C,V);

input [31:0] A,B;
output [31:0] Result;
input [2:0]  ALUcontrol;
output N,Z,C,V;

wire [31:0] A_or_B;
wire [31:0] A_and_B;
wire [31:0] not_B;
wire [31:0] sum;
wire [31:0] mux1;
wire [31:0] mux2;
wire [31:0] slt;
wire cout;

assign A_or_B = A | B;
assign A_and_B = A & B;
assign not_B = ~B;

// // If ALUcontrol[0] == 0, then mux1 = B else mux1 = not_B
assign mux1 = (ALUcontrol[0] == 1'b0 ) ? B : not_B; 

// If ALUcontrol[0] is 0 then it sum IF ALUcontrol[0] is 1 then it subtraction
assign {cout,sum} = A + mux1 + ALUcontrol[0]; 
assign slt = {31'b0000000000000000000000000000000,sum[31]};

assign mux2 = (ALUcontrol[2:0] == 3'b000) ? sum : 
              (ALUcontrol[2:0] == 3'b001) ? sum :
              (ALUcontrol[2:0] == 3'b010) ? A_and_B : 
              (ALUcontrol[2:0] == 3'b011) ? A_or_B :
              (ALUcontrol[2:0] == 3'b101) ? slt : 32'h00000000;
assign Result = mux2;

// assign {cout,sum} = (ALUcontrol[0] == 1'b0) ? A + B :
//                                           (A + ((~B)+1)) ;

assign N = Result[31];
assign Z = &(~Result);
assign C = cout & (~ALUcontrol[1]);
assign V = (~ALUcontrol[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALUcontrol[0]));

endmodule


// module ALU_advance(A,B,Result,ALUcontrol,V,C,Z,N);

//     input [31:0]A,B;
//     input [2:0]ALUcontrol;
//     output C,V,Z,N;
//     output [31:0]Result;

//     wire Cout;
//     wire [31:0]Sum;

//     assign {Cout,Sum} = (ALUcontrol[0] == 1'b0) ? A + B :
//                                           (A + ((~B)+1)) ;
//     assign Result = (ALUcontrol == 3'b000) ? Sum :
//                     (ALUcontrol == 3'b001) ? Sum :
//                     (ALUcontrol == 3'b010) ? A & B :
//                     (ALUcontrol == 3'b011) ? A | B :
//                     (ALUcontrol == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}};
    
//     assign V = ((Sum[31] ^ A[31]) & 
//                       (~(ALUcontrol[0] ^ B[31] ^ A[31])) &
//                       (~ALUcontrol[1]));
//     assign C = ((~ALUcontrol[1]) & Cout);
//     assign Z = &(~Result);
//     assign N = Result[31];

// endmodule
