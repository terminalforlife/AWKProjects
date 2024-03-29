#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/shebanger.awk
# Started On        - Thu 13 Jan 22:48:58 GMT 2022
# Last Change       - Thu 13 Jan 22:51:02 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Display the shebang of each of the files provided.
#------------------------------------------------------------------------------

NR == 1 && $1 ~ /^#!/ {
	SheBang = $0
}

ENDFILE {
	printf("\033[37m%s\033[0m\n", FILENAME)

	if (length(SheBang) > 0) {
		printf("    %s\n\n", SheBang)
	} else {
		printf("    ???\n\n")
	}
}
