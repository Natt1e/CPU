`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:17:46 12/03/2021 
// Design Name: 
// Module Name:    IFD_Reg 
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
module IFD_Reg(
    input EXLClr,
    input IntReq,
    input reset,
    input [31:0] new_code,
	 input clk,
	 input [31:0] pc,
	 input pasue,
    output reg [31:0] D_code,
	 output reg [31:0] D_pc
    );
   always @ (posedge clk) begin
	if(reset==1||IntReq==1||EXLClr==1) begin
	     D_code<=0;
		  D_pc<=(EXLClr==1) ? 32'h3000 :
		        (IntReq==1) ? 32'h4180 :
				   32'h3000;
	end
	else if(pasue==1)
	  D_code<=D_code;
	else begin
	   D_code<=new_code;
	   D_pc<=pc;
	end
	end

endmodule
