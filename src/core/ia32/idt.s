/******************************************************************************/
/* Mithrill : Core : IA32 : Interrupt Descriptor Table                        */
/*                                                                            */
/* Copyright (c) 2004 - 2004  Mithrill Foundation                             */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation; either version 2 of the License, or          */
/* (at your option) any later version.                                        */
/******************************************************************************/

/******************************************************************************/
/* This IDT table is in the wrong format due to limitations of GAS (and any   */
/* other assembler I tried for that matter). Before the Core is started this  */
/* table needs to be patched by eiter the boot loader or by a special tool    */
/* after assembling. I should probably write my own assembler that CAN        */
/* perform arithmetics on addresses.                                          */
/******************************************************************************/

.macro idt_ig offset, selector, flags;
.long \offset;
.short \flags;
.short \selector;
.endm;

idt_ig              int_de,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_db,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_ni,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_bp,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_of,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_br,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_ud,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_nm,             SELECTOR_CORECODE,  0x8E00;

idt_ig              int_df,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_cs,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_ts,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_np,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_ss,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_gp,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_pf,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;

idt_ig              int_mf,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_ac,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_mc,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xf,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;

idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;

/*****************************************************************/

idt_ig              int_timer,          SELECTOR_CORECODE,  0x8E00;
idt_ig              int_01,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_02,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_03,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_04,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_05,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_06,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_07,             SELECTOR_CORECODE,  0x8E00;

idt_ig              int_08,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_09,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_10,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_11,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_12,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_13,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_14,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_15,             SELECTOR_CORECODE,  0x8E00;

/*****************************************************************/

idt_ig              ipc,                SELECTOR_CORECODE,  0xEE00;
idt_ig              create_thread,      SELECTOR_CORECODE,  0xEE00;
idt_ig              attach_int,         SELECTOR_CORECODE,  0xEE00;
idt_ig              create_space,       SELECTOR_CORECODE,  0xEE00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;

idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;
idt_ig              int_xx,             SELECTOR_CORECODE,  0x8E00;

t:

/******************************************************************************/
