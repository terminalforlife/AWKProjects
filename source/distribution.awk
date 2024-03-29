#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/distribution.awk
# Started On        - Sun 16 Jan 15:11:00 GMT 2022
# Last Change       - Sun 16 Jan 17:26:49 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# An AWK-y way of displaying the distribution name and ID, at least in Ubuntu
# installations. This should come with the full codename in parentheses, but
# not all distributions use this file in the same way.
#
# This script really seems to show how flawed AWK is for simple tasks like
# this. It's a great language, but when you try to use it like a 'proper'
# language, you start to see its flaws. For example, I'm having to `exit()`
# twice just to exit once, and I'm having to use a variable just to avoid
# running all of END.
#------------------------------------------------------------------------------

BEGIN {
	FS="="

	if (ARGC > 2) {
		print("Err: One argument is required.")

		NoOp = "True"
		exit(1)
	} else if (ARGV[1] != "/etc/os-release") {
		print("Err: File '/etc/os-release' required.")

		NoOp = "True"
		exit(1)
	}
}

$1 == "NAME" {
	gsub(/"/, "", $2)
	Info[$1] = $2
}

$1 == "VERSION" {
	gsub(/"/, "", $2)
	Info[$1] = $2
}

# Saves needlessly parsing the rest of the file.
Info["NAME"] && Info["VERSION"] {
	Found = "True"
	next
}

END {
	if (NoOp != "True") {
		if (Found == "True") {
			printf("%s %s\n", Info["NAME"], Info["VERSION"])
		} else {
			print("Err: No suitable values found.")
			exit(1)
		}
	} else {
		exit(1)
	}
}
