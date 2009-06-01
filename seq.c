#include "license.h"

#ifdef __TINYC__
# include <tcclib.h>
#else
# include <stdlib.h>
# include <stdio.h>
#endif

int seq(char *separator, int first, int increment, int last);

int main(int argc, char **argv)
{
	char *separator = "\n"; /* default separator is a newline */
	int	c = 0;
	int	first = 1,
		increment = 1,
		last = 1;

	if (argc == 5)
		separator = *argv;

	while (--argc > 0 && *++argv) {
		switch (c) {
		case 1: first = last;
			break;
		case 2: increment = last;
			break;
		}
		last = atoi(*argv);
		++c;
	}

	return seq(separator, first, increment, last);
}

int seq(char *separator, int first, int increment, int last)
{
	int i;

	printf("%d", first);
	for (i = first + increment; i < last; i += increment)
		printf("%s%d", separator, i);
	if (i == last)
		printf("%s%d", separator, i);
	printf("\n");
	return 0;
}
