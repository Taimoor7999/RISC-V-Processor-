module Sign_Extend(In, Imm_Ext,ImmSrc);

input [31:0] In;
input [1:0] ImmSrc;
output [31:0] Imm_Ext;

// assign Imm_Ext = (ImmSrc == 1'b0 ) ? ((In[31] == 1'b1) ? {{20{1'b1}}, In [31:20]} : 
//                                      {{20{1'b0}}, In [31:20]}) :
//                                      (((In[31] == 1'b1) ? {{20{1'b1}}, In [31:25], In[11:7]}) : 
//                                      ({{20{1'b0}}, In [31:25], In[11:7]}));

assign Imm_Ext = (ImmSrc == 1'b0 ) ? 
                                     ((In[31] == 1'b1) ? {{20{1'b1}}, In[31:20]} : 
                                     {{20{1'b0}}, In[31:20]}) :
                                     ((In[31] == 1'b1) ? {{20{1'b1}}, In[31:25], In[11:7]} : 
                                     {{20{1'b0}}, In[31:25], In[11:7]});

endmodule

