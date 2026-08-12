ISO = sevrux.iso

all:
	$(MAKE) -C kernel

	mkdir -p iso/boot

	cp kernel/kernel.elf iso/boot/

	grub-mkrescue -o $(ISO) iso

run: all
	qemu-system-x86_64 -cdrom $(ISO)

clean:
	$(MAKE) -C kernel clean
	rm -f $(ISO)
	rm -f iso/boot/kernel.elf
