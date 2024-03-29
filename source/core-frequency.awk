#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/core-frequency.awk
# Started On        - Mon 17 Jan 00:01:23 GMT 2022
# Last Change       - Mon 17 Jan 00:15:33 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# List each CPU core and its frequency. Run script on the '/proc/cpuinfo' file.
#------------------------------------------------------------------------------

BEGIN {
	FS = ":"
}

$1 ~ /^processor[[:space:]]+$/ {
	Processor = $2
}

$1 ~ /^cpu MHz[[:space:]]+$/ {
	Cores[Processor] = $2
}

END {
	for (Processor in Cores) {
		printf("CORE_%d: %d\n", Processor + 1, Cores[Processor])
	}
}
