# ===== Subprojects =====

BOOTLOADER_DIR := bootloader

# ===== Targets =====

all: bootloader

bootloader:
	$(MAKE) -C $(BOOTLOADER_DIR) all copy

run:
	qemu-system-x86_64     -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd     -drive if=pflash,format=raw,file=OVMF_VARS.4m.fd     -drive format=raw,file=fat:rw:iso

# ===== Clean =====

clean:
	$(MAKE) -C $(BOOTLOADER_DIR) clean

.PHONY: all bootloader clean
