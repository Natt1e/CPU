/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/Ise_Files/P7/IFD_Reg.v";
static int ng1[] = {1, 0};
static int ng2[] = {0, 0};
static unsigned int ng3[] = {12288U, 0U};
static unsigned int ng4[] = {16768U, 0U};



static void Always_32_0(char *t0)
{
    char t6[8];
    char t22[8];
    char t37[8];
    char t53[8];
    char t61[8];
    char t89[8];
    char t104[8];
    char t120[8];
    char t128[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    char *t36;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;
    char *t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    char *t65;
    char *t66;
    char *t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    char *t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    char *t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    char *t96;
    char *t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;
    char *t102;
    char *t103;
    char *t105;
    char *t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    char *t119;
    char *t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    char *t127;
    unsigned int t129;
    unsigned int t130;
    unsigned int t131;
    char *t132;
    char *t133;
    char *t134;
    unsigned int t135;
    unsigned int t136;
    unsigned int t137;
    unsigned int t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    char *t142;
    char *t143;
    unsigned int t144;
    unsigned int t145;
    unsigned int t146;
    int t147;
    unsigned int t148;
    unsigned int t149;
    unsigned int t150;
    int t151;
    unsigned int t152;
    unsigned int t153;
    unsigned int t154;
    unsigned int t155;
    char *t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    unsigned int t160;
    unsigned int t161;
    char *t162;
    char *t163;

LAB0:    t1 = (t0 + 1996U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 2192);
    *((int *)t2) = 1;
    t3 = (t0 + 2024);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(32, ng0);

LAB5:    xsi_set_current_line(33, ng0);
    t4 = (t0 + 784U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t4 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t4);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB9;

LAB6:    if (t18 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB9:    memset(t22, 0, 8);
    t23 = (t6 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t6);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB10;

LAB11:    if (*((unsigned int *)t23) != 0)
        goto LAB12;

LAB13:    t30 = (t22 + 4);
    t31 = *((unsigned int *)t22);
    t32 = (!(t31));
    t33 = *((unsigned int *)t30);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB14;

LAB15:    memcpy(t61, t22, 8);

LAB16:    memset(t89, 0, 8);
    t90 = (t61 + 4);
    t91 = *((unsigned int *)t90);
    t92 = (~(t91));
    t93 = *((unsigned int *)t61);
    t94 = (t93 & t92);
    t95 = (t94 & 1U);
    if (t95 != 0)
        goto LAB28;

LAB29:    if (*((unsigned int *)t90) != 0)
        goto LAB30;

LAB31:    t97 = (t89 + 4);
    t98 = *((unsigned int *)t89);
    t99 = (!(t98));
    t100 = *((unsigned int *)t97);
    t101 = (t99 || t100);
    if (t101 > 0)
        goto LAB32;

LAB33:    memcpy(t128, t89, 8);

LAB34:    t156 = (t128 + 4);
    t157 = *((unsigned int *)t156);
    t158 = (~(t157));
    t159 = *((unsigned int *)t128);
    t160 = (t159 & t158);
    t161 = (t160 != 0);
    if (t161 > 0)
        goto LAB46;

LAB47:    xsi_set_current_line(39, ng0);
    t2 = (t0 + 1152U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t4);
    t13 = *((unsigned int *)t5);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t4);
    t17 = *((unsigned int *)t5);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB87;

LAB84:    if (t18 != 0)
        goto LAB86;

LAB85:    *((unsigned int *)t6) = 1;

LAB87:    t8 = (t6 + 4);
    t24 = *((unsigned int *)t8);
    t25 = (~(t24));
    t26 = *((unsigned int *)t6);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB88;

LAB89:    xsi_set_current_line(41, ng0);

LAB91:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 876U);
    t3 = *((char **)t2);
    t2 = (t0 + 1380);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 32, 0LL);
    xsi_set_current_line(43, ng0);
    t2 = (t0 + 1060U);
    t3 = *((char **)t2);
    t2 = (t0 + 1472);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 32, 0LL);

LAB90:
LAB48:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    *((unsigned int *)t22) = 1;
    goto LAB13;

