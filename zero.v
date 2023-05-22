`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:29 12/03/2021 
// Design Name: 
// Module Name:    zero 
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
module zero(
    input [31:0] RD1,
    input [31:0] RD2,
	 input [1:0] zero_rs_trans,
    input [1:0] zero_rt_trans,
	 input [31:0] M_Aluout, 
	 input [31:0] W_DMout,
	 output zero,
	 output equal,
	 output less,
	 output more
    );
wire [31:0] rs;
wire [31:0] rt;

assign rs=(zero_rs_trans==2'b1)  ? M_Aluout :
          (zero_rs_trans==2'b10) ? W_DMout :
			 RD1;


assign rt=(zero_rt_trans==2'b1)  ? M_Aluout :
          (zero_rt_trans==2'b10) ? W_DMout  : 
			 RD2;


assign zero=(rs==32'b0) ? 1 : 0;
assign equal=(rs==rt) ?   1 : 0;
assign less=(rs[31]==1) ? 1 : 0;
assign more=(rs!=32'b0&&rs[31]==0) ? 1 : 0;


endmodule
