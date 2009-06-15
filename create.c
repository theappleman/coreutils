#include "license.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <linux/limits.h>
#include <fcntl.h>
#include <stdio.h>

int main(int argc, char **argv)
{
	while (--argc > 0 && *++argv)
		if (strlen(*argv) <= PATH_MAX)
			creat(*argv, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
		/* ignore any other errors */

	/* read stdin, one file per line */
	char path[PATH_MAX];
	while (scanf("%s\n", &path) == 1 && strlen(path) <= PATH_MAX)
		creat(path, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

	return 0;
}
