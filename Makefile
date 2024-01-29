TC   = toolchain
ARCH = mips64el-ecoff
TP   = $(TC)/bin/$(ARCH)
CC   = $(TP)-gcc
AS   = $(TP)-as
LD   = $(TP)-ld

ASFLAGS = -mips3

OBJ_FIRM=\
firmware/entry.o

firmware/%.o: b1os/%.s
	$(AS) $(ASFLAGS) $< -o $@


FIRM.BIN: $(OBJ_FIRM)
	$(LD) $(OBJ_FIRM) -o $@ -T firmware/firmware.ld
