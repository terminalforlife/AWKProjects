#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/awk-sort.awk
# Started On        - Thu 13 Jan 23:27:58 GMT 2022
# Last Change       - Thu 13 Jan 23:39:23 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# This is a simple demonstration of numeric sorting with AWK's own `asorti()`
# function. The positional parameters are what will be sorted, in ascending
# order.
#------------------------------------------------------------------------------

BEGIN {
	if (ARGC == 1) {
		printf("Err: Arguments required.\n")
		exit(1)
	} else if (ARGC == 2) {
		printf("Err: Invalid number of arguments.\n")
		exit(1)
	}

	for (Index = 1; Index < ARGC; Index++) {
		if (ARGV[Index] !~ /^[[:digit:]]+$/) {
			printf("Err: Argument #%d invalid.\n", Index)
			exit(1)
		}

		Args[ARGV[Index]] = 1
	}

	asorti(Args, Sorted, "@ind_num_asc")
	for (Index in Sorted) {
		print(Sorted[Index])
	}
}
