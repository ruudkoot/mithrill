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

task_1:

    int $0x33;
    mov %ebx, %edx;

    mov $task_2, %esi;
    mov $0x20000, %edi;
    mov $0xB80E2, %ecx;
    int $0x31;

    mov %ebx, %edi;
    mov $1, %esi;
    int $0x32;

    int $0x33;
    mov %ebx, %edx;

    mov $task_3, %esi;
    mov $0x30000, %edi;
    mov $0xB80E4, %ecx;
    int $0x31;

    int $0x33;
    mov %ebx, %edx;

    mov $task_4, %esi;
    mov $0x40000, %edi;
    mov $0xB80E6, %ecx;
    int $0x31;

    mov %ebx, %edi;
    mov $14, %esi;
    int $0x32;

    int $0x33;
    mov %ebx, %edx;

    mov $task_5, %esi;
    mov $0x50000, %edi;
    mov $0xB80E8, %ecx;
    int $0x31;

    int $0x33;
    mov %ebx, %edx;

    mov $task_6, %esi;
    mov $0x60000, %edi;
    mov $0xB80EA, %ecx;
    int $0x31;

    mov %ebx, %edi;
    mov $15, %esi;
    int $0x32;

lalala:

    incb 0x000B8040
    incl c_counter1;
    pushl $10;
    pushl $c_buffer1;
    pushl c_counter1;    
    call i32toa;
    popl %eax;
    popl %eax;
    popl %eax;

    mov $16, %ecx;

    2:
        movb c_buffer1-1(,%ecx,1), %al;
        movb %al, 0xB8000-2(,%ecx,2);
    loop 2b;

    jmp lalala;

.balign 4096,0

task_2:
    incb 0x000B8042
    incl c_counter2;
    incl c_counter2;
    pushl $10;
    pushl $c_buffer2;
    pushl c_counter2;    
    call i32toa;
    popl %eax;
    popl %eax;
    popl %eax;

    mov $16, %ecx;

    2:
        movb c_buffer2-1(,%ecx,1), %al;
        movb %al, 0xB80A0-2(,%ecx,2);
    loop 2b;

    mov $1, %edx;
    int $0x30

    movl $0x60, %edx;
    inb %dx, %al;

    jmp task_2;

task_3:
    incb 0x000B8044
    incl c_counter3;
    incl c_counter3;
    incl c_counter3;
    pushl $10;
    pushl $c_buffer3;
    pushl c_counter3;    
    call i32toa;
    popl %eax;
    popl %eax;
    popl %eax;

    mov $16, %ecx;

    2:
        movb c_buffer3-1(,%ecx,1), %al;
        movb %al, 0xB8140-2(,%ecx,2);
    loop 2b;

    jmp task_3;

task_4:
    incb 0x000B8046
    incl c_counter4;
    pushl $10;
    pushl $c_buffer4;
    pushl c_counter4;    
    call i32toa;
    popl %eax;
    popl %eax;
    popl %eax;

    mov $16, %ecx;

    2:
        movb c_buffer4-1(,%ecx,1), %al;
        movb %al, 0xB8020-2(,%ecx,2);
    loop 2b;

    //cli;

    mov $'A', %al;
    mov %al, 0xB83C0;

    mov c_counter4, %ebx;
        mov $0x1f1, %edx;
    mov $0, %eax;
    outb %al, %dx;

    mov $0x1f2, %edx;
    mov $1, %eax;
    outb %al, %dx;

    mov $0x1f3, %edx;
    mov %ebx, %eax;
    outb %al, %dx;

    mov $0x1f4, %edx;
    mov %ebx, %eax;
    shr $8, %eax;
    outb %al, %dx;

    mov $0x1f5, %edx;
    mov %ebx, %eax;
    shr $16, %eax;
    outb %al, %dx;

    mov $0x1f6, %edx;
    mov %ebx, %eax;
    shr $24, %eax;
    and $0xF, %eax;
    or $0xE0, %eax;
    outb %al, %dx;

    mov $0x1f7, %edx;
    mov $0x20, %eax;
    outb %al, %dx;

    mov $0x3f6, %edx;
    inb %dx, %al;
    inb %dx, %al;
    inb %dx, %al;
    inb %dx, %al;

    mov $'B', %al;
    mov %al, 0xB83C0;

 /*   1:
    mov $0x3F6, %edx;
    inb %dx, %al;
    and $0x80, %al;
    cmp $0, %al;
    jne 1b;*/

    mov $'C', %al;
    mov %al, 0xB83C0;

    mov $14, %edx;
    int $0x30

    mov $'D', %al;
    mov %al, 0xB83C0;

    cld;
    mov $0x1f0, %edx;
    mov $256, %ecx;
    mov $disk_buffer, %edi;
    rep insw;

    mov $0x3f6, %edx;
    inb %dx, %al;
    inb %dx, %al;
    inb %dx, %al;
    inb %dx, %al;

    mov $0x1f7, %edx;
    inb %dx, %al;

    mov $64, %ecx;
    2:
        movb disk_buffer-1(,%ecx,1), %al;
        movb %al, 0xB8324-2(,%ecx,2);
    loop 2b;

    mov $64, %ecx;
    2:
        movb disk_buffer+64-1(,%ecx,1), %al;
        movb %al, 0xB83C4-2(,%ecx,2);
    loop 2b;

        mov $64, %ecx;
    2:
        movb disk_buffer+128-1(,%ecx,1), %al;
        movb %al, 0xB8464-2(,%ecx,2);
    loop 2b;

    mov $64, %ecx;
    2:
        movb disk_buffer+192-1(,%ecx,1), %al;
        movb %al, 0xB8504-2(,%ecx,2);
    loop 2b;
    
    mov $64, %ecx;
    2:
        movb disk_buffer+256-1(,%ecx,1), %al;
        movb %al, 0xB85A4-2(,%ecx,2);
    loop 2b;

    mov $64, %ecx;
    2:
        movb disk_buffer+320-1(,%ecx,1), %al;
        movb %al, 0xB8644-2(,%ecx,2);
    loop 2b;

        mov $64, %ecx;
    2:
        movb disk_buffer+384-1(,%ecx,1), %al;
        movb %al, 0xB86E4-2(,%ecx,2);
    loop 2b;

    mov $64, %ecx;
    2:
        movb disk_buffer+448-1(,%ecx,1), %al;
        movb %al, 0xB8784-2(,%ecx,2);
    loop 2b;

