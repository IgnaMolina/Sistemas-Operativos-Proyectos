CC := gcc
CFLAGS := -O0 -std=gnu11 -Wall -Werror -Wno-unused-parameter -g $(shell pkg-config --cflags glib-2.0)
LDFLAGS := $(shell pkg-config --libs glib-2.0)

# Include path for audit.h
INCLUDES := -I../

all: audit_reader restore

audit_reader: audit_reader.c
	$(CC) $(CFLAGS) $(INCLUDES) -o $@ $< $(LDFLAGS)

restore: restore.c
	$(CC) $(CFLAGS) $(INCLUDES) -o $@ $< $(LDFLAGS)

clean:
	rm -f audit_reader restore

.PHONY: all clean