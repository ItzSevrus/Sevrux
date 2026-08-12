# ===== Directories =====

SRC_DIR := src
BUILD_DIR := build

# ===== Output =====

TARGET := BOOTX64.EFI
EFI_SO := $(BUILD_DIR)/bootloader.so
BOOT_DIR := ../iso/EFI/BOOT

# ===== Compiler =====

CC := gcc
LD := ld
OBJCOPY := objcopy

# ===== GNU-EFI =====

EFI_INC := /usr/include/efi
EFI_LIB := /usr/lib

# ===== Flags =====

CFLAGS := \
	-I$(EFI_INC) \
	-I$(EFI_INC)/x86_64 \
	-ffreestanding \
	-fpic \
	-fshort-wchar \
	-fno-stack-protector \
	-mno-red-zone \
	-Wall \
	-Wextra \
	-std=gnu11

LDFLAGS := \
	-nostdlib \
	-znocombreloc \
	-T /usr/lib/elf_x86_64_efi.lds \
	$(EFI_LIB)/crt0-efi-x86_64.o \
	-L$(EFI_LIB) \
	-lefi \
	-lgnuefi

# ===== Files =====

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

# ===== Rules =====

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# ===== Link ELF =====

$(EFI_SO): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@

# ===== Convert ELF to UEFI PE/COFF =====

$(TARGET): $(EFI_SO)
	$(OBJCOPY) \
		-j .text \
		-j .sdata \
		-j .data \
		-j .rodata \
		-j .dynamic \
		-j .dynsym \
		-j .rel \
		-j .rela \
		-j .reloc \
		--output-target=efi-app-x86_64 \
		$< $@

# ===== Copy =====

copy: $(TARGET)
	mkdir -p $(BOOT_DIR)
	cp $(TARGET) $(BOOT_DIR)/$(TARGET)

# ===== Clean =====

clean:
	rm -rf $(BUILD_DIR) $(TARGET)

.PHONY: all copy clean
