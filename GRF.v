`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:18 11/18/2021 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	 input clk,
    input W_RegWrite,
    input reset,
    input [31:0] D_code,
    input [31:0] W_DMout,
	 input [4:0] W_A3,
    output  [31:0] RD1,
    output  [31:0] RD2,
	 output reg [4:0] G_A3,
	 output reg G_RegWrite,
	 output reg [31:0] G_out
    );
 integer i;	 
 reg [31:0] grf[0:31];
 wire[31:0] data;
 wire [4:0] addr;  
 
 assign data=W_DMout;
 assign addr=W_A3;
 
 assign RD1=(W_RegWrite==1 && addr==D_code[25:21] && addr!=0) ? data : 
            grf[D_code[25:21]];	 
				
 assign RD2=(W_RegWrite==1 && addr==D_code[20:16] && addr!=0) ? data : 
            grf[D_code[20:16]];	
  
  always @(posedge clk) begin
    G_RegWrite<=W_RegWrite;
	 G_A3<=W_A3;
	 G_out<=data;
     
	   if(reset==1) begin
	     for(i=0;i<=31;i=i+1) begin
	       grf[i]<=0;  
	     end
     end
	  
     else begin
	    if(W_RegWrite==1) begin
		   if(addr!=0)
			      grf[addr]<=data;    				   				
	     end
     end	  
	  
 end 

endmodule