LAB12:    t29 = (t22 + 4);
    *((unsigned int *)t22) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB13;

LAB14:    t35 = (t0 + 692U);
    t36 = *((char **)t35);
    t35 = ((char*)((ng1)));
    memset(t37, 0, 8);
    t38 = (t36 + 4);
    t39 = (t35 + 4);
    t40 = *((unsigned int *)t36);
    t41 = *((unsigned int *)t35);
    t42 = (t40 ^ t41);
    t43 = *((unsigned int *)t38);
    t44 = *((unsigned int *)t39);
    t45 = (t43 ^ t44);
    t46 = (t42 | t45);
    t47 = *((unsigned int *)t38);
    t48 = *((unsigned int *)t39);
    t49 = (t47 | t48);
    t50 = (~(t49));
    t51 = (t46 & t50);
    if (t51 != 0)
        goto LAB20;

LAB17:    if (t49 != 0)
        goto LAB19;

LAB18:    *((unsigned int *)t37) = 1;

LAB20:    memset(t53, 0, 8);
    t54 = (t37 + 4);
    t55 = *((unsigned int *)t54);
    t56 = (~(t55));
    t57 = *((unsigned int *)t37);
    t58 = (t57 & t56);
    t59 = (t58 & 1U);
    if (t59 != 0)
        goto LAB21;

LAB22:    if (*((unsigned int *)t54) != 0)
        goto LAB23;

LAB24:    t62 = *((unsigned int *)t22);
    t63 = *((unsigned int *)t53);
    t64 = (t62 | t63);
    *((unsigned int *)t61) = t64;
    t65 = (t22 + 4);
    t66 = (t53 + 4);
    t67 = (t61 + 4);
    t68 = *((unsigned int *)t65);
    t69 = *((unsigned int *)t66);
    t70 = (t68 | t69);
    *((unsigned int *)t67) = t70;
    t71 = *((unsigned int *)t67);
    t72 = (t71 != 0);
    if (t72 == 1)
        goto LAB25;

LAB26:
LAB27:    goto LAB16;

LAB19:    t52 = (t37 + 4);
    *((unsigned int *)t37) = 1;
    *((unsigned int *)t52) = 1;
    goto LAB20;

LAB21:    *((unsigned int *)t53) = 1;
    goto LAB24;

LAB23:    t60 = (t53 + 4);
    *((unsigned int *)t53) = 1;
    *((unsigned int *)t60) = 1;
    goto LAB24;

LAB25:    t73 = *((unsigned int *)t61);
    t74 = *((unsigned int *)t67);
    *((unsigned int *)t61) = (t73 | t74);
    t75 = (t22 + 4);
    t76 = (t53 + 4);
    t77 = *((unsigned int *)t75);
    t78 = (~(t77));
    t79 = *((unsigned int *)t22);
    t80 = (t79 & t78);
    t81 = *((unsigned int *)t76);
    t82 = (~(t81));
    t83 = *((unsigned int *)t53);
    t84 = (t83 & t82);
    t85 = (~(t80));
    t86 = (~(t84));
    t87 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t87 & t85);
    t88 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t88 & t86);
    goto LAB27;

LAB28:    *((unsigned int *)t89) = 1;
    goto LAB31;

LAB30:    t96 = (t89 + 4);
    *((unsigned int *)t89) = 1;
    *((unsigned int *)t96) = 1;
    goto LAB31;

LAB32:    t102 = (t0 + 600U);
    t103 = *((char **)t102);
    t102 = ((char*)((ng1)));
    memset(t104, 0, 8);
    t105 = (t103 + 4);
    t106 = (t102 + 4);
    t107 = *((unsigned int *)t103);
    t108 = *((unsigned int *)t102);
    t109 = (t107 ^ t108);
    t110 = *((unsigned int *)t105);
    t111 = *((unsigned int *)t106);
    t112 = (t110 ^ t111);
    t113 = (t109 | t112);
    t114 = *((unsigned int *)t105);
    t115 = *((unsigned int *)t106);
    t116 = (t114 | t115);
    t117 = (~(t116));
    t118 = (t113 & t117);
    if (t118 != 0)
        goto LAB38;

