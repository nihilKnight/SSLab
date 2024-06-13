#include <stdio.h>

extern "C" void logMemoryAccess(void *addr, int isStore) {
  printf("Memory access at %p, %s\n", addr, isStore ? "store" : "load");
}

extern "C" void logLock(void *lock) {
  printf("Lock at %p\n", lock);
}

extern "C" void logUnlock(void *lock) {
  printf("Unlock at %p\n", lock);
}
