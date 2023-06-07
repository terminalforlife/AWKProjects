#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/bubble-sort.awk
# Started On        - Thu 13 Jan 22:54:38 GMT 2022
# Last Change       - Thu 18 May 03:17:26 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Sort argument numbers (ascending) with Bubble Sort algorithm in AWK.
#------------------------------------------------------------------------------

BEGIN {
	delete ARGV[0]
	if (ARGC <= 2) {
		printf("Err: Arguments required.\n")
		exit(1)
	}

	for (Index = 1; Index < ARGC; Index++) {
		if (ARGV[Index] !~ /^[[:digit:]]+$/) {
			printf("Err: Argument '%s' invalid.\n", ARGV[Index])
			ArgErr++
		}
	}

	if (ArgErr > 0) exit(1)

	for (Iter = 0; Iter < ARGC; Iter++) {
		Switched = "False"
		for (Index = 1; Index < ARGC - (1 + Iter); Index++) {
			if (ARGV[Index] > ARGV[Index + 1]) {
				Temp = ARGV[Index]
				ARGV[Index] = ARGV[Index + 1]
				ARGV[Index + 1] = Temp

				Switched = "True"
			}
		}

		if (Switched == "False") break
	}

	for (Index = 1; Index < ARGC; Index++) {
		print(ARGV[Index])
	}
}
