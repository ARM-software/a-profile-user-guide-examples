/*
 * SPDX-FileCopyrightText: Copyright 2026 Arm Limited and/or its affiliates
 * SPDX-License-Identifier: MIT
 */

/* Linker script to place sections and symbol values. */

__ROM_BASE = 0x00000000;
__ROM_SIZE = 0x04000000;

__RAM_BASE = 0x04000000;
__RAM_SIZE = 0x00080000;

MEMORY
{
	ROM (rx)  : ORIGIN = __ROM_BASE, LENGTH = __ROM_SIZE
	RAM (rwx) : ORIGIN = __RAM_BASE, LENGTH = __RAM_SIZE
}

ENTRY(_start)

SECTIONS
{
	/* Read-only sections. */
	.text :
	{
		*(.text*)
	} > ROM

	.rodata :
	{
		*(.rodata .rodata.*)
	} > ROM

	/* Read-write sections. */
	.data :
	{
		. = ALIGN(8);
		__data_start = .;
		*(.data .data.*)
		. = ALIGN(8);
		__data_end = .;
	} > RAM AT > ROM
	__data_source = LOADADDR(.data);
	__data_size = __data_end - __data_start;

	.bss (NOLOAD):
	{
		. = ALIGN(8);
		__bss_start = .;
		*(.bss*)
		*(COMMON)
		. = ALIGN(8);
		__bss_end = .;
	} > RAM AT > RAM
	__bss_size = __bss_end - __bss_start;

	.heap (NOLOAD):
	{
		. = ALIGN(64);
		__heap_start = .;
		. = . + 0x4000;
		__heap_end = .;
	} > RAM AT > RAM

	.stack (NOLOAD):
	{
		. = ALIGN(64);
		. = . + 8 * 0x4000;
		__stack = .;
	} > RAM AT > RAM
}
