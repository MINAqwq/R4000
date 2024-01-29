qemu-system-mips64el \
        -machine magnum \
        -cpu R4000 \
        -m 128 \
        -net nic \
        -net user \
        -global ds1225y.filename=nvram \
        -bios FIRM.BIN