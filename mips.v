`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:41 12/18/2021 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset,
	 input interrupt,                 // 外部中断信号
    output [31:0] macroscopic_pc, // 宏观 PC
	 output [31:0] i_inst_addr,  // 取指 PC
    input [31:0] i_inst_rdata, // i_inst_addr 对应的 32 位指令 
    output [31:0] m_data_addr,// 数据存储器待写入地址
	 input [31:0] m_data_rdata,// m_data_addr 对应的 32 位数据
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
);

   
wire [31:0] IF_pc;


wire [3:0] Branch;
wire pasue;
wire [31:0] RD1;
wire [31:0] RD2;
wire [1:0] zero_rs_trans;
wire [1:0] zero_rt_trans;
wire [1:0] Alu_rs_trans;
wire [1:0] Alu_rt_trans;
wire [1:0] DM_rt_trans;

wire D_CP0Write;
wire D_BD;
wire D_eret;
wire [31:0] D_pc;
wire [31:0] D_code; 
wire [1:0] D_MemtoReg;
wire [3:0] D_MemWrite;
wire [4:0] AluControl;
wire AluSrc;
wire [1:0] D_RegDst;
wire D_RegWrite;
wire [4:0] D_W3;
wire [1:0] T_Alu_rs_use;
wire [1:0] T_Alu_rt_use;
wire [1:0] T_DM_rt_use;
wire [1:0] D_T_new;
wire [2:0] start;
wire [1:0] MD;
wire [2:0] DMControl;
wire MDuse;
wire equal;
wire less;
wire zero;
wire more;

wire [31:0] E_code;
wire E_CP0Write;
wire E_BD;
wire E_eret;
wire [3:0] E_Branch;
wire [31:0] E_p1;
wire [31:0] E_p2;
wire [1:0] E_MemtoReg;
wire [3:0] E_MemWrite;
wire E_RegWrite;
wire [4:0] E_AluControl;
wire [4:0] E_rs;
wire [4:0] E_rt;  
wire [4:0] E_A3;
wire E_AluSrc;
wire [1:0] E_T_new;
wire [31:0] E_pc;
wire [1:0] E_RegDst;
wire [2:0] E_start;
wire [1:0] E_MD;
wire [31:0] E_Aluout;
wire [31:0] p1;
wire [31:0] p2;
wire busy;
wire [31:0] MDout;
wire [2:0] E_DMControl;
 
wire [31:0] M_code;
wire [31:0] M_newRD2;
wire M_CP0Write;
wire M_BD;
wire M_eret;
wire [31:0] M_Aluout;
wire [1:0] M_MemtoReg;
wire [3:0] M_MemWrite;
wire M_RegWrite;
wire [4:0] M_A3;
wire [31:0] M_RD2;
wire [4:0] M_rt;
wire [1:0] M_T_new;
wire [31:0] M_pc;
wire [1:0] M_RegDst;
wire [2:0] M_DMControl;
wire [31:0] M_DMout;

wire [31:0] W_DMout;
wire [4:0] W_A3;
wire W_RegWrite;
wire [1:0] W_MemtoReg;
wire [1:0] W_T_new;
wire [1:0] W_RegDst;
wire [31:0] W_pc;
wire [3:0] byteen;

wire [4:0] G_A3;
wire G_RegWrite;
wire [31:0] G_out;
wire [31:0] Dout0;
wire [31:0] Dout1;
wire TCWE0;
wire TCWE1;
wire [31:0] rdata;
wire [4:0] finalExcCode;
wire [5:0] HWInt;
wire IRQ0;
wire IRQ1;
wire IntReq;
wire [31:0] CP0out;
wire [4:0] D_ExcCode;
wire [4:0] E_ExcCode;
wire [4:0] M_ExcCode;
wire E_overflow;
wire M_overflow;
wire [31:0] EPC;
wire [31:0] D_nextpc;
wire [31:0] E_nextpc;
wire [31:0] M_nextpc;
wire HardwareInt;
wire D_mfc0;
wire E_mfc0;
wire M_mfc0;
assign HWInt={3'b0,interrupt,IRQ1,IRQ0};
assign macroscopic_pc=M_pc;
Bridge bridge(.clk(clk),.HardwareInt(HardwareInt),.IntReq(IntReq),.M_Aluout(M_Aluout),.Dout0(Dout0),.Dout1(Dout1),.m_data_rdata(m_data_rdata),.byteen(byteen),.m_data_byteen(m_data_byteen),.TCWE0(TCWE0),
              .TCWE1(TCWE1),.data(rdata));
TC tc0(.clk(clk),.reset(reset),.Addr(M_Aluout),.WE(TCWE0),.Din(m_data_wdata),.Dout(Dout0),.IRQ(IRQ0));
TC tc1(.clk(clk),.reset(reset),.Addr(M_Aluout),.WE(TCWE1),.Din(m_data_wdata),.Dout(Dout1),.IRQ(IRQ1));



CP0 cp0(.HardwareInt(HardwareInt),.EPC(EPC),.IntReq(IntReq),.M_code(M_code),.clk(clk),.reset(reset),.In(M_newRD2),.PC(M_pc),.ExcCode(finalExcCode),.CP0Write(M_CP0Write),.HWInt(HWInt),.EXLClr(M_eret),.BD(M_BD),.out(CP0out));

NPC npc(.nextpc(D_nextpc),.EXLClr(M_eret),.EPC(EPC),.IntReq(IntReq),.clk(clk),.reset(reset),.pasue(pasue),.Branch(Branch),.equal(equal),.less(less),.zero(zero),
        .more(more),.RD1(RD1),.D_code(D_code),.D_pc(D_pc),.zero_rs_trans(zero_rs_trans),.M_Aluout(M_Aluout),
		  .W_DMout,.pc(IF_pc));
		  
IFD_Reg ifd_reg(.EXLClr(M_eret),.IntReq(IntReq),.reset(reset),.clk(clk),.new_code(i_inst_rdata),.pc(IF_pc),.pasue(pasue),
                .D_code(D_code),.D_pc(D_pc));
					 
Controller controller(.D_mfc0(D_mfc0),.D_ExcCode(D_ExcCode),.D_eret(D_eret),.D_CP0Write(D_CP0Write),.D_BD(D_BD),.E_Branch(E_Branch),.D_code(D_code),.MemtoReg(D_MemtoReg),.MemWrite(D_MemWrite),.Branch(Branch),.AluControl(AluControl),
                      .AluSrc(AluSrc),.RegDst(D_RegDst),.D_W3(D_W3),.RegWrite(D_RegWrite),.T_Alu_rs_use(T_Alu_rs_use),
							 .T_Alu_rt_use(T_Alu_rt_use),.T_DM_rt_use(T_DM_rt_use),.T_new(D_T_new),.start(start),.MD(MD),
							 .DMControl(DMControl),.MDuse(MDuse));			
							 
zero ZERO(.RD1(RD1),.RD2(RD2),.zero_rs_trans(zero_rs_trans),.zero_rt_trans(zero_rt_trans),.M_Aluout(M_Aluout),
          .W_DMout(W_DMout),.zero(zero),.equal(equal),.less(less),.more(more));
			 
GRF grf(.clk(clk),.reset(reset),.W_RegWrite(W_RegWrite),.D_code(D_code),.W_DMout(W_DMout),.W_A3(W_A3),.RD1(RD1),
        .RD2(RD2),.G_A3(G_A3),.G_RegWrite(G_RegWrite),.G_out(G_out));	

DE_Reg de_reg(.D_mfc0(D_mfc0),.E_mfc0(E_mfc0),.E_nextpc(E_nextpc),.D_nextpc(D_nextpc),.EXLClr(M_eret),.D_ExcCode(D_ExcCode),.E_ExcCode(E_ExcCode),.D_pc(D_pc),.IntReq(IntReq),.D_eret(D_eret),.D_CP0Write(D_CP0Write),.D_BD(D_BD),.E_eret(E_eret),.E_CP0Write(E_CP0Write),.E_BD(E_BD),
              .Branch(Branch),.E_Branch(E_Branch),.DMControl(DMControl),.reset(reset),.pasue(pasue),.clk(clk),.T_new(D_T_new),.D_code(D_code),.D_A3(D_W3),.MemtoReg(D_MemtoReg),.MemWrite(D_MemWrite),
              .Alucontrol(AluControl),.ALUSrc(AluSrc),.RegDst(D_RegDst),.RegWrite(D_RegWrite),.RD1(RD1),.RD2(RD2),.pc(D_pc),.start(start),
				  .MD(MD),.E_p1(E_p1),.E_p2(E_p2),.E_MemtoReg(E_MemtoReg),.E_MemWrite(E_MemWrite),.E_Alucontrol(E_AluControl),
				  .E_rs(E_rs),.E_rt(E_rt),.E_A3(E_A3),.E_ALUSrc(E_AluSrc),.E_T_new(E_T_new),.E_pc(E_pc),.E_RegDst(E_RegDst),
				  .E_start(E_start),.E_MD(E_MD),.E_DMControl(E_DMControl),.E_RegWrite(E_RegWrite),.E_code(E_code));		

ALU alu(.overflow(E_overflow),.E_pc(E_pc),.AluControl(E_AluControl),.RD1(E_p1),.RD2(E_p2),.E_code(E_code),.E_ALUSrc(E_AluSrc),.M_Aluout(M_Aluout),.W_DMout(W_DMout),.Alu_rs_trans(Alu_rs_trans),
        .Alu_rt_trans(Alu_rt_trans),.Aluout(E_Aluout),.p1(p1),.p2(p2));
		  
M_or_D m_or_d(.M_eret(M_eret),.clk(clk),.start(E_start),.p1(p1),.p2(p2),.MemtoReg(E_MemtoReg),.MD(E_MD),.busy(busy),.MDout(MDout));		  

EM_Reg em_reg(.E_mfc0(E_mfc0),.M_mfc0(M_mfc0),.E_nextpc(E_nextpc),.M_nextpc(M_nextpc),.EXLClr(M_eret),.M_overflow(M_overflow),.overflow(E_overflow),.M_ExcCode(M_ExcCode),.E_ExcCode(E_ExcCode),.IntReq(IntReq),.E_code(E_code),.M_code(M_code),.M_eret(M_eret),.M_CP0Write(M_CP0Write),.M_BD(M_BD),.E_eret(E_eret),.E_CP0Write(E_CP0Write),.E_BD(E_BD),
              .E_DMControl(E_DMControl),.clk(clk),.reset(reset),.E_T_new(E_T_new),.E_Aluout(E_Aluout),.RD2(E_p2),.E_MemtoReg(E_MemtoReg),.E_MemWrite(E_MemWrite),.E_A3(E_A3),
              .E_RegWrite(E_RegWrite),.E_rt(E_rt),.E_pc(E_pc),.E_RegDst(E_RegDst),.MDout(MDout),.M_Aluout(M_Aluout),.M_MemtoReg(M_MemtoReg),.M_MemWrite(M_MemWrite),.M_RegWrite(M_RegWrite),
				  .M_A3(M_A3),.M_RD2(M_RD2),.M_rt(M_rt),.M_T_new(M_T_new),.M_pc(M_pc),.M_RegDst(M_RegDst),.M_DMControl(M_DMControl)); 
				  
DM dm(.clk(clk),.HardwareInt(HardwareInt),.M_nextpc(M_nextpc),.M_overflow(M_overflow),.M_ExcCode(M_ExcCode),.finalExcCode(finalExcCode),.M_newRD2(M_newRD2),.M_pc(M_pc),.M_MemWrite(M_MemWrite),.M_RD2(M_RD2),.M_Aluout(M_Aluout),.DM_rt_trans(DM_rt_trans),.W_DMout(W_DMout),.G_out(G_out),.rdata(rdata),
      .DMControl(M_DMControl),.m_data_addr(m_data_addr),.m_data_wdata(m_data_wdata),.byteen(byteen),.m_inst_addr(m_inst_addr),.DMout(M_DMout));				  
				  
MW_Reg mw_reg(.M_mfc0(M_mfc0),.IntReq(IntReq),.CP0out(CP0out),.clk(clk),.reset(reset),.M_T_new(M_T_new),.M_DMout(M_DMout),.M_Aluout(M_Aluout),.M_MemtoReg(M_MemtoReg),.M_RegWrite(M_RegWrite),
              .M_A3(M_A3),.M_pc(M_pc),.W_MemtoReg(W_MemtoReg),.W_RegWrite(W_RegWrite),.W_DMout(W_DMout),.W_A3(W_A3),.W_T_new(W_T_new),
				  .W_RegDst(W_RegDst),.W_pc(W_pc));

Risk_Control risk_control
          (.E_T_new(E_T_new),.M_T_new(M_T_new),.W_T_new(W_T_new),.T_Alu_rs_use(T_Alu_rs_use),.T_Alu_rt_use(T_Alu_rt_use),.T_DM_rt_use(T_DM_rt_use),
			  .M_A3(M_A3),.W_A3(W_A3),.E_A3(E_A3),.G_A3(G_A3),.E_RegWrite(E_RegWrite),.M_RegWrite(M_RegWrite),.W_RegWrite(W_RegWrite),
			  .G_RegWrite(G_RegWrite),.Branch(Branch),.D_code(D_code),.Alu_rs(E_rs),.Alu_rt(E_rt),.DM_rt(M_rt),.MDuse(MDuse),.start(E_start),
			  .busy(busy),.zero_rs_trans(zero_rs_trans),.zero_rt_trans(zero_rt_trans),.Alu_rs_trans(Alu_rs_trans),.Alu_rt_trans(Alu_rt_trans),
			  .DM_rt_trans(DM_rt_trans),.pasue(pasue));
	
	
assign  i_inst_addr=IF_pc; 
//assign  m_data_addr
//assign  m_data_wdata,
//assign  m_data_byteen,
//assign  m_inst_addr,
assign  w_grf_we=W_RegWrite;
assign  w_grf_addr=W_A3;
assign  w_grf_wdata=W_DMout;
assign  w_inst_addr=W_pc;


endmodule
