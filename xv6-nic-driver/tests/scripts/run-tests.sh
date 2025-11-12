#!/bin/bash

# This script automates the process of running the functional tests for the NIC driver.

# Set up the environment
echo "Setting up the environment for NIC driver tests..."

# Compile the functional tests
echo "Compiling functional tests..."
gcc -o netlab ../functional/netlab.c -I../../include -L../../src -lnic

# Run the tests
echo "Running functional tests..."
./netlab

# Check the result of the tests
if [ $? -eq 0 ]; then
    echo "All tests passed successfully!"
else
    echo "Some tests failed. Please check the output for details."
fi

# Clean up
echo "Cleaning up..."
rm netlab

echo "Test run completed."