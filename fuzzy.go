package main

import (
	"fmt";
	"time";
	"flag";
)

var punct = flag.Bool("n", false, "Do not print trailing punctuation");

var times = []string{"", "Five", "Ten", "Quarter", "Twenty", "Twenty-five", "Half"};
var hours = []string{"twelve", "one", "two", "three", "four", "five", "six", "seven"
			"eight", "nine", "ten", "eleven"};
var capHours = []string{"Twelve", "One", "Two", "Three", "Four", "Five", "Six", "Seven"
			"Eight", "Nine", "Ten", "Eleven"};

func main() {
	flag.Parse();
	t := time.LocalTime();
	fuzzy(t.Hour, t.Minute);
}

func fuzzy(hour, min int) {
	if hour < 0 { hour = -hour; }
	if min < 0 { min = -min; }
	if min >= 60 { min %= 60; }

	for i := 0; i <= 12; i++ {
		var n, x int;

		if i <= 6 {
			n = 0
		} else {
			n = 1
		}

		x = i * 5;
		if min >= x && min < x + 3 {
			fclock(hour + n, i);
			return;
		}
	}
	return;
}

func fclock(hour, min int) {
	if hour > 11 { hour %=12 }
	if min == 0 {
		fmt.Printf("%s o'clock", capHours[hour]);
	} else {
		var n string;
		if min <= 6 {
			n = "past";
		} else {
			n = "to";
		}

		fmt.Printf("%s %s %s", times[min], n, hours[hour]);
	}

	if !*punct {
		fmt.Printf("%s", ".\n");
	}
}

