.section .multiboot

.align 8

.set MAGIC, 0xe85250d6
.set ARCH, 0
.set LENGTH, header_end - header_start
.set CHECKSUM, -(MAGIC + ARCH + LENGTH)

header_start:
.long MAGIC
.long ARCH
.long LENGTH
.long CHECKSUM

.short 0
.short 0
.long 8

header_end:

.section .text
.global _start
.extern kernel_main

_start:
    cli

    mov $stack_top, %rsp

    call kernel_main

1:
    hlt
    jmp 1

.section .bss

.align 16

stack_bottom:
.skip 16384

stack_top:
