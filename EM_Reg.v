`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:43:26 11/29/2021 
// Design Name: 
// Module Name:    EM_Reg 
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
module EM_Reg(
    input E_mfc0,
    input [31:0] E_nextpc,
    input EXLClr,
    input IntReq,
    input [31:0] E_code,
    input [4:0] E_ExcCode,
	 input overflow,
    input E_BD,
	 input E_CP0Write,
	 input E_eret,
    input reset,
	 input [1:0] E_T_new,
    input clk,
    input [31:0] E_Aluout,
	 input [31:0] RD2,
    input [1:0] E_MemtoReg,
    input [3:0] E_MemWrite,
    input [4:0] E_A3,
    input E_RegWrite,
	 input [4:0] E_rt,
	 input [31:0] E_pc,
	 input [1:0] E_RegDst,
	 input [31:0] MDout,   
	 input [2:0] E_DMControl,
	 output reg [31:0]  M_Aluout,
    output reg [1:0] M_MemtoReg,
	 output reg [3:0] M_MemWrite,
    output reg M_RegWrite,
	 output reg [4:0] M_A3,
	 output reg [31:0] M_RD2,
	 output reg [4:0] M_rt,
	 output reg [1:0] M_T_new,
	 output reg [31:0] M_pc,
	 output reg [1:0] M_RegDst,
	 output reg [2:0] M_DMControl,
	 output reg M_BD,
	 output reg M_CP0Write,
	 output reg M_eret,
	 output reg M_overflow,
	 output reg [4:0] M_ExcCode,
	 output reg [31:0] M_code,
	 output reg [31:0] M_nextpc,
	 output reg M_mfc0
    );

   always @(posedge clk or posedge reset) begin
	
	if(reset==1||IntReq==1||EXLClr==1) begin
	M_RegWrite<=0;
	M_MemWrite<=0;
	M_CP0Write<=0;
	M_ExcCode<=0;
	M_overflow<=0;
	M_eret<=0;
	M_pc<=(EXLClr==1) ? 32'h3000 :	 
	      (IntReq==1) ? 32'h4180 :
			 32'h3000;
	end
	
	else begin
	  M_mfc0<=E_mfc0;
	  M_nextpc<=E_nextpc;
	  M_code<=E_code;
	  M_ExcCode<=E_ExcCode;
	  M_overflow<=overflow;
	  M_BD<=E_BD;
	  M_CP0Write<=E_CP0Write;
	  M_eret<=E_eret;
	  M_Aluout<=(E_RegDst==2'b10) ? E_pc+32'h8 :
	            (E_MemtoReg==2'b10 || E_MemtoReg==2'b11) ? MDout:
					E_Aluout;
     M_MemtoReg<=E_MemtoReg;
	  M_MemWrite<=E_MemWrite;
	  M_RegWrite<=E_RegWrite;
	  M_A3<=E_A3;
	  M_RD2<=RD2;
	  M_rt<=E_rt;
	  M_pc<=E_pc;
	  M_RegDst<=E_RegDst;
	  M_DMControl<=E_DMControl;
	  if(E_T_new!=2'b0)
	  M_T_new<=E_T_new-2'b1;
	  else if(E_T_new==2'b0)
	  M_T_new<=2'b0;
	end
	
end
	
endmodule
