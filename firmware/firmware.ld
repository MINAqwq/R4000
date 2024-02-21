ENTRY(_boot_entry)
OUTPUT_FORMAT(binary)

SECTIONS
{
	. = 0xffffffffbfc00000;
	
	.text : ALIGN(0x8) {
		*(.boot)
		*(.text)
	}

	.data : ALIGN(0x8) {
		*(.data)
	}

	.bss : ALIGN(0x8) {
		*(.COMMON)
		*(.bss)
		*(.sbss)
	}
}