jmp task_4;

task_5:
    incb 0x000B8048
    incl c_counter5;
    incl c_counter5;
    incl c_counter5;
    pushl $10;
    pushl $c_buffer5;
    pushl c_counter5;    
    call i32toa;
    popl %eax;
    popl %eax;
    popl %eax;

    mov $16, %ecx;

    2:
        movb c_buffer5-1(,%ecx,1), %al;
        movb %al, 0xB80C0-2(,%ecx,2);
    loop 2b;

    //mov $14, %edx;
    //int $0x30

    jmp task_5;

task_6:
    incb 0x000B804A
    incl c_counter6;
    pushl $10;
    pushl $c_buffer6;
    pushl c_counter6;    
    call i32toa;
    popl %eax;
    popl %eax;
    popl %eax;

    mov $16, %ecx;

    2:
        movb c_buffer6-1(,%ecx,1), %al;
        movb %al, 0xB8160-2(,%ecx,2);
    loop 2b;

    movl c_counter6, %ebx;

    //mov $15, %edx;
    //int $0x30

jmp task_6;

c_counter1:
.long 0
c_buffer1:
.ascii "----------------"

c_counter2:
.long 0
c_buffer2:
.ascii "----------------"

c_counter3:
.long 0
c_buffer3:
.ascii "----------------"

c_counter4:
.long 0
c_buffer4:
.ascii "----------------"

c_counter5:
.long 0
c_buffer5:
.ascii "----------------"

c_counter6:
.long 0
c_buffer6:
.ascii "----------------"

i32toa:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	pushl	%ebx
	movl	8(%ebp), %edx
	movb	16(%ebp), %al
	movb	%al, -9(%ebp)
	movl	12(%ebp), %ecx
	testl	%edx, %edx
	js	L58
L46:
	movl	%ecx, %ebx
L47:
	movl	%edx, %eax
	movzbl	-9(%ebp), %esi
	cltd
	idivl	%esi
	movl	%eax, %esi
	movb	%dl, %al
	cmpb	$9, %al
	movl	%esi, %edx
	jle	L50
	addl	$55, %eax
L57:
	movb	%al, (%ecx)
	incl	%ecx
	testl	%esi, %esi
	jg	L47
	movb	$0, (%ecx)
	decl	%ecx
L53:
	movb	(%ecx), %dl
	movb	(%ebx), %al
	movb	%al, (%ecx)
	decl	%ecx
	movb	%dl, (%ebx)
	incl	%ebx
	cmpl	%ecx, %ebx
	jb	L53
	popl	%ecx
	popl	%ebx
	popl	%esi
	popl	%ebp
	ret
L50:
	addl	$48, %eax
	jmp	L57
L58:
	movb	$45, (%ecx)
	incl	%ecx
	negl	%edx
	jmp	L46

    disk_buffer:

/******************************************************************************/
