#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/get-the-average.awk
# Started On        - Thu 13 Jan 22:36:21 GMT 2022
# Last Change       - Thu 13 Jan 23:23:05 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Determine the average of all numbers provided as positional parameters.
#------------------------------------------------------------------------------

BEGIN {
	if (ARGC == 1) {
		print("Err: Arguments required.")
		exit(1)
	} else if (ARGC == 2) {
		print("Err: Invalid number of arguments.")
		exit(1)
	}

	for (Index = 1; Index < ARGC; Index++) {
		if (ARGV[Index] !~ /^[.[:digit:]]+$/) {
			printf("Err: Argument #%d invalid.\n", Index)
			exit(1)
		}

		Total += ARGV[Index]
	}

	printf("Avg: %.2f\n", Total / (ARGC - 1))
}