LAB35:    if (t116 != 0)
        goto LAB37;

LAB36:    *((unsigned int *)t104) = 1;

LAB38:    memset(t120, 0, 8);
    t121 = (t104 + 4);
    t122 = *((unsigned int *)t121);
    t123 = (~(t122));
    t124 = *((unsigned int *)t104);
    t125 = (t124 & t123);
    t126 = (t125 & 1U);
    if (t126 != 0)
        goto LAB39;

LAB40:    if (*((unsigned int *)t121) != 0)
        goto LAB41;

LAB42:    t129 = *((unsigned int *)t89);
    t130 = *((unsigned int *)t120);
    t131 = (t129 | t130);
    *((unsigned int *)t128) = t131;
    t132 = (t89 + 4);
    t133 = (t120 + 4);
    t134 = (t128 + 4);
    t135 = *((unsigned int *)t132);
    t136 = *((unsigned int *)t133);
    t137 = (t135 | t136);
    *((unsigned int *)t134) = t137;
    t138 = *((unsigned int *)t134);
    t139 = (t138 != 0);
    if (t139 == 1)
        goto LAB43;

LAB44:
LAB45:    goto LAB34;

LAB37:    t119 = (t104 + 4);
    *((unsigned int *)t104) = 1;
    *((unsigned int *)t119) = 1;
    goto LAB38;

LAB39:    *((unsigned int *)t120) = 1;
    goto LAB42;

LAB41:    t127 = (t120 + 4);
    *((unsigned int *)t120) = 1;
    *((unsigned int *)t127) = 1;
    goto LAB42;

LAB43:    t140 = *((unsigned int *)t128);
    t141 = *((unsigned int *)t134);
    *((unsigned int *)t128) = (t140 | t141);
    t142 = (t89 + 4);
    t143 = (t120 + 4);
    t144 = *((unsigned int *)t142);
    t145 = (~(t144));
    t146 = *((unsigned int *)t89);
    t147 = (t146 & t145);
    t148 = *((unsigned int *)t143);
    t149 = (~(t148));
    t150 = *((unsigned int *)t120);
    t151 = (t150 & t149);
    t152 = (~(t147));
    t153 = (~(t151));
    t154 = *((unsigned int *)t134);
    *((unsigned int *)t134) = (t154 & t152);
    t155 = *((unsigned int *)t134);
    *((unsigned int *)t134) = (t155 & t153);
    goto LAB45;

LAB46:    xsi_set_current_line(33, ng0);

LAB49:    xsi_set_current_line(34, ng0);
    t162 = ((char*)((ng2)));
    t163 = (t0 + 1380);
    xsi_vlogvar_wait_assign_value(t163, t162, 0, 0, 32, 0LL);
    xsi_set_current_line(35, ng0);
    t2 = (t0 + 600U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng1)));
    memset(t37, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t4);
    t13 = *((unsigned int *)t5);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t4);
    t17 = *((unsigned int *)t5);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB53;

LAB50:    if (t18 != 0)
        goto LAB52;

LAB51:    *((unsigned int *)t37) = 1;

LAB53:    memset(t22, 0, 8);
    t8 = (t37 + 4);
    t24 = *((unsigned int *)t8);
    t25 = (~(t24));
    t26 = *((unsigned int *)t37);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB54;

LAB55:    if (*((unsigned int *)t8) != 0)
        goto LAB56;

LAB57:    t23 = (t22 + 4);
    t31 = *((unsigned int *)t22);
    t32 = *((unsigned int *)t23);
    t33 = (t31 || t32);
    if (t33 > 0)
        goto LAB58;

LAB59:    t34 = *((unsigned int *)t22);
    t40 = (~(t34));
    t41 = *((unsigned int *)t23);
    t42 = (t40 || t41);
    if (t42 > 0)
        goto LAB60;

LAB61:    if (*((unsigned int *)t23) > 0)
        goto LAB62;

LAB63:    if (*((unsigned int *)t22) > 0)
        goto LAB64;

LAB65:    memcpy(t6, t53, 8);

