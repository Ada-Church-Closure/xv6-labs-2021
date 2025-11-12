#!/bin/sh
# Script to run xv6 with QEMU configured for the NIC driver

# Set the path to the xv6 build directory
XV6_DIR="../.."

# Set the QEMU options
QEMU_OPTS="-nographic -smp 1 -m 512"

# Run QEMU with the xv6 kernel
qemu-system-i386 $QEMU_OPTS -kernel $XV6_DIR/kernel -hda $XV6_DIR/fs.img -append "console=ttyS0"