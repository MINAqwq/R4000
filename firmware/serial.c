#include "r4000.h"

boolean
serial_init(uint port)
{
	/* to be sure dlab is disabled */
	write_b(port + SERIAL_REG_LINE_CTRL, 0x00);

	/* disable all interrupts */
	write_b(port + SERIAL_REG_INT, 0x00);

	/* enable dlab */
	write_b(port + SERIAL_REG_LINE_CTRL, 0x80);

	/* set baud rate divisor */
	write_b(port + SERIAL_REG_DIV_LSB, 0x03);
	write_b(port + SERIAL_REG_DIV_MSB, 0x00);

	/* clear dlab, configure line protocol with 8 bits, no parity, one stop
	 * bit */
	write_b(port + SERIAL_REG_LINE_CTRL, 0x03);

	/* enable fifo, clear them, with 14 byte threshold */
	write_b(port + SERIAL_REG_FIFO_CTRL, 0xC7);

	/* irq enable, trs/dsr set */
	write_b(port + SERIAL_REG_MODEM_CTRL, 0x1E);

	/* set in loopback mode */
	write_b(port + SERIAL_REG_MODEM_CTRL, 0xAE);

	/* check if serial is faulty */
	if (read_b(port + SERIAL_REG_DATA) != 0xAE) {
		return 1;
	}

	/* set back to normal operation mode */

	write_b(port + SERIAL_REG_MODEM_CTRL, 0x0F);
	return 0;
}

void
serial_write(uint port, uint8 val)
{
	/* wait for transmitter to be ready */
	while (!serial_ready(port)) {
	}

	/* write data to serial port */
	write_b(port + SERIAL_REG_DATA, val);
}

uint8
serial_read(uint port)
{
	/* wait for data to receive */
	while (!serial_received(port)) {
	}

	/* read in data from serial port */
	return read_b(port + SERIAL_REG_DATA);
}

boolean
serial_received(uint port)
{
	/* read from DR */
	return read_b(port + SERIAL_REG_LINE_STATUS) & 1;
}

boolean
serial_ready(uint port)
{
	/* read THRE and TEMT */
	return read_b(port + SERIAL_REG_LINE_STATUS) & 0x60;
}
