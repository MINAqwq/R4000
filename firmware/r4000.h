/* Magnum R4000 BIOS */

/* =================== TYPES =================== */

typedef signed char  int8;
typedef signed short int16;
typedef signed int   int32;
typedef signed long  int64;

typedef unsigned char  uint8;
typedef unsigned short uint16;
typedef unsigned int   uint32;
typedef unsigned long  uint64;
typedef unsigned int   uint;

typedef unsigned char boolean;

/* ================ R/W FUNCTIONS =============== */

/* read a byte (8 bit) from addr */
#define read_b(addr) *((uint8 *)addr)

/* write a byte (8 bit) to addr */
#define write_b(addr, val) *((uint8 *)addr) = (uint8)val;

/* =================== NVRAM =================== */

#define NVRAM_ADDRESS_BASE 0x80009000

/* ================= SERIAL AT ================= */

#define SERIAL_REG_DATA		0 /* data register */
#define SERIAL_REG_DIV_LSB	0 /* lsb of baud rate divisor value */
#define SERIAL_REG_INT		1 /* interrupts enable register */
#define SERIAL_REG_DIV_MSB	1 /* msb of baud rate divisor value */
#define SERIAL_REG_FIFO_CTRL	2 /* fifo control register */
#define SERIAL_REG_LINE_CTRL	3 /* line control register */
#define SERIAL_REG_MODEM_CTRL	4 /* modem control register */
#define SERIAL_REG_LINE_STATUS	5 /* line status register */
#define SERIAL_REG_MODEM_STATUS 6 /* modem status register */
#define SERIAL_REG_SCRATCH	7 /* scratch register */

#define SERIAL_COM_0 0x80006000

/* init serial port (returns 0 on success) */
boolean serial_init(uint port);

/* write a byte to serial port */
void serial_write(uint port, uint8 val);

/* read a byte from serial port */
uint8 serial_read(uint port);

/* return true if DR (data ready) is set */
boolean serial_received(uint port);

/* return true if transmitter is ready to send data */
boolean serial_ready(uint port);
