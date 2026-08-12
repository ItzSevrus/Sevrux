CC := gcc
LD := ld

CFLAGS := \
	-m64 \
	-ffreestanding \
	-nostdlib \
	-Wall \
	-Wextra \
	-O2

LDFLAGS := -T linker.ld

SRC := $(wildcard src/*.c)
ASM := $(wildcard src/*.S)

OBJ := $(SRC:.c=.o)
OBJ += $(ASM:.S=.o)

all: kernel.elf

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

src/%.o: src/%.S
	$(CC) $(CFLAGS) -c $< -o $@

kernel.elf: $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ) -o $@

clean:
	rm -f src/*.o kernel.elf

.PHONY: all clean
