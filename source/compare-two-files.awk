#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/compare-two-files.awk
# Started On        - Sat 15 Jan 14:55:19 GMT 2022
# Last Change       - Sat 15 Jan 23:02:20 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# A very simple demonstration of showing a like-for-like difference between
# file 1 and file 2, with AWK. Line numbers (of the original file) are
# included.
#------------------------------------------------------------------------------

ARGIND == 1 {
	Data[FNR] = $0
	Len = length(FNR)
	if (Len > MaxLen) MaxLen = Len
}

ARGIND == 2 && Data[FNR] != $0 {
	printf(" \033[2;37m%*d\033[0m  %s\n", MaxLen, FNR, $0)
}
