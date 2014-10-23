/******************************************************************************/
/* Mithrill : Core : Link Script                                              */
/* Copyright (c) 2004  Rudy Koot                        (Mithrill Foundation) */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation; either version 2 of the License, or          */
/* (at your option) any later version.                                        */
/******************************************************************************/

SECTIONS
{
    .text 0x00000000 :
    {
        *(.text)
    }

    .rodata :
    {
        . = ALIGN(4096);
        *(.rodata)
    }

    .data :
    {
        . = ALIGN(4096);
        *(.data)
    }

    .bss :
    {
        . = ALIGN(4096);
        *(.bss)
    }

    . = ALIGN(4096);
}
