`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:40:32 11/29/2021 
// Design Name: 
// Module Name:    DE_Reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DE_Reg(
    input D_mfc0,
    input [31:0] D_nextpc,
    input EXLClr,
    input [31:0] D_pc,
    input IntReq,
    input [4:0] D_ExcCode,
    input D_BD,
	 input D_CP0Write,
	 input D_eret,
    input [3:0] Branch,
    input reset,
    input pasue,
    input clk,
	 input [1:0] T_new,
    input [31:0] D_code,
	 input [4:0] D_A3,
    input [1:0] MemtoReg,
    input [3:0] MemWrite,
    input [4:0] Alucontrol,
    input ALUSrc,
    input [1:0] RegDst,
    input RegWrite,
    input [31:0] RD1,
    input [31:0] RD2,
	 input [31:0] pc,
	 input [2:0]  start,
	 input [1:0] MD,
	 input [2:0] DMControl,
    output reg [31:0] E_p1,
    output reg [31:0] E_p2,
    output reg [1:0] E_MemtoReg,
    output reg [3:0] E_MemWrite,
    output reg E_RegWrite,
	 output reg [4:0] E_Alucontrol,
	 output reg [4:0] E_rs,
	 output reg [4:0] E_rt,    
	 output reg [4:0] E_A3,
	 output reg E_ALUSrc,
	 output reg [1:0] E_T_new,
	 output reg [31:0] E_pc,
	 output reg [1:0] E_RegDst,
	 output reg [2:0] E_start,
	 output reg [1:0] E_MD,
	 output reg [2:0] E_DMControl,
	 output reg [31:0] E_code,
	 output reg [3:0] E_Branch,
	 output reg E_BD,
	 output reg E_CP0Write,
    output reg E_eret,
    output reg [4:0] E_ExcCode,
	 output reg [31:0] E_nextpc,
	 output reg E_mfc0
    );

 always @(posedge clk or posedge reset) begin
   if(reset==1) begin
	 E_MemWrite<=0;
	 E_RegWrite<=0;
	 E_start<=3'b0;
	 E_MD<=2'b0;
	 E_Branch<=0;
	 E_CP0Write<=0;
	 E_eret<=0;
	 E_pc<=32'h3000;
	end
	else if(pasue==1||IntReq==1||EXLClr==1) begin
	   E_MemWrite<=0;
	   E_RegWrite<=0;
		E_start<=3'b0;
	   E_MD<=2'b0;
		E_CP0Write<=0;
		E_pc<=(EXLClr==1) ? 32'h3000 :
		      (IntReq==1) ? 32'h4180 :
				 D_pc;	   
		E_ExcCode<=0;	
		E_BD<=(pasue==1) ? D_BD :
		       0;
			 
	end
   else begin 
	E_p1<=RD1;    
	E_p2<=RD2;
	E_MemtoReg<=MemtoReg;
   E_MemWrite<=MemWrite;
   E_RegWrite<=RegWrite;
	E_Alucontrol<=Alucontrol;
	E_rs<=D_code[25:21];
	E_rt<=D_code[20:16];
	E_ALUSrc<=ALUSrc;
	E_T_new<=T_new; 
   E_pc<=pc;	
	E_RegDst<=RegDst;
	E_A3<=D_A3;
	E_DMControl<=DMControl;
	E_code<=D_code;
   E_start<=start;
	E_MD<=MD;
	E_Branch<=Branch;
	E_BD<=D_BD;
	E_CP0Write<=D_CP0Write;
	E_eret<=D_eret;
	E_ExcCode<=D_ExcCode;
	E_nextpc<=D_nextpc;
	E_mfc0<=D_mfc0;
	end	
	 
    
 end


endmodule
