#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/list-deb-pkgs.awk
# Started On        - Thu 13 Jan 23:43:11 GMT 2022
# Last Change       - Fri 14 Jan 00:18:50 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# List installed Ubuntu/Debian (*.deb) packages with their short descriptions.
# This script also support the ability to provide a REGEX match to fileter the
# list of packages; in this case, both the package and description is scanned.
# Package architecture is included in the output.
#------------------------------------------------------------------------------

BEGIN {
	FS=": "

	while (getline < "/var/lib/dpkg/status" != 0) {
		if ($1 == "Package") {
			Package = $2
		} else if ($1 == "Status") {
			Status = $2
		} else if ($1 == "Architecture") {
			Arch = $2
		} else if ($1 == "Description" && Status == "install ok installed") {
			Display = sprintf("%s:%s - %s", Package, Arch, $2)

			if (Display ~ ARGV[1]) {
				printf("%s\n", Display)
			}
		}
	}
}
