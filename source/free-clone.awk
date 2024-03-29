#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/free-clone.awk
# Started On        - Thu 20 Jan 01:29:43 GMT 2022
# Last Change       - Sun 23 Jan 12:57:30 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# An AWK version of the base functionality of free(1), with human-readable
# sizes by default. There is a slight discrepancy, with some values, but only
# a minor amounts, and I have adhered to the free(1) man page.
#------------------------------------------------------------------------------

function Human(Size, Type) {
	if (Type == "Swap") {
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
	FS = ":"

	while (getline < "/proc/meminfo") {
		sub(/^[[:space:]]+/, "", $2)
		sub(/[[:space:]]+kB$/, "", $2)
		Data[$1] = $2
	}

	printf(\
		"%-8s %10s %11s %11s %11s %11s %11s\n", "", "total",
		"used", "free", "shared", "buff/cache", "available"\
	)

	# As described by free(1).
	Total = Data["MemTotal"]
	BuffCache = Data["Buffers"] + Data["Cached"] + Data["SReclaimable"]
	Used = Total - Data["MemFree"] - BuffCache
	Free = Data["MemFree"]
	Shared = Data["Shmem"]
	Avail = Data["MemAvailable"]
	SwapTotal = Data["SwapTotal"]
	SwapFree = Data["SwapFree"]
	SwapUsed = SwapTotal - SwapFree

	printf(\
		"%-8s %10s %11s %11s %11s %11s %11s\n", "Mem:",
		Human(Total), Human(Used), Human(Free), Human(Shared),
		Human(BuffCache), Human(Avail)\
	)

	printf(\
		"%-8s %10s %11s %11s\n", "Swap:",
		Human(SwapTotal), Human(SwapUsed, "Swap"), Human(SwapFree)\
	)
}
