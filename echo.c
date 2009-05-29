#include "license.h"

#ifdef __TINYC__
#include <tcclib.h>
#else
#ifndef __GNUC__
#include <u.h>
#include <libc.h>
#endif
#include <stdio.h>
#endif

int main(int argc, char **argv)
{
	while (--argc > 0)
		printf((argc > 1) ? "%s " : "%s\n", *++argv);
	return 0;
}
