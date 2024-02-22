.align 8

.globl _boot_entry

.section .bss

_stack_end:
.skip 1024
_stack_start:

.text

_boot_entry:
        # setup stack
        li $sp, _stack_start

        # jump to high level bios
        jal bios_start

        li $v0, 0xFAF0
        nop
        j .
