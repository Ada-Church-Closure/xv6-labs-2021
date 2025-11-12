# xv6 NIC Driver

This project implements a network interface card (NIC) driver for the xv6 operating system as part of the networking lab. The driver is designed to interface with the E1000 hardware and provides essential functionalities for packet transmission and reception.

## Project Structure

- **src/driver/nic.c**: Implementation of the NIC driver, including initialization, packet transmission (`e1000_transmit`), and packet reception (`e1000_recv`).
- **src/driver/nic.h**: Header file defining the NIC driver's interface and data structures for packet handling.
- **src/netif.c**: Implements network interface functions that interact with the NIC driver for higher-level network operations.
- **src/netif.h**: Header file for network interface functions, including initialization and packet processing.
- **include/nic_iface.h**: Contains definitions and constants related to the NIC interface, including register addresses and status flags for the E1000.
- **patches/patch-xv6-add-nic.diff**: Patch for integrating the NIC driver into the xv6 source code, modifying existing files as necessary.
- **tests/functional/netlab.c**: Functional tests for the NIC driver, ensuring correct packet transmission and reception.
- **tests/scripts/run-tests.sh**: Script to automate the execution of functional tests defined in `netlab.c`.
- **qemu/qemu-run.sh**: Script to run the xv6 operating system with QEMU, configured to use the NIC driver.
- **docs/design.md**: Documentation outlining design decisions, architecture diagrams, and explanations of driver components.
- **Makefile**: Build instructions for compiling the source files and linking them into the final executable.
- **.gitignore**: Specifies files and directories to be ignored by Git.

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   cd xv6-nic-driver
   ```

2. Apply the patch to the xv6 source code:
   ```
   patch -p1 < patches/patch-xv6-add-nic.diff
   ```

3. Build the project:
   ```
   make
   ```

4. Run the xv6 operating system with the NIC driver:
   ```
   ./qemu/qemu-run.sh
   ```

## Usage

Once the xv6 operating system is running, you can use the NIC driver to send and receive packets. Refer to the functional tests in `tests/functional/netlab.c` for examples of how to interact with the driver.

## Overview

The NIC driver is a crucial component for enabling networking capabilities in the xv6 operating system. It provides a low-level interface to the E1000 hardware, allowing for efficient packet processing and communication over a network.