#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/os-release.awk
# Started On        - Mon 26 Jun 19:53:43 BST 2023
# Last Change       - Mon 26 Jun 20:20:31 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Dynamically-sized table of the contents of '/etc/os-release'. A demonstration
# of `getline` and reading from a file within a `BEGIN` block. The information
# isn't terrible to have, either.
#
# Mostly, I was just bored.
#------------------------------------------------------------------------------

BEGIN {
	printf("Scanning '" "/etc/os-release" "' ...\n\n")

	MaxLen = 0
	while (getline < "/etc/os-release") {
		split($0, KeyVal, "=")

		Len = length(KeyVal[1])
		if (Len > MaxLen) MaxLen = Len

		Keys[KeyVal[1]] = KeyVal[2]
	}

	for (Key in Keys) {
		Value = Keys[Key]
		ValueLen = length(Value)
		LeftChar = substr(Value, 1, 1)
		RightChar = substr(Value, ValueLen)
		if (LeftChar == "\"" && RightChar == "\"") {
			Value = substr(Value, 2, ValueLen - 2)
		}

		printf("\033[37m%*s\033[0m %-s\n", MaxLen, Key, Value)
	}
}
