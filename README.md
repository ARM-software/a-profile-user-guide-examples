<!--
SPDX-FileCopyrightText: Copyright 2005-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
SPDX-License-Identifier: MIT

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
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

# Armv9-A Architecture - User Guide Examples

## Introduction

The Arm® A-profile AArch64 architecture defines many aspects of a Cortex-A
processor's behavior. Some major architecture extension categories include:

- Exception model
- Memory management
- Interrupt handling using the Generic Interrupt Controller (GIC)
- Synchronization and multi-core coordination

To assist users in understanding the Armv9-A architecture features, a set of
user guides are developed to describe the architecture extension categories.
These user guides are written in simple language such that it is easy to learn
and help users understand the architectural features along with example
project source code (wherever applicable). The user guides also provide
details on:

- Linkage between an architecture feature and its usage in the software
- Guidelines/recommendations for software developers (Do's and Don'ts)

User guides for AArch64 architecture are available at
[Learn The Architecture - A-Profile][learn-the-architecture].

This repository contains example projects to give a practical explanation of
architecture feature usage, some of which correspond with A-profile user
guides.

These A-profile code-examples demonstrate fundamental architectural concepts
and system components through focused bare-metal programs. The examples are
intended to show how architectural features behave and how they can be
exercised in software, rather than to provide complete firmware or operating
system implementations.

For more details on Arm A-profile architecture rules and its pseudocode,
please refer to
[Arm Architecture Reference Manual Supplement for A-profile architecture][arm-arm]
and associated
[A-Profile Architecture content on developer.arm.com][a-profile-architecture].

## Project Structure

The example software projects are organized as individual, self-contained
demonstrations, each focusing on a specific architectural concept or system
component.

<!-- markdownlint-disable MD013 -->
| Architecture category | User Guide | Chapter(s) | Folder name |
| --------------------- | --------------- | ---------- | ----------------- |
| Bare-metal boot | [A-Profile Bare-Metal Boot Guide](https://developer.arm.com/documentation/112165/latest/) | Chapter 5: Placing software for boot<br>Chapter 6: Choosing the primary PE | [bare-metal-boot-examples_ATfE/](bare-metal-boot-examples_ATfE/) |
<!-- markdownlint-enable MD013 -->

Each example includes its own `README.md` with details on:

- The architectural concepts being demonstrated
- Build and run instructions
- Platform or configuration requirements
- Expected outputs

## Additional Notes

- The example projects are developed to demonstrate architectural concepts and
  features. These example projects should not be used as a test to validate all
  aspects of a feature.
- The example projects may be built with Arm Compiler 6, GCC tool chain, or Arm
  Toolchain for Embedded (ATfE).  This will be indicated by the folder name.
  Refer to the individual example project's README file for necessary settings.
- The tool chain version details are captured in each example project's
  README.md file. Though the example may work using other versions of a tool
  chain, it may not be verified.

## License

Example projects are licensed under the MIT license. Please see [LICENSE](LICENSE).

## Feedback and Support

- For feedback and support on these example projects, use the GitHub
  [Issue Tracker](https://github.com/ARM-software/a-profile-user-guide-examples/issues)
  that is associated with this repository.
- For support on Armv A-profile architecture features, follow the
  [Arm Community architectures and processors forum][arm-community] using the
  Cortex-A tag where relevant.
- Arm licensees may contact Arm directly through their partner managers.

----

Copyright 2022-2026 Arm Limited and/or its affiliates

[a-profile-architecture]: https://developer.arm.com/Architectures/A-Profile%20Architecture
[arm-arm]: https://developer.arm.com/documentation/ddi0487/latest/
[arm-community]: https://community.arm.com/support-forums/f/architectures-and-processors-forum
[learn-the-architecture]: https://www.arm.com/architecture/learn-the-architecture/a-profile
