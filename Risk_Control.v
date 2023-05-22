`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:30:19 11/30/2021 
// Design Name: 
// Module Name:    Risk_Control 
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
module Risk_Control(
    input [1:0] E_T_new,
    input [1:0] M_T_new,
    input [1:0] W_T_new,
    input [1:0] T_Alu_rs_use,
    input [1:0] T_Alu_rt_use,
    input [1:0] T_DM_rt_use,
    input [4:0] M_A3, 
	 input [4:0] W_A3,
	 input [4:0] E_A3,
	 input [4:0] G_A3,
	 input  E_RegWrite,
    input M_RegWrite,
    input W_RegWrite,
	 input G_RegWrite,
    input [3:0] Branch,
	 input [31:0] D_code,
	 input [4:0] Alu_rs,
	 input [4:0] Alu_rt,
	 input [4:0] DM_rt,
	 input MDuse,
	 input [2:0] start,
	 input busy,
	 
	 output [1:0] zero_rs_trans,
    output [1:0] zero_rt_trans,	 
    output [1:0] Alu_rs_trans,
    output [1:0] Alu_rt_trans,
    output [1:0] DM_rt_trans,
	 output reg pasue
    );
wire [4:0] zero_rs;
wire [4:0] zero_rt; 
wire [4:0] D_Alu_rs;
wire [4:0] D_Alu_rt;


assign zero_rs=D_code[25:21];
assign zero_rt=D_code[20:16];
assign D_Alu_rs=D_code[25:21];
assign D_Alu_rt=D_code[20:16];

assign zero_rs_trans= (zero_rs==M_A3 && M_RegWrite==1 && M_A3!=0) ? 2'b1  :
                      (zero_rs==W_A3 && W_RegWrite==1 && W_A3!=0) ? 2'b10 :
							 2'b0;
assign zero_rt_trans= (zero_rt==M_A3 && M_RegWrite==1 && M_A3!=0) ? 2'b1  :
                      (zero_rt==W_A3 && W_RegWrite==1 && W_A3!=0) ? 2'b10 :
							 2'b0;
assign Alu_rs_trans=  (Alu_rs==M_A3 && M_RegWrite==1 && M_A3!=0) ? 2'b1 :
                      (Alu_rs==W_A3 && W_RegWrite==1 && W_A3!=0) ? 2'b10 :
							 2'b0;
assign Alu_rt_trans=  (Alu_rt==M_A3 && M_RegWrite==1 && M_A3!=0) ? 2'b1 :
                      (Alu_rt==W_A3 && W_RegWrite==1 && W_A3!=0) ? 2'b10 :
							 2'b0;							
assign DM_rt_trans=   (DM_rt==W_A3 && W_RegWrite==1 && W_A3!=0) ? 2'b1 :
                      (DM_rt==G_A3 && G_RegWrite==1 && G_A3!=0) ? 2'b10:
							 0;						
     
   always @(*) begin	  
      pasue=  (MDuse==1&&(busy==1||start==3'd1||start==3'd2||start==3'd3||start==3'd4)) ? 1 :
		        (zero_rs_trans==2'b01 && M_T_new>0 && (Branch>=4'd1 && Branch<=4'd8) ) ? 1 :
              (zero_rs_trans==2'b10 && W_T_new>0 && (Branch>=4'd1 && Branch<=4'd8) ) ?	1 :
				  (zero_rt_trans==2'b01 && M_T_new>0 && (Branch==4'd1 || Branch==4'd6) ) ? 1 :
              (zero_rt_trans==2'b10 && W_T_new>0 && (Branch==4'd1 || Branch==4'd6) ) ?	1 :
				  (zero_rs===E_A3 && E_RegWrite===1 && E_T_new>0 && (Branch>=4'd1 && Branch<=4'd8))         ?  1 :
				  (zero_rt===E_A3 && E_RegWrite===1 && E_T_new>0 && (Branch==4'd1 || Branch==4'd6))         ?  1 :
			     (D_Alu_rs==E_A3 && E_RegWrite==1 && E_T_new>T_Alu_rs_use) ? 1 :
				  (D_Alu_rt==E_A3 && E_RegWrite==1 && E_T_new>T_Alu_rt_use) ? 1 :
				   0;
				  
   	end			  
							
              
endmodule
