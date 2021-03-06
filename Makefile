GENERATOR_OUT=initrd-zfs-generator
MOUNT_OUT=mount.initrd_zfs
SHUTDOWN_OUT=zfs-shutdown
LDFLAGS=-static
CCFLAGS=-Wall -std=gnu11 -pedantic

all: mount generator shutdown

mount: $(MOUNT_OUT)

generator: $(GENERATOR_OUT)

shutdown: $(SHUTDOWN_OUT)

$(MOUNT_OUT): src/mount.initrd_zfs.c src/zfs-util.c
	$(CC) $(CCFLAGS) $(LDFLAGS) -o $@ $^

$(GENERATOR_OUT): src/zfs-generator.c src/cmdline.c
	$(CC) $(CCFLAGS) $(LDFLAGS) -o $@ $^

$(SHUTDOWN_OUT): src/zfs-shutdown.c
	$(CC) $(CCFLAGS) $(LDFLAGS) -o $@ $^

clean:
	$(RM) $(MOUNT_OUT) $(GENERATOR_OUT) $(SHUTDOWN_OUT)

.PHONY: all mount generator shutdown clean
