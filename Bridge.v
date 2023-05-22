`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:30 12/25/2021 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
    input clk,
    input HardwareInt,
    input IntReq,
	 input [31:0] M_Aluout,
	 input [31:0] Dout0,
	 input [31:0] Dout1,
	 input [31:0] m_data_rdata,
	 input [3:0] byteen,
	 output [3:0] m_data_byteen,
	 output TCWE0,
	 output TCWE1,
	 output [31:0] data
    );
reg HardwareIntReg;
    always @(posedge clk) begin
	   HardwareIntReg<=HardwareInt;
	 end
assign data=(M_Aluout>=32'h0000&&M_Aluout<=32'h2fff) ? m_data_rdata :
            (M_Aluout>=32'h7f00&&M_Aluout<=32'h7f0b) ? Dout0        :    
            (M_Aluout>=32'h7f10&&M_Aluout<=32'h7f1b) ? Dout1        : 
             0;

assign m_data_byteen=(HardwareIntReg==1) ? 4'b1 :
                     (IntReq==1) ? 4'b0:
                     (M_Aluout>=32'h0000&&M_Aluout<=32'h2fff) ? byteen:
                     4'b0;

assign TCWE0=(IntReq==1) ? 0:
              (byteen!=4'b0&&(M_Aluout>=32'h7f00&&M_Aluout<=32'h7f0b)) ? 1 :
              0;


assign TCWE1=(IntReq==1)? 0:
             (byteen!=4'b0&&(M_Aluout>=32'h7f10&&M_Aluout<=32'h7f1b)) ? 1 :
              0;

endmodule