LAB66:    t67 = (t0 + 1472);
    xsi_vlogvar_wait_assign_value(t67, t6, 0, 0, 32, 0LL);
    goto LAB48;

LAB52:    t7 = (t37 + 4);
    *((unsigned int *)t37) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB53;

LAB54:    *((unsigned int *)t22) = 1;
    goto LAB57;

LAB56:    t21 = (t22 + 4);
    *((unsigned int *)t22) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB57;

LAB58:    t29 = ((char*)((ng3)));
    goto LAB59;

LAB60:    t30 = (t0 + 692U);
    t35 = *((char **)t30);
    t30 = ((char*)((ng1)));
    memset(t89, 0, 8);
    t36 = (t35 + 4);
    t38 = (t30 + 4);
    t43 = *((unsigned int *)t35);
    t44 = *((unsigned int *)t30);
    t45 = (t43 ^ t44);
    t46 = *((unsigned int *)t36);
    t47 = *((unsigned int *)t38);
    t48 = (t46 ^ t47);
    t49 = (t45 | t48);
    t50 = *((unsigned int *)t36);
    t51 = *((unsigned int *)t38);
    t55 = (t50 | t51);
    t56 = (~(t55));
    t57 = (t49 & t56);
    if (t57 != 0)
        goto LAB70;

LAB67:    if (t55 != 0)
        goto LAB69;

LAB68:    *((unsigned int *)t89) = 1;

LAB70:    memset(t61, 0, 8);
    t52 = (t89 + 4);
    t58 = *((unsigned int *)t52);
    t59 = (~(t58));
    t62 = *((unsigned int *)t89);
    t63 = (t62 & t59);
    t64 = (t63 & 1U);
    if (t64 != 0)
        goto LAB71;

LAB72:    if (*((unsigned int *)t52) != 0)
        goto LAB73;

LAB74:    t60 = (t61 + 4);
    t68 = *((unsigned int *)t61);
    t69 = *((unsigned int *)t60);
    t70 = (t68 || t69);
    if (t70 > 0)
        goto LAB75;

LAB76:    t71 = *((unsigned int *)t61);
    t72 = (~(t71));
    t73 = *((unsigned int *)t60);
    t74 = (t72 || t73);
    if (t74 > 0)
        goto LAB77;

LAB78:    if (*((unsigned int *)t60) > 0)
        goto LAB79;

LAB80:    if (*((unsigned int *)t61) > 0)
        goto LAB81;

LAB82:    memcpy(t53, t66, 8);

LAB83:    goto LAB61;

LAB62:    xsi_vlog_unsigned_bit_combine(t6, 32, t29, 32, t53, 32);
    goto LAB66;

LAB64:    memcpy(t6, t29, 8);
    goto LAB66;

LAB69:    t39 = (t89 + 4);
    *((unsigned int *)t89) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB70;

LAB71:    *((unsigned int *)t61) = 1;
    goto LAB74;

LAB73:    t54 = (t61 + 4);
    *((unsigned int *)t61) = 1;
    *((unsigned int *)t54) = 1;
    goto LAB74;

LAB75:    t65 = ((char*)((ng4)));
    goto LAB76;

LAB77:    t66 = ((char*)((ng3)));
    goto LAB78;

LAB79:    xsi_vlog_unsigned_bit_combine(t53, 32, t65, 32, t66, 32);
    goto LAB83;

LAB81:    memcpy(t53, t65, 8);
    goto LAB83;

LAB86:    t7 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB87;

LAB88:    xsi_set_current_line(40, ng0);
    t21 = (t0 + 1380);
    t23 = (t21 + 36U);
    t29 = *((char **)t23);
    t30 = (t0 + 1380);
    xsi_vlogvar_wait_assign_value(t30, t29, 0, 0, 32, 0LL);
    goto LAB90;

}


extern void work_m_00000000003643609613_1464637423_init()
{
	static char *pe[] = {(void *)Always_32_0};
	xsi_register_didat("work_m_00000000003643609613_1464637423", "isim/mips_txt_isim_beh.exe.sim/work/m_00000000003643609613_1464637423.didat");
	xsi_register_executes(pe);
}
