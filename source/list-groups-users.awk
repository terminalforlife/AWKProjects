#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/list-groups-users.awk
# Started On        - Sat 15 Jan 23:43:31 GMT 2022
# Last Change       - Sun 16 Jan 00:38:31 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Display a pretty and lightly colorized list of groups and their users, with
# group and user IDs included, and the current user name in green text so as to
# stand out.
#
# This script parses both "/etc/passwd" and "/etc/group" to get this info.
#
# The biggest problem with this script, however, is that the groups aren't
# sorted; it's a pain in AWK to sort like how I would need to properly do this.
#------------------------------------------------------------------------------

BEGIN {
	FS=":"

	while (getline < "/etc/passwd") {
		Users[$1] = $3
	}

	CurUser = ENVIRON["USER"]
	while (getline < "/etc/group") {
		printf("%s \033[2;37m(%d)\033[0m\n", $1, $3)

		Len = split($4, Split, ",")
		for (Index = 1; Index <= Len; Index++) {
			if (Split[Index] == CurUser) {
				printf("  - \033[92m%s\033[0m", Split[Index])
			} else {
				printf("  - %s", Split[Index])
			}

			printf(" \033[37m(%d)\033[0m\n", Users[Split[Index]])
		}
	}
}
