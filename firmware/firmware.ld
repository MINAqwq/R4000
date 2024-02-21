OUTPUT_FORMAT(binary)

SECTIONS
{
	. = 0xffffffffbfc00000;
	
	.text : ALIGN(4) {
		*(.boot)
		*(.text)
	}

	.data : ALIGN(4) {
		*(data)
	}

	.bss : ALIGN(4) {
		*(bss)
	}
}
