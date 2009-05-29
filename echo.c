#include "license.h"

#ifdef __TINYC__
# include <tcclib.h>
#else
# ifdef __GNUC__
#  include <string.h>
# endif
#endif

#include <unistd.h>

int main(int argc, char **argv)
{
	int error;
	while (--argc > 0 && ++argv) {
		error = write(1, *argv, strlen(*argv));
		if (error == -1)
			return 1;

		error = write(1, argc > 1 ? " " : "\n", 1);
		if (error == -1)
			return 1;
	}
	return 0;
}
