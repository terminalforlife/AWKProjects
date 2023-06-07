#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/list-core-utils.awk
# Started On        - Sun 16 Jan 17:20:46 GMT 2022
# Last Change       - Sun 16 Jan 17:26:10 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Provides a sorted (ascending) and unique list of executables found in
# Debian package 'coreutils', whether they're actually present or not. The
# utilities must use the current user's PATH in order to be listed.
#
# This is a nice demonstration of using a user-defined function in AWK, getting
# the last element of an array, making use of the special `ENVIRON` variable, -
# to access environment variables, and sorting the result.
#
# This of course requires access to the file this script parses.
#------------------------------------------------------------------------------

function Basename(Path, _Len, _PathArr) {
	_Len = split(Path, _PathArr, "/")

	return(_PathArr[_Len])
}

BEGIN {
	Len = split(ENVIRON["PATH"], PathDirs, ":")
	while (getline < "/var/lib/dpkg/info/coreutils.list") {
		for (Index = 1; Index < Len; Index++) {
			if ($0 ~ "^" PathDirs[Index] "/") {
				Execs[Basename($0)]

				break
			}
		}
	}

	Len = asorti(Execs, Sorted, "@ind_str_asc")
	for (Index = 1; Index <= Len; Index++) {
		print(Sorted[Index])
	}
}
