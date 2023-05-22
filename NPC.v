`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:27:15 11/18/2021 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input EXLClr,
	 input [31:0] EPC,
    input IntReq,
    input clk,
    input reset,
	 input pasue,
    input [3:0] Branch,
	 input equal,
	 input less,
	 input zero,
	 input more,
	 input [31:0] RD1,
	 input [31:0] D_code,
	 inout [31:0] D_pc,
	 input [1:0] zero_rs_trans,
	 input [31:0] M_Aluout,
	 input [31:0] W_DMout,
	 output reg [31:0]  pc,
	 output reg [31:0] nextpc
    );


wire [31:0] offset;
wire [31:0] rs;

assign offset=(D_code[15]==1) ? {14'b1111_1111_1111_11,D_code[15:0],2'b00} : 
                                {14'b0,D_code[15:0],2'b00};
assign rs=    (zero_rs_trans==2'b1)  ? M_Aluout :
              (zero_rs_trans==2'b10) ? W_DMout  : 
			     RD1;				  

  always @(posedge clk) begin
   	 
      if(reset==1) begin
		  pc<=32'h3000;
		  end
      
		else begin
		   if(EXLClr==1)
			    pc<=EPC;
		   else if(IntReq==1)
				   pc<=32'h4180;
			else if(pasue===1)
               pc<=pc;			
			else begin 
				 if(Branch==4'd1 && equal==1) //beq
				   pc<=D_pc+32'h4+offset; 
				else if(Branch==4'd2 && (more==1 || zero==1)) //bgez
               pc<=D_pc+32'h4+offset;
            else if(Branch==4'd3 && more==1)  //bgtz
               pc<=D_pc+32'h4+offset;
            else if(Branch==4'd4 && (less==1 || zero==1))	//blez
               pc<=D_pc+32'h4+offset; 
            else if(Branch==4'd5 && less==1)  //bltz
               pc<=D_pc+32'h4+offset;
            else if(Branch==4'd6 && equal==0) //bne
               pc<=D_pc+32'h4+offset;  				
            else if(Branch==4'd7) //jalr
				   pc<=rs;
				else if(Branch==4'd8) //jr
               pc<=rs;  	
            else if(Branch==4'd9) //j
               pc<={D_pc[31:28],D_code[25:0],2'b0};
            else if(Branch==4'd10) //jal	
               pc<={D_pc[31:28],D_code[25:0],2'b0};				
			   else 
			      pc<=pc+32'd4;
			end   
           			 
		  end
 
  end



   always @(posedge clk) begin
				 if(Branch==4'd1 && equal==1) //beq
				   nextpc<=D_pc+32'h4+offset; 
				else if(Branch==4'd2 && (more==1 || zero==1)) //bgez
               nextpc<=D_pc+32'h4+offset;
            else if(Branch==4'd3 && more==1)  //bgtz
               nextpc<=D_pc+32'h4+offset;
            else if(Branch==4'd4 && (less==1 || zero==1))	//blez
               nextpc<=D_pc+32'h4+offset; 
            else if(Branch==4'd5 && less==1)  //bltz
               nextpc<=D_pc+32'h4+offset;
            else if(Branch==4'd6 && equal==0) //bne
               nextpc<=D_pc+32'h4+offset;  				
            else if(Branch==4'd7) //jalr
				   nextpc<=rs;
				else if(Branch==4'd8) //jr
               nextpc<=rs;  	
            else if(Branch==4'd9) //j
               nextpc<={D_pc[31:28],D_code[25:0],2'b0};
            else if(Branch==4'd10) //jal	
               nextpc<={D_pc[31:28],D_code[25:0],2'b0};				
			   else 
			      nextpc<=pc+32'd4;
			  
           			 
		  
 
  end
endmodule
