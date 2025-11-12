#ifndef NETIF_H
#define NETIF_H

// Function prototypes for network interface operations
void netif_init(void);
int netif_send(const void *data, int len);
int netif_recv(void *buffer, int len);

#endif // NETIF_H