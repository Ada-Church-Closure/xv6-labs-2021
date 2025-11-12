#include "netif.h"
#include "nic.h"

void netif_init() {
    // Initialize the NIC driver
    nic_init();
}

int netif_send(void *data, int len) {
    // Send a packet using the NIC driver
    return nic_transmit(data, len);
}

int netif_recv(void *buffer, int buffer_len) {
    // Receive a packet using the NIC driver
    return nic_receive(buffer, buffer_len);
}