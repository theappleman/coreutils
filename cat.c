#include "license.h"

#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#define O_RDONLY 00 /* from bits/fcntl.h */

#ifndef BUFSIZ
# define BUFSIZ 8192
#endif

void cat_file(char *);

int main(int argc, char **argv)
{
	if (argc == 1)
		cat_file("-");
	else
		while (--argc > 0)
			cat_file(*++argv);
	return 0;
}

void cat_file(char *fname)
{
	int fd = 0; /* stdin default */
	char buffer[BUFSIZ];
	int n;

	if (strcmp("-", fname) && (fd = open(fname, O_RDONLY)) == -1)
			return;
	while ((n = read(fd, buffer, BUFSIZ)) > 0)
		write(1, buffer, n);
	if (fd)
		close(fd);
	/* TODO: bother checking the return code */
}
