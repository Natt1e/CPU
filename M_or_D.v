`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:58 12/16/2021 
// Design Name: 
// Module Name:    M_or_D 
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
module M_or_D(
    input M_eret,
    input clk,
    input [2:0] start,
	 input [31:0] p1,
	 input [31:0] p2,
	 input [1:0] MemtoReg,
	 input [1:0] MD,
	 output reg busy,
	 output [31:0] MDout
    );
wire [63:0] P1;
wire [63:0] P2;	 
reg [31:0] HI=0;
reg [31:0] LO=0;
reg [3:0] timer=4'b1111;	 
wire [63:0] mult_result;
wire [31:0] div_result;
wire [31:0] mod_result;
assign P1=(p1[31]==0) ?  {32'b0,p1[31:0]}  :
                         {32'hffff_ffff,p1[31:0]};
assign P2=(p2[31]==0) ?  {32'b0,p2[31:0]}  :
                         {32'hffff_ffff,p2[31:0]};								 

assign mult_result=(start==3'd1) ? $signed($signed(P1) * $signed(P2)) :
                   (start==3'd2) ?      {32'b0,P1[31:0]}*{32'b0,P2[31:0]} : 0;				  
assign div_result= (start==3'd3) ? $signed($signed(p1)/$signed(p2)) :
                   (start==3'd4) ?         p1/p2         : 0;
assign mod_result= (start==3'd3) ? $signed($signed(p1)%$signed(p2)) :
                   (start==3'd4) ?         p1%p2         : 0; 
assign MDout=(MemtoReg==2'b10) ? HI :   //mfhi
             (MemtoReg==2'b11) ? LO : 0;//mflo
   always @ (posedge clk) begin
	   if(MD==2'b1&&M_eret==0) 
		  HI<=p1; //mthi
		else if(MD==2'b11&&M_eret==0)
        LO<=p1; //mtlo		
	   if(timer===4'b0)
		     busy<=0;
	   if(start!=3'b0)  begin
		   busy<=1'b1;
		   timer<=(start==3'd1 || start==3'd2) ?  4'd4   :
			       (start==3'd3 || start==3'd4) ?  4'd9   : 4'b1111; 
			if(start==3'd1 || start==3'd2) begin
				if(M_eret==0) begin
				HI<=mult_result[63:32];
				LO<=mult_result[31:0];
				end
         end			
			else if(start==3'd3 || start==3'd4) begin
  			  if(M_eret==0) begin
			  HI<=mod_result;
			  LO<=div_result;
			  end
         end								 
	   end
		  
		
	   else if(timer!==4'b1111)
		   timer<=timer-4'b1;	
	end














endmodule
