/******************************************************************************/
/* Mithrill : Core : IA-32 : Interrupt Handling                               */
/*                                                                            */
/* Copyright (c) 2004 - 2004  Mithrill Group                                  */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation; either version 2 of the License, or          */
/* (at your option) any later version.                                        */
/******************************************************************************/

int_thread:
.rep 16
.long 0
.endr.

int_flag:
.rep 16
.long 0
.endr

int_01: movl %ebx, -16(%esp); movl  $1, %ebx; jmp int_handler;
int_02: movl %ebx, -16(%esp); movl  $2, %ebx; jmp int_handler;
int_03: movl %ebx, -16(%esp); movl  $3, %ebx; jmp int_handler;
int_04: movl %ebx, -16(%esp); movl  $4, %ebx; jmp int_handler;
int_05: movl %ebx, -16(%esp); movl  $5, %ebx; jmp int_handler;
int_06: movl %ebx, -16(%esp); movl  $6, %ebx; jmp int_handler;
int_07: movl %ebx, -16(%esp); movl  $7, %ebx; jmp int_handler;
int_08: movl %ebx, -16(%esp); movl  $8, %ebx; jmp int_handler;
int_09: movl %ebx, -16(%esp); movl  $9, %ebx; jmp int_handler;
int_10: movl %ebx, -16(%esp); movl $10, %ebx; jmp int_handler;
int_11: movl %ebx, -16(%esp); movl $11, %ebx; jmp int_handler;
int_12: movl %ebx, -16(%esp); movl $12, %ebx; jmp int_handler;
int_13: movl %ebx, -16(%esp); movl $13, %ebx; jmp int_handler;
int_14: movl %ebx, -16(%esp); movl $14, %ebx; jmp int_handler;
int_15: movl %ebx, -16(%esp); movl $15, %ebx; /* jmp int_handler;             */

int_handler:

    /* Save the user state.                                                   */
    movl %eax, -4(%esp);
    movl %ecx, -8(%esp);
    movl %edx, -12(%esp);
    /* movl %ebx, -16(%esp);                                                  */
    movl %ebp, -20(%esp);
    movl %esi, -24(%esp);
    movl %edi, -28(%esp);

    /* Use core DS.                                                           */
    mov $0x18, %eax;
    mov %ax, %ds;

    /* DEBUG: Display the thread state.                                       */
    /*mov %esp, %eax;
    and $0xFFFFF000, %eax;
    mov 8(%eax), %edx;
    movb $'R', %cl;
    movb %cl, (%edx);
    add $160, %edx;
    movb $' ', %cl;
    movb %cl, (%edx);*/
    
    /* DEBUG: Update the interrupt counter.                                   */
    /*incb 0XB809A;*/

    /* Do we need to clear the secondary slave interrupt controller?          */
    movb $0x20, %al;
    cmpb $7, %bl;
    jbe 1f;

    /* Clear the slave interrupt controller.                                  */
    movl $0xA0, %edx;
    outb %al, %dx;

    1:
    
    /* Clear the master interrupt controller.                                 */
    movl $0x20, %edx;
    outb %al, %dx;

    /* Find the TCB of the interrupt handler.                                 */
    mov int_thread(,%ebx,4), %eax;
    movl 4(%eax), %edx;

    /* Switch the page directory.                                             */
    movl 0xC(%eax), %esi;
    movl %esi, %cr3;

    /* Switch the kernel stack.                                               */
    add $0x1000, %eax;
    mov %eax, tss_esp0;
    mov %eax, %esp;
    sub $20, %esp;

    /* DEBUG: Update the thread status.                                       */
    /*mov %esp, %esi;
    and $0xFFFFF000, %esi;
    mov 8(%esi), %edi;
    movb $'R', %cl;
    movb %cl, (%edi);
    add $160, %edi;
    movb $'^', %cl;
    movb %cl, (%edi);*/

    /* Is the handler waiting on the interrupt?                               */
    cmp $0, %edx;
    je int_switch;

    /* Set the thread state to 'running'.                                     */
    sub $0x1000, %eax;
    movl $0, 4(%eax);
    
    /* Use user DS.                                                           */
    mov $0x2B, %eax;
    mov %ax, %ds;

    /* Set the output parameters.                                             */
    movl $14, %eax;

    /* Return to user mode.                                                   */
    iret;

int_switch:

    /* The interrupt is pending.                                              */
    movl $1, int_flag(,%ebx,4);

    /* Use user DS.                                                           */
    mov $0x2B, %eax;
    mov %ax, %ds;

    /* Restore the user state.                                                */
    movl -4(%esp), %eax;
    movl -8(%esp), %ecx;
    movl -12(%esp), %edx;
    movl -16(%esp), %ebx;
    movl -20(%esp), %ebp;
    movl -24(%esp), %esi;
    movl -28(%esp), %edi;
    
    /* Return to user mode.                                                   */
    iret;

/******************************************************************************/
