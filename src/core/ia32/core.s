.set IDT_NULL, 0
.set SELECTOR_CORECODE, 0x10

.set STATE_RUNNING, 0
.set STATE_WAITING, 1

.set TCB_NEXT, 0
.set TCB_STATE, 4

.ascii "< MithrillCore >"

.align 16, 0
.ascii "* GDT"
.align 16, 0
.include "gdt.s"

.align 16, 0
.ascii "* IDT"
.align 16, 0
.include "idt.s"

.align 16, 0
.ascii "* TSS"
.align 16, 0
.include "tss.s"

.align 16, 0
.ascii "* Exceptions"
.align 16, 0
.include "xcpt.s"

.align 16, 0
.ascii "* Interrupts"
.align 16, 0
.include "int.s"

.align 16, 0
.ascii "* XXXX"
.align 16, 0

/******************************************************************************/

robin:
.long 0xFFE00000

int_timer:

    /* Save the user registers.                                               */
    movl %eax, -4(%esp);
    movl %ecx, -8(%esp);
    movl %edx, -12(%esp);
    movl %ebx, -16(%esp);
    movl %ebp, -20(%esp);
    movl %esi, -24(%esp);
    movl %edi, -28(%esp);

    /* Use core DS.                                                           */
    movl $0x18, %eax;
    mov %ax, %ds;

    /* DEBUG: Update the thread status.                                       */
    mov %esp, %eax;
    and $0xFFFFF000, %eax;
    mov 8(%eax), %ebx;
    movb $'R', %cl;
    movb %cl, (%ebx);
    add $160, %ebx;
    movb $' ', %cl;
    movb %cl, (%ebx);

    /* DEBUG: Update the interrupt status.                                    */
    incb 0x000B8120

    /* Clear the interrupt controller.                                        */
    mov $0x20, %edx;
    mov $0x20, %eax;
    outb %al,%dx

sw_a:

    /* Get the address of the next TCB.                                       */
    mov robin, %eax;
    and $0xFFFFF000, %eax;
    mov (%eax), %ebx;

    /* Determine if the thread is waiting.                                    */
    movl 4(%ebx), %edx;
    cmpl $0, %edx;
    je sw_b;

    /* DEBUG: Update the thread status.                                       */
    mov 8(%ebx), %esi;
    movb $'W', %cl;
    movb %cl, (%esi);

    /* Try the next TCB.                                                      */
    mov %ebx, robin;
    jmp sw_a;

sw_b:

    movl %ebx, robin;

    /* Switch the page directory.                                             */
    mov 0xC(%ebx), %eax;
    mov %eax, %cr3;

    /* Switch the kernel stack.                                               */
    add $0x1000, %ebx;
    mov %ebx, tss_esp0;
    mov %ebx, %esp;
    sub $20, %esp;

    /* Use user DS.                                                           */
    mov $0x2B, %eax;
    mov %ax, %ds;

    /* DEBUG: Display the active thread.                                      */
    mov %esp, %eax;
    and $0xFFFFF000, %eax;
    mov 8(%eax), %ebx;
    add $160, %ebx;
    movb $'^', %cl;
    movb %cl, (%ebx);

    /* Return to user mode.                                                   */
    movl -4(%esp), %eax;
    movl -8(%esp), %ecx;
    movl -12(%esp), %edx;
    movl -16(%esp), %ebx;
    movl -20(%esp), %ebp;
    movl -24(%esp), %esi;
    movl -28(%esp), %edi;
    iret;

/******************************************************************************/


/******************************************************************************/

/*      in                  special     out
/* eax:                                                                       */
/* ebx:                                 thread id / tcb address               */
/* edx: page directory                                                        */
/* ecx: debug address                                                         */
/* esi: entry point                                                           */
/* edi: stack pointer                                                         */
/* ebp:                                                                       */
/* esp:                                                                       */

create_thread:

    mov $0x18, %eax;
    mov %ax, %ds;

    mov mem_stack, %ebp;
    mov %ebp, %ebx;
    shl $2, %ebx;
    add $memory_buffer, %ebx;
    mov (%ebx), %ebx;

    mov %esp, %eax;
    and $0xFFFFF000, %eax;

    mov %ecx, 0x08(%ebx);
    mov %edx, 0x0C(%ebx);

    mov (%eax), %edx;  // [FFE0 0000] -> *
    mov %edx, (%ebx);  // * -> [FFE0 1000]
    mov %ebx, (%eax);  // FFE0 1000 -> [FFE0 0000]

    mov $0x2B, %ecx;
    mov %ecx, 0xFFC(%ebx);
    mov %edi, 0xFF8(%ebx);
    mov $0x3202, %ecx;
    mov %ecx, 0xFF4(%ebx);
    mov $0x23, %ecx;
    mov %ecx, 0xFF0(%ebx);
    mov %esi, 0xFEC(%ebx);

    inc %ebp;
    mov %ebp, mem_stack;

    mov $0x2B, %eax;
    mov %ax, %ds;

    iret;

/*      in                  special     out
/* eax:                                                                       */
/* ebx:                                                                       */
/* edx:                                                                       */
/* ecx:                                                                       */
/* esi: interrupt                                                             */
/* edi: thread id                                                             */
/* ebp:                                                                       */
/* esp:                                                                       */

attach_int:

    mov $0x18, %eax;
    mov %ax, %ds;

    movl %edi, int_thread(,%esi,4);

    mov $0x2B, %eax;
    mov %ax, %ds;

    iret;

/******************************************************************************/

