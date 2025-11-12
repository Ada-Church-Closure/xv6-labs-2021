#ifndef NIC_IFACE_H
#define NIC_IFACE_H

// E1000 register addresses
#define E1000_CTRL       0x00000  // Control Register
#define E1000_STATUS     0x00008  // Status Register
#define E1000_TDBAL      0x03800  // Transmit Descriptor Base Address Low
#define E1000_TDBAH      0x03804  // Transmit Descriptor Base Address High
#define E1000_TDLEN      0x03808  // Transmit Descriptor Length
#define E1000_TDH        0x03810  // Transmit Descriptor Head
#define E1000_TDT        0x03818  // Transmit Descriptor Tail
#define E1000_RDBAL      0x02800  // Receive Descriptor Base Address Low
#define E1000_RDBAH      0x02804  // Receive Descriptor Base Address High
#define E1000_RDLEN      0x02808  // Receive Descriptor Length
#define E1000_RDH        0x02810  // Receive Descriptor Head
#define E1000_RDT        0x02818  // Receive Descriptor Tail

// Status flags
#define E1000_STATUS_LU  0x00000002  // Link Up
#define E1000_STATUS_TXOFF 0x00000004 // Transmit Off

// Other constants
#define MAX_PACKET_SIZE  1518  // Maximum Ethernet packet size

#endif // NIC_IFACE_H