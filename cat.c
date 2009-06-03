#include "license.h"

#include <unistd.h>
#define O_RDONLY 00 /* from bits/fcntl.h */

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
	char buffer[1024] = "";
	if (strcmp("-", fname) && (fd = open(fname, O_RDONLY)) == -1)
			return;
	while (read(fd, &buffer, 1024) > 0)
		write(1, buffer, 1024);
	if (fd)
		close(fd);
	/* TODO: bother checking the return code */
}
