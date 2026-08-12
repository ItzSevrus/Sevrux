#include <stdint.h>

volatile uint16_t *vga = (uint16_t *)0xB8000;

void print(const char *str) {
  static int pos = 0;

  while (*str) {
    vga[pos++] = (0x0F << 8) | *str++;
  }
}

void kernel_main(void) {
  print("Welcome to Sevrux!");

  while (1)
    __asm__ volatile("hlt");
}
