static unsigned char *g368_base = (unsigned char *)0x60080000;

void g364_init() { *(g368_base) = 0x40; }
