#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int fuzzy(int, int);
char *get_hour(int);
char *get_time(int);
void fclock(int, int);

int punct;

int main(int argc, char **argv)
{
	if (argc > 1 && strcmp(*++argv,"-n") == 0)
		punct = 1;

	time_t now = time(NULL);
	if (now == -1)
		return 2;

	struct tm *bdt = localtime_r(&now, malloc(sizeof(struct tm)));
	if (bdt == NULL)
		return 2;

#define tm(_x) \
	int _x = bdt->tm_##_x;

	tm(hour); tm(min);
	free(bdt);

	return fuzzy(hour, min);
}

#define filter(h, l, i, o) \
	if (min >= l && min < i) { \
		fclock(hour + h, o); \
		return 0; \
	}

int fuzzy(int hour, int min)
{
	if (hour < 0)
		hour = abs(hour);
	if (min < 0)
		min = abs(min);
	if (min >= 60)
		min %= 60;

	filter(0, 0, 3, 0);
	filter(0, 3, 8, 1);
	filter(0, 8, 13, 2);
	filter(0, 13, 18, 3);
	filter(0, 18, 23, 4);
	filter(0, 23, 28, 5);
	filter(0, 28, 33, 6);
	filter(1, 33, 38, 7);
	filter(1, 38, 43, 8);
	filter(1, 43, 48, 9);
	filter(1, 48, 53, 10);
	filter(1, 53, 58, 11);
	filter(1, 58, 60, 0);

	return 1;
}

char *get_hour(int hour)
{
	char *hours[] = { "twelve", "one", "two",
		"three", "four", "five", "six",
		"seven", "eight", "nine", "ten",
		"eleven" };

	return hours[hour];
}

char *get_time(int min)
{
	char *times[] = { "", "Five", "Ten", "Quarter",
		"Twenty", "Twenty-five", "Half" };

	if (min > 11)
		min %= 12;

	if (min > 6)
		min = 12 - min;

	return times[min];
}

void fclock(int hour, int min)
{
	if (hour > 11)
		hour %= 12;

	if (min == 0)
		printf("%c%s o'clock",
			toupper(*get_hour(hour)),
			get_hour(hour) + 1);
		/* and we all know capitalisation is important */
	else
		printf("%s %s %s",
			get_time(min),
			(min > 6) ? "to" : "past",
			get_hour(hour));

	if (!punct)
		printf(".\n");
}
