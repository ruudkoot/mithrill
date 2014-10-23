/******************************************************************************/
/* Mithrill : Core : Global Descriptor Table                                  */
/*                                                                            */
/* Copyright (c) 2004 - 2004  Rudy Koot                 (Mithrill Foundation) */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation; either version 2 of the License, or          */
/* (at your option) any later version.                                        */
/******************************************************************************/

/* 0 : Null *******************************************************************/
.long 0;
.long 0;

/* 1: TSS *********************************************************************/
.long 0x02802000;
.long 0xFF8089C0;

/* 2: Core Code ***************************************************************/
.long 0x0000FFFF;
.long 0x00CF9A00;

/* 3: Core Data ***************************************************************/
.long 0x0000FFFF;
.long 0x00CF9200;

/* 4: User Code ***************************************************************/
.long 0x0000FFFF;
.long 0x00CFFA00;

/* 5: User Data ***************************************************************/
.long 0x0000FFFF;
.long 0x00CFF200;

/* 6 : Null *******************************************************************/
.long 0;
.long 0;

/* 7 : Null *******************************************************************/
.long 0;
.long 0;

/******************************************************************************/
