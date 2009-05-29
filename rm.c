#include "license.h"

#include <unistd.h>

int main(int argc, char **argv)
{
	int error_count = 0;

	while (--argc > 0)
		if (unlink(*++argv) == -1)
			++error_count;
	return error_count;
}
