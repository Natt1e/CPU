`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:26:25 12/13/2021 
// Design Name: 
// Module Name:    Controller 
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
   module Controller(
	 input [3:0] E_Branch,
    input [31:0] D_code,
	 output reg [1:0] MemtoReg,
    output reg [3:0] MemWrite,
    output reg [3:0] Branch,
    output reg [4:0] AluControl,
    output reg AluSrc,
    output reg [1:0] RegDst,
	 output reg [4:0] D_W3,
    output reg RegWrite,
	 output reg [1:0] T_Alu_rs_use,
	 output reg [1:0] T_Alu_rt_use,
	 output reg [1:0] T_DM_rt_use,
	 output reg [1:0] T_new,
	 output reg [2:0] start,
	 output reg [1:0] MD,
	 output reg [2:0] DMControl,
	 output MDuse,
	 output D_CP0Write,
	 output D_eret,
	 output D_BD,
	 output reg [4:0] D_ExcCode,
	 output D_mfc0
    );
wire R;
wire I;
wire B;
wire L;
wire S;
wire [5:0] opcode;
wire [5:0] func;

assign opcode=D_code[31:26];
assign func=D_code[5:0];

assign R=(opcode==6'b0) ? 1 : 0;
assign I=(opcode==6'b001100 || opcode==6'b001001 || opcode==6'b001111 || opcode==6'b001101 ||
          opcode==6'b001010 || opcode==6'b001011 || opcode==6'b001110 || opcode==6'b001000) ? 1 : 0;
assign B=(opcode==6'b000100 || opcode==6'b000111 || opcode==6'b000110 || opcode==6'b000001 ||
          opcode==6'b000101) ? 1 : 0;			 
assign L=(opcode==6'b100000 || opcode==6'b100100 || opcode==6'b100001 || opcode==6'b100101 ||
          opcode==6'b100011) ? 1 : 0;				 
assign S=(opcode==6'b101000 || opcode==6'b101001 || opcode==6'b101011) ? 1 : 0;
assign MDuse=(R==0) ?  0  :
(func==6'b011000||func==6'b011001||func==6'b011010||
 func==6'b011011||func==6'b010000||func==6'b010010||
 func==6'b010001||func==6'b010011) ? 1 : 0;
assign D_CP0Write=(opcode==6'b010000&&D_code[25:21]==5'b00100) ? 1 : 0;
assign D_eret=(opcode==6'b010000&&func==6'b011000) ? 1 : 0; 
assign D_BD=|E_Branch;
 
    always @(*) begin
         if(R==1) begin
			   D_ExcCode=5'b0;
			   RegWrite=1;
            MemWrite=4'b0;	
				start=3'b0;
				MD=0;
            Branch=4'b0;
				RegDst=2'b1;
				D_W3=D_code[15:11];
				T_Alu_rt_use=2'b1;
				T_Alu_rs_use=2'b1;
				T_DM_rt_use=2'b11;
				T_new=2'b1;
				MemtoReg=0;
				AluSrc=0;
				AluControl=5'd0; 
				   if(D_code==32'b0)         begin
                   RegWrite=0;      // nop
						 MemWrite=0;
						 start=3'b0;
						 MD=0;
               end					
               else if(func==6'b000000) begin
					    T_Alu_rs_use=2'b11;
						 AluControl=5'h3; // sll
					end
					else if(func==6'b000010) begin
					   T_Alu_rs_use=2'b11;
						AluControl=5'd4; // srl
					end
					else if(func==6'b000011) begin
					   T_Alu_rs_use=2'b11;
						AluControl=5'd5; // sra
					end
					else if(func==6'b100000) begin
					   AluControl=5'd16;// add
					end
           		else if(func==6'b100001) begin
					   AluControl=5'b1;// addu
               end					
			      else if(func==6'b100011) begin
					   AluControl=5'd2; // subu						
					end
					else if(func==6'b100010) begin
					   AluControl=5'd17; // sub 					
					end
					else if(func==6'b011000) begin					  
					  RegWrite=0; // mult
					  start=3'b1;
					end
					else if(func==6'b011001) begin
					  RegWrite=0;  //multu
					  start=3'd2;
					end
					else if(func==6'b011010) begin
					  RegWrite=0; //div
					  start=3'd3;
					end
					else if(func==6'b011011) begin
					  RegWrite=0;//divu 
					  start=3'd4;
					end
					else if(func==6'b010000) begin
					  MemtoReg=2'b10;// mfhi
					  T_Alu_rt_use=2'b11;
				     T_Alu_rs_use=2'b11;
					end
					else if(func==6'b010010) begin
					  MemtoReg=2'b11; //mflo
					  T_Alu_rt_use=2'b11;
				     T_Alu_rs_use=2'b11;  
					end
					else if(func==6'b010001) begin
					  RegWrite=0; //mthi
					  T_Alu_rt_use=2'b11;
					  MD=2'b1;
					end
					else if(func==6'b010011) begin
					  RegWrite=0; //mtlo
					  T_Alu_rt_use=2'b11;
					  MD=2'b11;
					end
					else if(func==6'b000100) begin
					  AluControl=5'd6;//sllv
					end
					else if(func==6'b000110) begin
					  AluControl=5'd7; // srlv
					end
					else if(func==6'b000111) begin
					  AluControl=5'd8; //srav
					end
					else if(func==6'b100100) begin
					  AluControl=5'd9; //and
					end 
					else if(func==6'b100101) begin
					  AluControl=5'd10; // or 
					end 
					else if(func==6'b100110) begin
					  AluControl=5'd11;//xor
					end
					else if(func==6'b100111) begin
					  AluControl=5'd12; //nor
					end
					else if(func==6'b101010) begin
					  AluControl=5'd13;//slt
					end
					else if(func==6'b101011) begin
					  AluControl=5'd14;  //sltu
					end
					else if(func==6'b001001) begin
					   Branch=4'd7;   //  jalr
						RegDst=2'b10;
						T_Alu_rt_use=2'b11;
				      T_Alu_rs_use=2'b11;
					end
					else if(func==6'b001000) begin
					  Branch=4'd8; // jr
                 RegWrite=0;
                 T_Alu_rt_use=2'b11;
				     T_Alu_rs_use=2'b11;
 					  T_new=0;
					end
					else
					 D_ExcCode=5'd10;
					
			end
			
			else if(opcode==6'b000010) begin
			  RegWrite=0;       //j
           MemWrite=0;
           start=3'b0;
           MD=0;
           T_Alu_rt_use=2'b11;
			  T_Alu_rs_use=2'b11;
			  T_DM_rt_use=2'b11;		
           Branch=4'd9;		
           D_ExcCode=5'b0;	
        	  AluControl=5'd0;            			  			 			  
			end
         
         else if(opcode==6'b000011) begin
           RegWrite=1;       //jal
           MemWrite=0;
           start=3'b0;
           MD=0;
			  MemtoReg=0;
			  RegDst=2'b10;
			  D_W3=5'd31;
           T_Alu_rt_use=2'b11;
			  T_Alu_rs_use=2'b11;
			  T_DM_rt_use=2'b11;
           T_new=1;			  
           Branch=4'd10;
           D_ExcCode=5'b0;
           AluControl=5'd0;   			  
         end
			
         else if(I==1) begin
            RegWrite=1;
            MemWrite=4'b0;	
				start=3'b0;
				MD=0;
            Branch=4'b0;
				RegDst=2'b0;
				D_W3=D_code[20:16];			
				T_Alu_rt_use=2'b11;
				T_Alu_rs_use=2'b1;
				T_DM_rt_use=2'b11;
				T_new=2'b1;
				MemtoReg=0;
				AluSrc=1;
				D_ExcCode=5'b0;
				AluControl=5'd0; 
				    if(opcode==6'b001001) begin
					     AluControl=5'b1;  // addiu
					 end
					 else if(opcode==6'b001000) begin
					    AluControl=5'd16;  // addi
					 end
					 else if(opcode==6'b001111)  begin
					    AluControl=5'd15;   //lui
					 end
				    else if(opcode==6'b001101) begin
					    AluControl=5'd10; // ori
					 end
					 else if(opcode==6'b001010) begin
					    AluControl=5'd13;    //slti
					 end
					 else if(opcode==6'b001011) begin
					    AluControl=5'd14;      //sltiu
					 end
					 else if(opcode==6'b001110) begin
					    AluControl=5'd11;     //xori
					 end
					 else if(opcode==6'b001100) begin
					  AluControl=5'd9; //andi
					 end
					 else
					  D_ExcCode=5'd10;
						  
         end
  
         else if(B==1) begin
            RegWrite=0;
            MemWrite=4'b0;	
				start=3'b0;
				MD=0;
				RegDst=2'b0;
				D_W3=D_code[20:16];
				T_Alu_rt_use=2'b11;
				T_Alu_rs_use=2'b1;
				T_DM_rt_use=2'b11;
				T_new=2'b0;
				MemtoReg=0;
				AluSrc=1; 
				D_ExcCode=5'd0;
			   AluControl=5'd0; 
                if(opcode==6'b000100) begin
                   Branch=4'd1; //beq  equal
                end
                else if(opcode==6'b000001) begin
                        if(D_code[20:16]==5'b00001) begin
                           Branch=4'd2; // rs>=0 bgez ;
								end	
                        else if(D_code[20:16]==5'b00000) begin
                           Branch=4'd5; // rs<0 bltz
								end   
                        else
								   D_ExcCode=5'd10;			
                end
                else if(opcode==6'b000111) begin
                   Branch=4'd3;  //  rs>0   bgtz  
                end
                else if(opcode==6'b000110) begin
                   Branch=4'd4;  //  rs<=0    blez
                end
                else if(opcode==6'b000101) begin
                   Branch=4'd6;    // bne not equal
					 end 
                else
                D_ExcCode=5'd10;					 
         end

         else if(L==1) begin
            RegWrite=1;
            MemWrite=4'b0;	
				start=3'b0;
				MD=0;
				Branch=4'b0;
				AluControl=5'd16;
				RegDst=2'b0;
				D_W3=D_code[20:16];
				T_Alu_rt_use=2'b11;
				T_Alu_rs_use=2'b1;
				T_DM_rt_use=2'b11;
				T_new=2'd2;
				MemtoReg=1;
				AluSrc=1; 
				D_ExcCode=5'd1;
				    if(opcode==6'b100000) 
					    DMControl=3'd0; // lb
					 else if(opcode==6'b100100)
					    DMControl=3'd1; //lbu
					 else if(opcode==6'b100001)
                   DMControl=3'd2; //lh
                else if(opcode==6'b100101)
                   DMControl=3'd3; //lhu
                else if(opcode==6'b100011)
                   DMControl=3'd4; //lw	
                else
                   D_ExcCode=5'd10;					 
         end

         else if(S==1) begin
            RegWrite=0;	
				start=3'b0;
				MD=0;
				Branch=4'b0;
				AluControl=5'd16;
				RegDst=2'b0;
				D_W3=D_code[20:16];
				T_Alu_rt_use=2'b11;
				T_Alu_rs_use=2'b1;
				T_DM_rt_use=2'b10;
				T_new=2'd0;
				MemtoReg=1;
				AluSrc=1;
				D_ExcCode=5'd2;
               if(opcode==6'b101000) 		
                  MemWrite=4'b1;
               else if(opcode==6'b101001)
                  MemWrite=4'd2;
					else if(opcode==6'b101011)
                  MemWrite=4'd4;	
               else
              		D_ExcCode=5'd10;			
         end 

        else if(opcode==6'b010000) begin
		   	start=3'b0;
				AluControl=5'd0; 
				MD=0;
			 if(D_code[25:21]==5'b00000) begin // mfc0	          	
				RegWrite=1;
            MemWrite=4'b0;	
				start=3'b0;
				MD=0;
            Branch=4'b0;
				D_W3=D_code[20:16];
				T_Alu_rt_use=2'b11;
				T_Alu_rs_use=2'b11;
				T_DM_rt_use=2'b11;
				T_new=2'd2;	
            D_ExcCode=5'b0;				
	     end
		  else if(D_code[25:21]==5'b00100) begin //mtc0
            D_W3=D_code[15:11];
				RegWrite=0;
            MemWrite=4'b0;	
				start=3'b0;
				MD=0;
            Branch=4'b0;
				RegDst=2'b0;
				T_Alu_rt_use=2'b11;
				T_Alu_rs_use=2'b11;
				T_DM_rt_use=2'b10;
				T_new=2'd0;
				MemtoReg=1;	
				D_ExcCode=5'b0;
		  end
		  else if(func!=6'b011000) 
            D_ExcCode=5'd10;
		 end
       else begin
		      MD=0;
				start=3'b0;
          	D_ExcCode=5'd10;	
       end				
		  
   end
assign D_mfc0=(opcode==6'b010000&&D_code[25:21]==5'b00000) ? 1 : 0;

endmodule
