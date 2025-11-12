CC = gcc
CFLAGS = -Wall -Iinclude
SRC = src/netif.c src/driver/nic.c
OBJ = $(SRC:.c=.o)
TARGET = xv6-nic-driver

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) -o $@ $^

clean:
	rm -f $(OBJ) $(TARGET)

.PHONY: all clean