#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/get-swaps.awk
# Started On        - Wed 19 Jan 17:37:00 GMT 2022
# Last Change       - Sun 23 Jan 13:00:33 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Replicate swapo(8)'s basic functionality, in that this script will display a
# list of swap file and/or partitions in use by the system. The list is in a
# dynamically-sized table format, with human-readable sizes actually handled by
# this script.
#
# As a nice bonus, the header is in grey, so that the data stands out. This can
# be easily removed by altering the `printf()` call responsible for the header.
#
# This isn't supported by POSIX AWK or non-GNU AWK releases, due to the use of
# `length()` to get the length of an array, because screw AWK!
#
# If a swap partition or filename contains spaces, this will possibly break, -
# unless the system has other means to handle that, or spaces are forbidden.
#------------------------------------------------------------------------------

function Human(Size, Type) {
	if (Type == "Used") {
		UnitStr = "K M G T P E Z Y"
	} else {
		UnitStr = "b K M G T P E Z Y"
	}

	Len = split(UnitStr, Units, " ")
	for (Index = 1; Index < Len; Index++) {
		if (Size < 1024) {
			Result = sprintf("%.1f", Size)
			Len = length(Result)

			if (substr(Result, Len - 1) == ".0") {
				Result = substr(Result, 0, Len - 2)
			}

			if (Units[Index] == "b") {
				return(substr(Result, 0, Len - 1))
			} else {
				return(Result Units[Index])
			}
		}

		Size = Size / 1024
	}
}

BEGIN {
	if (ARGC > 1) {
		print("Err: No arguments required.")
		exit(1)
	}

	NameLenMax = 4
	TypeLenMax = 4
	SizeLenMax = 4
	UsedLenMax = 4
	PrioLenMax = 4

	NR = 0
	while (getline < "/proc/swaps") {
		if (++NR <= 1) continue

		$3 = Human($3)
		$4 = Human($4, "Used")

		NameLen = length($1)
		TypeLen = length($2)
		SizeLen = length($3)
		UsedLen = length($4)
		PrioLen = length($5)

		if (NameLen > NameLenMax) NameLenMax = NameLen
		if (TypeLen > TypeLenMax) TypeLenMax = TypeLen
		if (SizeLen > SizeLenMax) SizeLenMax = SizeLen
		if (UsedLen > UsedLenMax) UsedLenMax = UsedLen
		if (PrioLen > PrioLenMax) PrioLenMax = PrioLen

		Names[$1]["TYPE"] = $2
		Names[$1]["SIZE"] = $3
		Names[$1]["USED"] = $4
		Names[$1]["PRIO"] = $5
	}

	printf(\
		"\033[2;37m%-*s %*s %*s %*s %*s\033[0m\n", NameLenMax, "NAME",
		TypeLenMax, "TYPE", SizeLenMax, "SIZE", UsedLenMax, "USED",
		PrioLenMax, "PRIO"\
	)

	for (Name in Names) {
		printf(\
			"%-*s %*s %*s %*s %*d\n", NameLenMax, Name, TypeLenMax,
			Names[Name]["TYPE"], SizeLenMax, Names[Name]["SIZE"], UsedLenMax,
			Names[Name]["USED"], PrioLenMax, Names[Name]["PRIO"]\
		)
	}
}
