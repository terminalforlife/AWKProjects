#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/fetch-users.awk
# Started On        - Fri 14 Jan 14:30:02 GMT 2022
# Last Change       - Thu 20 Jan 00:42:39 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# List the username, UID, and GID of non-system users found in '/etc/passwd'.
#------------------------------------------------------------------------------

BEGIN {
	FS=":"

	MaxLenUser = 4;
	MaxLenUID = 3;
	MaxLenGID = 3;
	while (getline < "/etc/passwd") {
		if ($3 < 1000 || $3 == 65534) continue

		LenUser = length($1);
		LenUID = length($3);
		LenGID = length($4);

		if (LenUser > MaxLenUser) MaxLenUser = LenUser;
		if (LenUID > MaxLenUID) MaxLenUID = LenUID;
		if (LenGID > MaxLenGID) MaxLenGID = LenGID;

		Users[$1][UID] = $3;
		Users[$1][GID] = $4
	}

	printf(\
		"%-*s %*s %*s\n", MaxLenUser, "USER",
		MaxLenUID, "UID", MaxLenGID, "GID"\
	)

	for (User in Users) {
		printf(\
			"%-*s %*d %*d\n", MaxLenUser, User, MaxLenUID,
			Users[User][UID], MaxLenGID, Users[User][GID]\
		)
	}
}
