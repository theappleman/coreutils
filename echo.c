#include "license.h"

#ifdef __TINYC__
# include <tcclib.h>
#else
# include <string.h>
#endif

#include <unistd.h>

int main(int argc, char **argv)
{
	while (--argc > 0 && *++argv) {
		if (write(1, *argv, strlen(*argv)) == -1 ||
			write(1, argc > 1 ? " " : "\n", 1) == -1)
			return 1;
	}
	return 0;
}
