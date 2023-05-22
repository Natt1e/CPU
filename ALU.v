`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:58:51 11/18/2021 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [4:0] AluControl,
    input [31:0] RD1,
    input [31:0] RD2,
	 input [31:0] E_code,
	 input E_ALUSrc,
	 input [31:0] M_Aluout,
    input [31:0] W_DMout,
    input [1:0] Alu_rs_trans,
    input [1:0] Alu_rt_trans, 
	 input [31:0] E_pc,
    output [31:0] Aluout,
	 output [31:0] p1,
	 output [31:0] p2,
	 output overflow
    );
	 

wire [31:0] imm;
wire [4:0] s;
wire [32:0] temp;
assign s=E_code[10:6];
assign imm=(E_code[15]==1) ? {16'hffff,E_code[15:0]} : {16'b0,E_code[15:0]};
	 
assign p1= (Alu_rs_trans===2'b1)  ?  M_Aluout :
           (Alu_rs_trans===2'b10) ?  W_DMout  :
			   RD1;
assign p2= (E_ALUSrc==1)         ?    imm    :         
           (Alu_rt_trans===2'b1)  ?  M_Aluout :
           (Alu_rt_trans===2'b10) ?  W_DMout  :
			   RD2;
					
	 
  assign Aluout= 
                 (AluControl==5'd1) ? p1+p2 : // addu  or addiu
                 (AluControl==5'd2) ? p1-p2 : //subu
                 (AluControl==5'd3) ? p2<<s : //sll
                 (AluControl==5'd4) ? p2>>s : //srl
					  (AluControl==5'd5) ? $signed($signed(p2)>>>s): //sra
					  (AluControl==5'd6) ? p2<<p1[4:0] : //sllv
					  (AluControl==5'd7) ? p2>>p1[4:0] : //srlv
					  (AluControl==5'd8) ? $signed($signed(p2)>>>p1[4:0]): //srav
					  (AluControl==5'd9) ? (E_ALUSrc==1) ?  p1&{16'b0,E_code[15:0]} : //andi
					                       p1&p2 : //and
					  (AluControl==5'd10)? (E_ALUSrc==1) ?  p1|{16'b0,E_code[15:0]} : //ori
					                       p1|p2 : //or
					  (AluControl==5'd11)? (E_ALUSrc==1) ?  p1^{16'b0,E_code[15:0]} : //xori
					                       p1^p2 : //xor
					  (AluControl==5'd12)? ~(p1|p2)://nor
					  (AluControl==5'd13)? ($signed(p1)<$signed(p2)) ? 32'b1 : 32'b0 : //slt
					  (AluControl==5'd14)? (p1<p2) ? 32'b1 : 32'b0 :  //sltu 
					  (AluControl==5'd15) ? {E_code[15:0],16'b0} : //lui	
                 (AluControl==5'd16) ? p1+p2 : // addu  or addiu
                 (AluControl==5'd17) ? p1-p2 : //subu     					  
                  0;					
assign temp=(AluControl==5'd16) ? {p1[31],p1[31:0]}+{p2[31],p2[31:0]} : 
            (AluControl==5'd17) ? {p1[31],p1[31:0]}-{p2[31],p2[31:0]} :
				 33'b0;
assign overflow=(AluControl==5'd16 || AluControl==5'd17) ?
                    (temp[32]==temp[31]) ? 0 : 1
					 : 0;	  
 

endmodule
