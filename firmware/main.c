#include "r4000.h"

/* high level bios entry */
void
bios_start()
{
	/* init com 0 */
	serial_init(SERIAL_COM_0);

	serial_write(SERIAL_COM_0, 'A');
	serial_write(SERIAL_COM_0, 10);
}
