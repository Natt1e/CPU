`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:21 11/18/2021 
// Design Name: 
// Module Name:    DM 
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

module DM(
    input clk,
    input  HardwareInt,
    input [31:0] M_nextpc,
    input M_overflow,
	 input [4:0] M_ExcCode,
    input [31:0] M_pc,
    input [3:0]  M_MemWrite,
	 input [31:0] M_RD2,
    input [31:0] M_Aluout,
	 input [1:0] DM_rt_trans,
	 input [31:0] W_DMout,
	 input [31:0] G_out,
	 input [31:0] rdata,
	 input [2:0] DMControl,
	 output [31:0] m_data_addr,
	 output [31:0] m_data_wdata,
	 output reg [3:0] byteen,
	 output [31:0] m_inst_addr,
	 output reg [31:0] DMout,
	 output [31:0] M_newRD2,
	 output reg [4:0]finalExcCode
    );
reg HardwareIntReg;	 
wire legal; 
wire [31:0] rt;
wire [31:0] addr;
assign      rt=(DM_rt_trans==2'b10) ? G_out  :              
               (DM_rt_trans==2'b01) ? W_DMout:
                M_RD2;
assign addr=M_Aluout;
assign m_data_addr=(HardwareIntReg==1) ? 32'h7f20 :
                   M_Aluout;					 
assign m_inst_addr=M_pc;
assign m_data_wdata=(M_MemWrite==4'b1) ? {rt[7:0],rt[7:0],rt[7:0],rt[7:0]} :
                    (M_MemWrite==4'd2) ? {rt[15:0],rt[15:0]} :
                    (M_MemWrite==4'd4) ? rt :
                     0;							
assign M_newRD2=rt; 
assign legal=((addr>=32'h0&&addr<=32'h2fff)||(addr>=32'h7f00&&addr<=32'h7f0b)||(addr>=32'h7f10&&addr<=32'h7f1b)) ?
              1 : 0;
      always @(posedge clk) begin
          HardwareIntReg<=HardwareInt;
      end		
	
      always @(*) begin
         if(M_pc[1:0]!=2'b0 || M_pc<32'h3000 || M_pc>32'h6fff) 
			    finalExcCode=5'd4;
         else if(M_ExcCode==5'd10)
             finalExcCode=5'd10;
         else if(M_ExcCode==5'd1) begin//l
			    if(M_overflow==1) begin
				   finalExcCode=5'd4;
				 end	 
				 else if(legal==0)  begin
			     finalExcCode=5'd4;			     
				 end	  
				 else if(DMControl<3'd4 && addr>32'h2fff) begin
				   finalExcCode=5'd4;					 
				 end	 
				 else if(DMControl==3'd4&&addr[1:0]!=2'b0) begin
				   finalExcCode=5'd4;
				 end	 
				 else if((DMControl==3'd2||DMControl==3'd3)&&addr[0]!=0) begin
				   finalExcCode=5'd4;
				 end
             else
               finalExcCode=0;				 
         end
			else if(M_ExcCode==5'd2) begin//s
			   if(M_overflow==1)
			     finalExcCode=5'd5;
				else if(addr>=32'h7f08&&addr<=32'h7f0b)
				  finalExcCode=5'd5;
				else if(addr>=32'h7f18&&addr<=32'h7f1b)
				  finalExcCode=5'd5;  
				else if(legal==0) 
			     finalExcCode=5'd5; 
				else if(M_MemWrite<=4'd2 && addr>32'h2fff)
				   finalExcCode=5'd5;  
            else if(M_MemWrite==3'd4&&addr[1:0]!=2'b0)
			     finalExcCode=5'd5;				
			   else if(M_MemWrite==3'd2&&addr[0]!=0)
				   finalExcCode=5'd5;
				else
               finalExcCode=0;				
			end
			else if(M_overflow==1)
			    finalExcCode=5'd12;
			else
			   finalExcCode=5'd0;
      end  		


						  
      always @(*) begin			
		  if(M_MemWrite==4'd1) begin
			  byteen=(addr[1:0]==2'b00) ? 4'b0001 :
				              (addr[1:0]==2'b01) ? 4'b0010 :
								  (addr[1:0]==2'b10) ? 4'b0100 :
                          (addr[1:0]==2'b11) ? 4'b1000 :
                           0;								  
			   
			end
			else if(M_MemWrite==4'd2) begin
			   byteen=(addr[1]==0) ? 4'b0011 :
				              (addr[1]==1) ? 4'b1100 :
                           0;						
			
			end
			else if(M_MemWrite==4'd4) begin
			   byteen=4'b1111;
			end
			else begin
			   byteen=4'b0;
			end

     end	
 
				
     always @(*) begin
        if(DMControl==3'd0) begin //lb
         DMout=(addr[1:0]==2'b00) ? (rdata[7]==0)  ? {24'b0,rdata[7:0]} 
                                                          : {24'hffffff,rdata[7:0]}  :
					(addr[1:0]==2'b01) ? (rdata[15]==0) ? {24'b0,rdata[15:8]} 
                                                          : {24'hffffff, rdata[15:8]}  :
					(addr[1:0]==2'b10) ? (rdata[23]==0) ? {24'b0,rdata[23:16]} 
                                                          : {24'hffffff, rdata[23:16]}  :
               (addr[1:0]==2'b11) ? (rdata[31]==0) ? {24'b0,rdata[31:24]} 
                                                          : {24'hffffff,rdata[31:24]}  :
                0;																		  
																	
																																					
        end		  
        else if(DMControl==3'd1) //lbu
		    DMout=(addr[1:0]==2'b00) ? {24'b0,rdata[7:0]}   :                                                      
					 (addr[1:0]==2'b01) ? {24'b0,rdata[15:8]}  :                                                          
					 (addr[1:0]==2'b10) ? {24'b0,rdata[23:16]} :                                                         
                (addr[1:0]==2'b11) ? {24'b0,rdata[31:24]} :                                                         
                0;								
        else if(DMControl==3'd2)	 begin//lh	  
          DMout=(addr[1]==0) ? (rdata[15]==0) ? {16'b0,rdata[15:0]} 
                                                     : {16'hffff,rdata[15:0]}  :
					 (addr[1]==1) ? (rdata[31]==0) ? {16'b0,rdata[31:16]} 
                                                     : {16'hffff,rdata[31:16]}  : 
																	  0;
        end
		  else if(DMControl==3'd3) //lhu
		    DMout=(addr[1]==0) ? {16'b0,rdata[15:0]}  :                                                    
					 (addr[1]==1) ? {16'b0,rdata[31:16]} :                                                   
																	  0;
		  else if(DMControl==3'd4) //lw
		   DMout=rdata; 
                                        
    end	  


endmodule
