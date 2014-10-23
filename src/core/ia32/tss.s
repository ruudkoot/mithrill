/******************************************************************************/
/* Mithrill : Core :                                                          */
/*                                                                            */
/* Copyright (c) 2004 - 2004  Rudy Koot                 (Mithrill Foundation) */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation; either version 2 of the License, or          */
/* (at your option) any later version.                                        */
/******************************************************************************/

tss_previous:                           .long 0;
tss_esp0:                               .long 0xFFE01000;
tss_ss0:                                .long 0x0018;
tss_esp1:                               .long 0;
tss_ss1:                                .long 0;
tss_esp2:                               .long 0;
tss_ss2:                                .long 0;
tss_cr3:                                .long 0;
tss_eip:                                .long 0;
tss_eflags:                             .long 0x00003202;
tss_eax:                                .long 0xAAAAAAAA;
tss_ecx:                                .long 0xCCCCCCCC;
tss_edx:                                .long 0xDDDDDDDD;
tss_ebx:                                .long 0xBBBBBBBB;
tss_esp:                                .long 0;
tss_ebp:                                .long 0;
tss_esi:                                .long 0xEEEEEEEE;
tss_edi:                                .long 0xFFFFFFFF;
tss_es:                                 .long 0x002B;
tss_cs:                                 .long 0x0023;
tss_ss:                                 .long 0x002B;
tss_ds:                                 .long 0x002B;
tss_fs:                                 .long 0x002B;
tss_gs:                                 .long 0x002B;
tss_ldt:                                .long 0;
tss_io:                                 .long 0;

/******************************************************************************/
