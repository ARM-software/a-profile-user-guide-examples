/*
 * SPDX-FileCopyrightText: Copyright 2026 Arm Limited and/or its affiliates
 * SPDX-License-Identifier: MIT
 */

.global _start
.type _start, %function

_start:
	/* Continue only if the full affinity is 0.0.0.0. */
	mrs	x0, MPIDR_EL1
	ubfx	x1, x0, #32, #8
	and	x0, x0, #0xffffff
	orr	x0, x0, x1
	cbz	x0, primary_pe

secondary_wait:
	wfe
	b	secondary_wait

primary_pe:
	/* Set the stack pointer before calling C code. */
	ldr	x0, =__stack
	mov	sp, x0

	/* Copy the RW .data from ROM to RAM. */
	ldr	x0, =__data_start
	ldr	x1, =__data_source
	ldr	x2, =__data_end

	cmp	x0, x2
	b.eq	copy_done

copy_start:
	ldrb	w3, [x1], #1
	strb	w3, [x0], #1
	cmp	x0, x2
	b.ne	copy_start

copy_done:
	/* Zero the ZI .bss. */
	ldr	x0, =__bss_start
	ldr	x1, =__bss_end

	cmp	x0, x1
	b.eq	zero_done

zero_start:
	strb	wzr, [x0], #1
	cmp	x0, x1
	b.ne	zero_start

zero_done:
	bl	main

	/* Exit the model through semihosting. */
	mov	x0, #0x18
	mov	x1, #0
	hlt	#0xf000

1:
	/* Wait if execution continues after the exit call. */
	wfe
	b	1b
