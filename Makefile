TC   = toolchain
ARCH = mips64el-linux-gnuabi64
TP   = $(TC)/bin/$(ARCH)
CC   = $(TP)-gcc
AS   = $(TP)-as
LD   = $(TP)-ld

CFLAGS  = -std=c89 -O2 -Wall -Wextra -nostdlib -ffreestanding -fno-pic
ASFLAGS = -mips3

OBJ_FIRM=\
firmware/boot.o \
firmware/g364.o

.DEFAULT: FIRM.BIN
.PHONY: clean

firmware/%.o: firmware/%.s
	$(AS) $(ASFLAGS) $< -o $@

firmware/%.o: firmware/%.c
	$(CC) $(CFLAGS) $< -o $@

FIRM.BIN: $(OBJ_FIRM)
	$(LD) $(OBJ_FIRM) -o $@ -T firmware/firmware.ld

clean:
	rm $(OBJ_FIRM) FIRM.BIN
