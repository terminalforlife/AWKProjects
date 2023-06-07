#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/revfile.awk
# Started On        - Fri 19 May 00:46:37 BST 2023
# Last Change       - Fri 19 May 01:01:08 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Display the contents of a text file in reverse using AWK, because why not?
# This is POSIX-compliant, accordingly to AWK and awk(1posix). Includes cat(1)
# style line numbering.
#------------------------------------------------------------------------------

{
	Line = ""
	for (Char = length($0); Char > 0; Char--) {
		Line = Line substr($0, Char, 1)
	}

	printf("%6d  %s\n", NR, Line)
}
