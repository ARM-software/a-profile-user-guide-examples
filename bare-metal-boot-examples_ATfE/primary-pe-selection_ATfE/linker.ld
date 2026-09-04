/*
 * SPDX-FileCopyrightText: Copyright 2026 Arm Limited and/or its affiliates
 * SPDX-License-Identifier: MIT
 */

MEMORY
{
	ROM (rx)  : ORIGIN = 0x00000000, LENGTH = 64M
	RAM (rwx) : ORIGIN = 0x04000000, LENGTH = 512K
}

ENTRY(_start)

SECTIONS
{
	/* Place code and read-only data in ROM. */
	.text 0x00000000 :
	{
		KEEP(*(.text._start))
		*(.text*)
		*(.rodata*)
	} > ROM

	.data :
	{
		. = ALIGN(8);
		__data_start = .;
		*(.data*)
		. = ALIGN(8);
		__data_end = .;
	} > RAM AT > ROM
	__data_source = LOADADDR(.data);
	__data_size = __data_end - __data_start;

	.bss (NOLOAD) :
	{
		. = ALIGN(8);
		__bss_start = .;
		*(.bss*)
		*(COMMON)
		. = ALIGN(8);
		__bss_end = .;
	} > RAM
	__bss_size = __bss_end - __bss_start;

	.heap (NOLOAD) :
	{
		. = ALIGN(16);
		__heap_start = .;
		_end = __heap_start;
		end = __heap_start;
		. = . + 0x4000;
		. = ALIGN(16);
		__heap_end = .;
		__llvm_libc_heap_limit = __heap_end;
	} > RAM

	.stack (NOLOAD) :
	{
		. = ALIGN(16);
		. = . + 0x4000;
		__stack = .;
	} > RAM
}