ipc:

/* eax: send to                         from                                  */
/* ebx: IGNORED                         mr1                                   */
/* edx: receive from        sysexit     UNDEFINED                             */
/* ecx: timeouts            sysexit     UNDEFINED                             */
/* esi: mr0                             mr0                                   */
/* edi: utcb                            PRESERVED                             */
/* ebp: IGNORED                         mr2                                   */
/* esp: PRESERVED                       PRESERVED                             */

    /* Restore the Core Data Segment.                                         */
    movl $0x18, %ebx;
    movw %bx, %ds;

    mov $'A', %al;
    mov %al, 0xB8460;

    /* INTERRUPT HANDLING */
    cmp $16, %edx;
    jae ipc_notint;

    cmp $0, int_flag(,%edx,4);
    jne ipc_intwaiting;

    /* SWITCH */

        mov $'B', %al;
    mov %al, 0xB8460;


    mov %esp, %eax;
    and $0xFFFFF000, %eax;
    mov 8(%eax), %ebx;
    movb $'W', %cl;
    movb %cl, (%ebx);
    add $160, %ebx;
    movb $' ', %cl;
    movb %cl, (%ebx);

ipc_b:

    mov %esp, %eax;
    and $0xFFFFF000, %eax;
    movl $1, 4(%eax); /* WAIT */
    mov (%eax), %ebx;

    cmpl $0, 4(%ebx);
    je ipc_a;

    mov %ebx, %esp;
    jmp ipc_b;

ipc_a:

    add $0x1000, %ebx;
    mov %ebx, tss_esp0;
    mov %ebx, %esp;
    sub $20, %esp;
    

    mov %esp, %eax;
    and $0xFFFFF000, %eax;
    mov 8(%eax), %ebx;
    movb $'R', %cl;
    movb %cl, (%ebx);
    add $160, %ebx;
    movb $'^', %cl;
    movb %cl, (%ebx);

        mov $'C', %al;
    mov %al, 0xB8460;


    mov $0x2B, %eax;
    mov %ax, %ds;

    movl -4(%esp), %eax;
    movl -8(%esp), %ecx;
    movl -12(%esp), %edx;
    movl -16(%esp), %ebx;
    movl -20(%esp), %ebp;
    movl -24(%esp), %esi;
    movl -28(%esp), %edi;
    
    iret;

ipc_intwaiting:
    mov $'D', %al;
    mov %al, 0xB8460;


    movl $0, int_flag(,%edx,4);
    jmp ipc_return;

ipc_notint:

ipc_return:

    /* Restore the User Data Segment.                                         */
    movl $0x2B, %ebx;
    movw %bx, %ds;

    iret;

/******************************************************************************/

create_space:

/*      in                     special                out                     */
/* eax:                                                                       */
/* ebx:                                               space identifier        */
/* edx:                                                                       */
/* ecx:                                                                       */
/* esi:                                                                       */
/* edi:                                                                       */
/* ebp:                                                                       */
/* esp:                                                                       */

    movl $0x18, %eax;
    movw %ax, %ds;

    call alloc_page;

    movl $0xFFC01000, %esi;
    movl %eax, %edi;
    movl $0x0400, %ecx;
    cld;
    rep movsl;

    movl $0x2B, %eax;
    movw %ax, %ds;

    iret;

/******************************************************************************/

alloc_page:

/*      in                  special     out
/* eax:                                 virtual address                       */
/* ebx:                                 physical  address                     */
/* edx:                                                                       */
/* ecx:                                                                       */
/* esi:                                                                       */
/* edi:                                                                       */
/* ebp:                                                                       */
/* esp:                                                                       */

    
    mov mem_stack, %ebx;
    mov %ebx, %eax;
    shl $2, %eax;
    add $memory_buffer, %eax;
    mov (%eax), %eax;

    incl %ebx;
    movl %ebx, mem_stack;

    movl %eax, %ebx;
    subl $0xFF800000, %ebx;

    ret;

/******************************************************************************/

mem_stack: 
    .long 1;

.balign 4096, 0

.long 0x00403007
.rep 1022
.long 0
.endr
.long 0x00402007

.macro pd b, s=0
.if \s-0x40000
.long \b + \s + 7
pd \b, \s+4096
.endif
.endm

.balign 4096, 0

pd 0x00400000
pd 0x00440000
pd 0x00480000
pd 0x004C0000

pd 0x00500000
pd 0x00540000
pd 0x00580000
pd 0x005C0000

pd 0x00600000
pd 0x00640000
pd 0x00680000
pd 0x006C0000

pd 0x00700000
pd 0x00740000
pd 0x00780000
pd 0x007C0000

.balign 4096, 0

pd 0x00000000
pd 0x00040000
pd 0x00080000
pd 0x000C0000

pd 0x00100000
pd 0x00140000
pd 0x00180000
pd 0x001C0000

pd 0x00200000
pd 0x00240000
pd 0x00280000
pd 0x002C0000

pd 0x00300000
pd 0x00340000
pd 0x00380000
pd 0x003C0000

.balign 4096, 0

memory_buffer:

.macro se b, s=0
.if \s-0x40000
.long \b + \s
se \b, \s+4096
.endif
.endm

se 0xFFE00000
se 0xFFE40000
se 0xFFE80000
se 0xFFEC0000

se 0xFFF00000
se 0xFFF40000
se 0xFFF80000
se 0xFFFC0000

disk_buffer:

. = 0xFFFC
.long 0xFFFFFFFF



/******************************************************************************/

