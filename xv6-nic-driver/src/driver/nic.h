#ifndef NIC_H
#define NIC_H

#include <stdint.h>

#define NIC_RX_BUFFER_SIZE 2048
#define NIC_TX_BUFFER_SIZE 2048

typedef struct {
    uint8_t data[NIC_RX_BUFFER_SIZE];
    uint32_t length;
} nic_rx_packet_t;

typedef struct {
    uint8_t data[NIC_TX_BUFFER_SIZE];
    uint32_t length;
} nic_tx_packet_t;

void nic_init(void);
int e1000_transmit(nic_tx_packet_t *packet);
int e1000_recv(nic_rx_packet_t *packet);

#endif // NIC_H