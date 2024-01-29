
.text

.globl _b1os_entry
_b1os_entry:
        li $8,0x4
        li $9,0x4
        add $s0, $8, $9
        j .
