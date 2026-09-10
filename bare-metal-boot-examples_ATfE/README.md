<!--
SPDX-FileCopyrightText: Copyright 2005-2026 Arm Limited and/or its
affiliates <open-source-office@arm.com>
SPDX-License-Identifier: MIT

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->

# Bare-metal Boot Examples

## Introduction

These examples accompany the
[A Profile Bare-Metal Boot Guide](https://developer.arm.com/documentation/112165/latest/)
for systems based on the Armv8-A and Armv9-A architectures. The guide explains
the first steps that a system takes after reset, from fetching the first
instruction at the reset vector to reaching a minimal `main()` function.

The examples are educational. They show reset handling, image placement,
semihosting output, and simple primary PE selection on the `FVP_Base_AEMvA`
model.

## Where These Examples Fit in the Guide

The guide introduces the boot flow in small stages, and each example supports
one of those stages.

* `boot-image-placement_ATfE` supports the "Placing software for boot"
  chapter. It places startup code at the FVP reset vector address, initializes
  writable data and zero-initialized data, sets up a stack, and calls `main()`.
  Because the FVP starts four PEs by default, the message is printed four
  times.
* `primary-pe-selection_ATfE` supports the "Choosing the primary PE" chapter.
  It extends the reset handler so that only the PE with full affinity
  `0.0.0.0` continues to `main()`. Secondary PEs wait in a `wfe` (wait for
  event) loop.

## Overview

Both examples build a freestanding AArch64 ELF image for the
`FVP_Base_AEMvA` model.

The examples share the same basic application code. The difference is in the
reset handler, `startup.S`:

* `boot-image-placement_ATfE` lets every PE reach `main()`.
* `primary-pe-selection_ATfE` selects one primary PE before runtime
  initialization and keeps the other PEs waiting.

The examples use direct semihosting calls for output instead of `printf()`. A
direct semihosting call needs only a few instructions in the example code. By
contrast, `printf()` can require extra library code and runtime setup that
would distract from the early boot steps that the guide is explaining.

## Requirements

* Arm Development Studio 2025 command prompt, or an equivalent command-line
  environment.
* Arm Toolchain for Embedded, including `clang` for the `aarch64-none-elf`
  target.
  * This toolchain is included with Arm Development Studio and can be selected
    for the current terminal session by running the `select_toolchain.bat`
    script from the Arm Development Studio command prompt.
* Arm Fixed Virtual Platform (FVP) with the `FVP_Base_AEMvA` model.
  * The FVP is also included with Arm Development Studio.

The examples target the `FVP_Base_AEMvA` model. To run them on a different
target, adapt the memory map, reset address, PE startup behavior, and output
mechanism.

Note: If you are not using the Arm Development Studio command prompt, `make`,
`clang`, and `FVP_Base_AEMvA` must be available on your system `PATH`. Arm
Development Studio includes `make.exe`.

## Structure

The folder contains two example projects.

```
bare-metal-boot-examples_ATfE/
|-> README.md
|
|-> boot-image-placement_ATfE/
|   |-> startup.S        AArch64 reset handler for all PEs
|   |-> hello.c          Minimal semihosting application
|   |-> linker.ld        Linker script for ROM and RAM placement
|
|-> primary-pe-selection_ATfE/
|   |-> startup.S        Reset handler with primary PE selection
|   |-> hello.c          Minimal semihosting application
|   |-> linker.ld        Linker script for ROM and RAM placement
```

Build output files, such as `startup.o`, `hello.o`, and `hello.elf`, can
appear in each example directory after building.

## Building the Examples from the Command Prompt

Run the build commands from the directory for the example that you want to
build.

Each example includes a Makefile. From the example directory, run:

```sh
make
```

This command builds `hello.elf`. You can also use the other Makefile targets:

* `make run` builds `hello.elf`, then runs it on `FVP_Base_AEMvA`.
* `make clean` removes generated build output files.
* `make rebuild` removes generated build output files, then rebuilds
  `hello.elf`.

The following commands show the equivalent manual `clang` build steps.

In `boot-image-placement_ATfE`, run:

```sh
clang --target=aarch64-none-elf -mno-unaligned-access -ffreestanding \
	-c -g startup.S -o startup.o
clang --target=aarch64-none-elf -mno-unaligned-access -ffreestanding \
	-c -g hello.c -o hello.o
clang startup.o hello.o --target=aarch64-none-elf -nostdlib -g \
	-T linker.ld -o hello.elf
```

In `primary-pe-selection_ATfE`, run:

```sh
clang --target=aarch64-none-elf -mno-unaligned-access -ffreestanding \
	-c -g startup.S -o startup.o
clang --target=aarch64-none-elf -mno-unaligned-access -ffreestanding \
	-c -g hello.c -o hello.o
clang startup.o hello.o --target=aarch64-none-elf -nostdlib -g \
	-T linker.ld -o hello.elf
```

## Running the Model

Run each command from the directory that contains the `hello.elf` file for
that example. You can also run the model by using the `make run` target.

For `boot-image-placement_ATfE`, run:

```sh
FVP_Base_AEMvA -C bp.secure_memory=false hello.elf
```

For `primary-pe-selection_ATfE`, run:

```sh
FVP_Base_AEMvA -C bp.secure_memory=false hello.elf
```

By default, `FVP_Base_AEMvA` starts 4 PEs. Use the
`-C cluster0.NUM_CORES=<number>` option to set a different number of PEs. For
example, `-C cluster0.NUM_CORES=3` starts 3 PEs.

## Expected Output

For `boot-image-placement_ATfE`, the output should include four messages
because the FVP starts four PEs by default:

```
Hello from Arm bare metal!
Hello from Arm bare metal!
Hello from Arm bare metal!
Hello from Arm bare metal!
```

For `primary-pe-selection_ATfE`, the output should include one message from
the primary PE:

```
Hello from Arm bare metal!
```

## Additional Considerations

* These examples are not complete boot firmware. They omit many features that
  production software requires, including a full C runtime and libraries,
  memory management, cache setup, interrupt handling, and Exception level
  transitions.
* The `boot-image-placement_ATfE` example prints once per PE because each PE
  reaches `main()`. This behavior is expected and motivates the primary PE
  selection step.
* The `primary-pe-selection_ATfE` example selects the PE with full affinity
  `0.0.0.0`. Affinity field meanings are platform-specific, so different
  systems might need different selection logic.
* If the model does not terminate automatically after the semihosting exit
  call, stop the simulation manually.

## License

Example projects are licensed under the MIT license. Please see the
[LICENSE](../LICENSE).
