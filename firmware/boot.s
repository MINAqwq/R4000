.align 8

.globl _boot_entry

.section .boot

_boot_entry:
        jal		g364_init				# jump to g364_init and save position to $ra
        j .

.section .bss
.align 16

_stack_end:
.skip 1024
_stack_start:
