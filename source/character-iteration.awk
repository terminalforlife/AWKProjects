#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/character-iteration.awk
# Started On        - Wed  7 Jun 17:41:51 BST 2023
# Last Change       - Wed  7 Jun 20:05:10 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Demonstration of character-by-character parsing of data. Here, I'm rather
# pointlessly iterating over each character of each line of the given file, in
# order to print just comment lines, including dynamically-aligned line
# numbers.
#
# You'll notice I assigned the elements to the `Comments` array in a strange
# way you wouldn't expect from most languages. Unfortunately, this is down to
# an annoying limitation of AWK. I complain enough about Python, but AWK does
# also annoy me. Hell, even BASH sometimes bugs me, and I'm a huge fan of BASH!
#------------------------------------------------------------------------------

BEGIN {
	Grey = "\033[2;37m"
	Reset = "\033[0m"

	Comments["\""]
	Comments["#"]
}

func ComChk(Str) {
	for (Comment in Comments) {
		if (Comment == Str)return(1)
	}

	return(0)
}

{
	Found = 0
	Buffer = ""
	Len = split($0, Chars, "")
	for (Index = 1; Index <= Len; Index++) {
		Char = Chars[Index]
		if (Found) {
			Buffer = Buffer Char
		} else if (Index == 1 && ComChk(Char)) {
			Buffer = Buffer Char
			Found = 1
		} else {
			break
		}
	}

	if (length(Buffer)) {
		Len = length(NR)
		if (Len > MaxLen) {
			MaxLen = Len
		}

		Lines[NR] = Buffer
	}
}

END {
	for (Line in Lines) {
		printf("%s%*d%s %s\n", Grey, MaxLen, Line, Reset, Lines[Line])
	}
}
