/**/

.globl _boot_entry
.globl _boot_hlt

.section .boot

_boot_entry:
        li $s0,0x5
        li $s1,0x5
        jal _boot_add
        j .
.text

_boot_add:
        add $s2, $s0, $s1
        jr $ra
