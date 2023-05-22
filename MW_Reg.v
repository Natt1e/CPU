`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:33 11/30/2021 
// Design Name: 
// Module Name:    MW_Reg 
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
module MW_Reg(
    input M_mfc0,
    input IntReq,
    input [31:0] CP0out,
    input  reset,
    input  [1:0] M_T_new,
    input  clk,
    input  [31:0] M_DMout,
	 input  [31:0] M_Aluout,
	 input  [1:0] M_MemtoReg,
	 input  M_RegWrite,
	 input  [4:0]  M_A3,
	 input  [31:0] M_pc,  
	 output reg [1:0] W_MemtoReg,
	 output reg W_RegWrite,
	 output reg [31:0] W_DMout,
	 output reg [4:0] W_A3,
	 output reg [1:0] W_T_new,
	 output reg [1:0] W_RegDst,
	 output reg [31:0] W_pc
    );

   always @ (posedge clk or posedge reset) begin
		 if(reset==1||IntReq==1) begin
		 W_RegWrite<=0;
		 end
		
       else begin		
		  W_RegWrite<=M_RegWrite;
		  W_DMout<=(M_mfc0==1) ? CP0out:
		           (M_MemtoReg==2'b1) ? M_DMout:
		            M_Aluout;
		  W_A3<=M_A3;
		  W_pc<=M_pc;
		  W_MemtoReg<=M_MemtoReg;
		  if(M_T_new!=2'b0)
		     W_T_new<=M_T_new-2'b1;
		  else if(M_T_new==2'b0)
          W_T_new<=2'b0;		  
		
		end
	end

endmodule
