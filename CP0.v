`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:58:20 12/23/2021 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input [31:0] M_code,
    input clk,
	 input reset,
	 input [31:0] In,
	 input [31:0] PC,
	 input [6:2] ExcCode,
	 input [5:0] HWInt, //6 outside
	 input CP0Write,
	 input EXLClr,
	 input BD,
	 output IntReq,
	 output reg [31:0] EPC,
	 output [31:0] out,
	 output HardwareInt
    );
wire ExceptionInt;	 
wire [5:0] read;
reg [31:0] SR;
reg [31:0] Cause;
reg [31:0] PR;
wire [4:0] A1;
assign A1=M_code[15:11];
assign out=(A1==5'd12) ? SR :
           (A1==5'd13) ? Cause:
			  (A1==5'd14) ? EPC:
			  (A1==5'd15) ? PR:
			   32'b0;
assign HardwareInt=(|(HWInt&SR[15:10]))&SR[0]&(~SR[1]);
assign read=HWInt&SR[15:10];
assign ExceptionInt=|ExcCode&(~SR[1]);		
assign IntReq=HardwareInt | ExceptionInt;		
    always @(posedge clk) begin
	    if(reset==1) begin
		   SR<=32'h0;
  			Cause<=32'b0;
		   EPC<=32'b0;
			PR<=32'b0;
		 end
		 else  begin
		     if(EXLClr==1) begin
			     SR[1]<=0; 
			  end
			   else if(IntReq==1) begin
			     SR[1]<=1;
				  if(HardwareInt==1)
			     Cause[6:2]<=5'b0;
				  else
				  Cause[6:2]<=ExcCode;
			     Cause[31]<=BD;
			     EPC<=(BD==1) ? PC-32'h4 : PC;
			  end
			  else if(CP0Write==1) begin
			     if(A1==5'd12)
			        SR<={16'b0,In[15:10],8'b0,In[1],In[0]};
              else if(A1==5'd13)
           	     Cause<=In;
              else if(A1==5'd14)
                  EPC<=In;
              else if(A1==5'd15)
				     PR<=In;              				
			  end
			
          Cause[15:10]<=HWInt;			
		 end
	  
	 end

endmodule
