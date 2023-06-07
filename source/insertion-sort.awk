#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/insertion-sort.awk
# Started On        - Thu 18 May 03:09:28 BST 2023
# Last Change       - Thu 18 May 03:20:18 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Sort argument numbers (ascending) with Insertion Sort algorithm in AWK.
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

	for (Index = 1; Index < ARGC; Index++) {
		Cur = ARGV[Index]
		Pos = Index

		while (Pos > 0 && ARGV[Pos - 1] > Cur) {
			ARGV[Pos--] = ARGV[Pos - 1]
		}

		ARGV[Pos] = Cur
	}

	for (Index = 1; Index < ARGC; Index++) {
		print(ARGV[Index])
	}
}
