# SPDX-FileCopyrightText: Copyright 2005-2026 Arm Limited and/or its
# affiliates <open-source-office@arm.com>
# SPDX-License-Identifier: MIT
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

# This example is intended to be built with Arm Toolchain for Embedded.

EXECUTABLE=hello.elf

CC=clang
AS=clang
LD=clang

TARGET_FLAGS=--target=aarch64-none-elf -mno-unaligned-access -ffreestanding
ASFLAGS=$(TARGET_FLAGS) -g
CFLAGS=$(ASFLAGS)
LDFLAGS=$(CFLAGS) -nostdlib -T linker.ld

FVP_MODEL ?= FVP_Base_AEMvA
FVP_PARAMS = -C bp.secure_memory=false

OBJFILES=startup.o hello.o

ifdef WINDIR
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(WINDIR)\system32\cmd.exe
else
ifdef windir
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(windir)\system32\cmd.exe
else
DONE=@if [ -f $(1) ]; then echo Build completed.; fi
RM=rm -f $(1)
endif
endif

.PHONY: all clean rebuild run

all: $(EXECUTABLE)
	$(call DONE,$(EXECUTABLE))

rebuild: clean all

run: all
	$(FVP_MODEL) $(FVP_PARAMS) $(EXECUTABLE)

clean:
	$(call RM,*.o)
	$(call RM,$(EXECUTABLE))

startup.o: startup.S
	$(AS) $(ASFLAGS) -c startup.S -o $@

hello.o: hello.c
	$(CC) $(CFLAGS) -c hello.c -o $@

$(EXECUTABLE): $(OBJFILES) linker.ld
	$(LD) $(OBJFILES) $(LDFLAGS) -o $@
