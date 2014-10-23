/******************************************************************************/
/* Mithrill : Core : IA-32 : Exceptions                                       */
/*                                                                            */
/* Copyright (c) 2004 - 2004  Rudy Koot                 (Mithrill Foundation) */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation; either version 2 of the License, or          */
/* (at your option) any later version.                                        */
/******************************************************************************/

int_xx:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'X', 0XB809C;
    movw $0x1F00 + 'X', 0XB809E;
    cli;
    hlt;
int_de:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'D', 0XB809C;
    movw $0x1F00 + 'E', 0XB809E;
    cli;
    hlt;
int_db:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'D', 0XB809C;
    movw $0x1F00 + 'B', 0XB809E;
    cli;
    hlt;
int_ni:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'N', 0XB809C;
    movw $0x1F00 + 'I', 0XB809E;
    cli;
    hlt;
int_bp:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'B', 0XB809C;
    movw $0x1F00 + 'P', 0XB809E;
    cli;
    hlt;
int_of:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'O', 0XB809C;
    movw $0x1F00 + 'F', 0XB809E;
    cli;
    hlt;
int_br:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'B', 0XB809C;
    movw $0x1F00 + 'R', 0XB809E;
    cli;
    hlt;
int_ud:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'U', 0XB809C;
    movw $0x1F00 + 'D', 0XB809E;
    cli;
    hlt;
int_nm:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'N', 0XB809C;
    movw $0x1F00 + 'M', 0XB809E;
    cli;
    hlt;
int_df:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'D', 0XB809C;
    movw $0x1F00 + 'F', 0XB809E;
    cli;
    hlt;
int_cs:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'C', 0XB809C;
    movw $0x1F00 + 'S', 0XB809E;
    cli;
    hlt;
int_ts:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'T', 0XB809C;
    movw $0x1F00 + 'S', 0XB809E;
    cli;
    hlt;
int_np:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'N', 0XB809C;
    movw $0x1F00 + 'P', 0XB809E;
    cli;
    hlt;
int_ss:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'S', 0XB809C;
    movw $0x1F00 + 'S', 0XB809E;
    cli;
    hlt;
int_gp:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'G', 0XB809C;
    movw $0x1F00 + 'P', 0XB809E;
    cli;
    hlt;
int_pf:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'P', 0XB809C;
    movw $0x1F00 + 'F', 0XB809E;
    cli;
    hlt;
int_mf:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'M', 0XB809C;
    movw $0x1F00 + 'F', 0XB809E;
    cli;
    hlt;
int_ac:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'A', 0XB809C;
    movw $0x1F00 + 'C', 0XB809E;
    cli;
    hlt;
int_mc:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'M', 0XB809C;
    movw $0x1F00 + 'C', 0XB809E;
    cli;
    hlt;
int_xf:
    mov $0x18, %eax;
    mov %ax, %ds;
    movw $0x1F00 + 'X', 0XB809C;
    movw $0x1F00 + 'F', 0XB809E;
    cli;
    hlt;

/******************************************************************************/
