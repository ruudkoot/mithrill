/******************************************************************************/
/* Mithrill : Core : MultiBoot                                                */
/*                                                                            */
/* Copyright (c) 2003 - 2004  Mithrill Foundation                             */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation; either version 2 of the License, or          */
/* (at your option) any later version.                                        */
/******************************************************************************/

.set MB_IMAGEBASE, 0x00100000;

/* MultiBoot Header ***********************************************************/

.long 0x1BADB002;                       /* MultiBoot Signature                */
.long 0x00010003;                       /* MultiBoot Flags                    */
.long 0xE4514FFB;                       /* Checksum                           */
.long MB_IMAGEBASE;                     /* Image Physical Address             */
.long MB_IMAGEBASE;                     /* Image Physical Address             */
.long 0x00000000;                       /* Image Size                         */
.long 0x00400000;                       /* BSS End                            */
.long boot_entry;                       /* Entry Point                        */


/* Entry Point ****************************************************************/

boot_entry:

    /* Configure the Core *****************************************************/

    movl $0x00400000, %esp;
    movl $0x0002, %eax;
    pushl %eax;
    popfl;

    call boot_display_draw;
    call boot_pic_init;
    call boot_pit_init;

    call boot_mod_init;

    call boot_vmm_init;

    call boot_gdt_init;

    boot_gdt_cs:

    call boot_idt_patch;
    call boot_idt_init;

    call boot_tss_init;

    /* Create TCB *************************************************************/

    movl $0xFFE00000, 0xFFE00000;
    movl $0x00000000, 0xFFE00004;
    movl $0x000B80E0, 0xFFE00008;
    movl $0x00401000, 0xFFE0000C;

    movl $0x2B, 0xFFE00FFC;
    movl $0x10000, 0xFFE00FF8;
    movl $0x3202, 0xFFE00FF4;
    movl $0x23, 0xFFE00FF0;
    movl $0x0, 0xFFE00FEC;

    /* Kickstart Root *********************************************************/

    movl $0x2B, %eax;
    movl %eax, %ds;
    movl %eax, %es;
    movl %eax, %fs;
    movl %eax, %gs;

    movl $0xFFE01000, %esp;
    sub $20, %esp;

    iret;
        
/* Display : Draw *************************************************************/

boot_display_draw:

    /* Background *************************************************************/

    movl $1001, %ecx;

    1:
        movl $0x70007000, 0x000B7FFC(,%ecx,4);
    loop 1b;

    /* Title Bar **************************************************************/

    movl $120, %ecx;

    1:
        movl $0x1F001F00, 0x000B7FFC(,%ecx,4);
    loop 1b;

    ret;

/* GDT : Init *****************************************************************/

boot_gdt_init:

    lgdt boot_gdt_descriptor;
    mov $0x18, %eax;
    mov %ax, %ds;
    movw %ax, %es;
    movw %ax, %fs;
    movw %ax, %gs;
    movw %ax, %ss;
    movl $0x00400000, %esp;
    ljmp $0x10, $boot_gdt_cs;

    ret;


    .balign 4, 0;
    .short 0;
boot_gdt_descriptor:
    .short 0x0800;
    .long 0xFFC00020;

/* IDT : Init *****************************************************************/

boot_idt_init:

    lidt boot_idt_descriptor;
    ret;

    .balign 4, 0;
    .short 0;
boot_idt_descriptor:
    .short 0x0800;
    .long 0xFFC00070;

/* IDT : Patch ****************************************************************/

boot_idt_patch:

    mov $64, %ecx;

    1:
        dec %ecx;
        mov 0xFFC00070(,%ecx,8), %eax;
        mov 0xFFC00074(,%ecx,8), %ebx;

        mov %eax, %edx;
        and $0x0000FFFF, %edx;
        mov %edx, %esi;

        mov %ebx, %edx;
        and $0xFFFF0000, %edx;
        or %edx, %esi;

        mov %eax, %edx;
        and $0xFFFF0000, %edx;
        mov %edx, %edi;

        mov %ebx, %edx;
        and $0x0000FFFF, %edx;
        or %edx, %edi;

        mov %esi, 0xFFC00070(,%ecx,8);
        mov %edi, 0xFFC00074(,%ecx,8);
    jecxz 2f;
    jmp 1b;
    2:

    ret;

/* Modules : Init *************************************************************/

boot_mod_init:
    mov $0x2000, %ecx;
    mov $0, %edi;
    mov $0x00410000, %esi;
    rep movsd;

    ret


/* PIC : Init *****************************************************************/

boot_pic_init:

    	mov $0x11, %al;
	    out %al, $0x20;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    out %al, $0xA0;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    mov $0x20, %al;
	    out %al, $0x21;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    mov $0x28, %al;
	    out %al, $0xA1;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    mov $0x04, %al;
	    out %al, $0x21;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    mov $0x02, %al;
	    out %al, $0xA1;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    mov $0x01, %al;
	    out %al, $0x21;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    out %al, $0xA1;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    mov $0x00, %al;
	    out %al, $0x21;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

	    out %al, $0xA1;
	    /*jmp .+2;*/
	    /*jmp .+2;*/

        ret;

/* PIT : Init *****************************************************************/

boot_pit_init:

        movb $0x34, %al;
        movl $0x43, %edx;
        outb %al, %dx;

        movb $0x9B, %al;
        movl $0x40, %edx;
        outb %al, %dx;

        movb $0x2E, %al;
        outb %al, %dx;

        ret;

/* TSS : Init *****************************************************************/

boot_tss_init:
        movl $0x08, %eax;
        ltr %ax;
        ret;

/* VMM : Init *****************************************************************/

boot_vmm_init:
        mov $0x00401000, %eax;
        mov %eax, %cr3;

        mov %cr0, %eax;
        or $0x80000000, %eax;
        mov %eax, %cr0;

        ret;

/******************************************************************************/
