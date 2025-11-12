#include <stdio.h>
#include <stdlib.h>
#include "nic.h"

void test_transmit() {
    char *packet = "Test packet data";
    int result = e1000_transmit(packet, strlen(packet));
    if (result == 0) {
        printf("Transmit test passed.\n");
    } else {
        printf("Transmit test failed with error code: %d\n", result);
    }
}

void test_receive() {
    char buffer[256];
    int result = e1000_recv(buffer, sizeof(buffer));
    if (result > 0) {
        printf("Receive test passed. Received data: %s\n", buffer);
    } else {
        printf("Receive test failed with error code: %d\n", result);
    }
}

int main() {
    printf("Starting NIC driver functional tests...\n");
    
    test_transmit();
    test_receive();
    
    printf("NIC driver functional tests completed.\n");
    return 0;
}