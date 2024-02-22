ENTRY(_boot_entry)
OUTPUT_FORMAT(binary)

SECTIONS
{
	. = 0xffffffffbfc00000;

	.text : ALIGN(16)
	{
		*(.text)
	}
 
	.rodata : ALIGN(16)
	{
		*(.rodata)
	}
 
	.data : ALIGN(16)
	{
		*(.data)
	}

	.bss : ALIGN(16)
	{
		*(COMMON)
		*(.bss)
		*(.sbss)
		*(PROGBITS)
	}

}
