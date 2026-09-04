/*
 * SPDX-FileCopyrightText: Copyright 2026 Arm Limited and/or its affiliates
 * SPDX-License-Identifier: MIT
 */

static void semihost_write0(const char *s)
{
	register unsigned long operation asm("x0") = 0x04;
	register const char *argument asm("x1") = s;

	/* Trap to the FVP semihosting handler. */
	asm volatile(
		"hlt #0xf000"
		: "+r"(operation)
		: "r"(argument)
		: "memory");
}

int main(void)
{
	semihost_write0("Hello from Arm bare metal!\n");

	return 0;
}
