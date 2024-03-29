#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/list-mount-options.awk
# Started On        - Fri 14 Jan 22:10:23 GMT 2022
# Last Change       - Fri 14 Jan 22:15:44 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# List standard filesystem mount points and their mount options in a pretty, -
# dynamically-sized table, with minor colorization. Only currently mounted
# filesystems are shown.
#------------------------------------------------------------------------------

BEGIN {
	while (getline < "/proc/mounts") {
		if ($2 ~ /^\/.*/) Mounted[$2]
	}

	while (getline < "/etc/fstab") {
		if (substr($0, 0, 1) == "#" || $0 == "") continue

		Found = "False"
		for (Mountpoint in Mounted) {
			if (Mountpoint == $2) {
				Len = length($2)
				if (Len > MaxLen) MaxLen = Len

				Found = "True"
				break
			}
		}

		if (Found == "True") Targets[$2] = $4
	}

	Len = asorti(Targets, Sorted, "@ind_str_asc")
	for (Index = 1; Index < Len; Index++) {
		Key = Sorted[Index]

		Value = Targets[Key]
		gsub(/,/, " ", Value)

		printf("\033[37m%*s\033[0m %s\n", MaxLen, Key, Value)
	}
}
