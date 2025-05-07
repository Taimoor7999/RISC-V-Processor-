module Main_Decoder(op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUop);

    input [6:0]op;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc,ALUop;

    //assign RegWrite = (op == 7'b0000011 | op == 7'b0110011) ? 1'b1 : 1'b0 ;
    assign RegWrite = (op == 7'b0000011 | op == 7'b0110011 | op == 7'b0010011) ? 1'b1 : 1'b0;

    assign ImmSrc = (op == 7'b0100011) ? 2'b01 : 
                    (op == 7'b1100011) ? 2'b10 :    
                                         2'b00 ;

    //assign ALUSrc = (op == 7'b0000011 | op == 7'b0100011) ? 1'b1 : 1'b0 ;
    assign ALUSrc = (op == 7'b0000011 | op == 7'b0100011 | op == 7'b0010011) ? 1'b1 : 1'b0;

    assign MemWrite = (op == 7'b0100011) ? 1'b1 : 1'b0 ;
    
    assign ResultSrc = (op == 7'b0000011) ? 1'b1 : 1'b0 ;

    assign Branch = (op == 7'b1100011) ? 1'b1 : 1'b0 ;

    assign ALUop = (op == 7'b0110011) ? 2'b10 :
                   (op == 7'b1100011) ? 2'b01 :
                                        2'b00 ;

endmodule