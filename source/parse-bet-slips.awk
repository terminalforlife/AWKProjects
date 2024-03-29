#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - AWKProjects/source/parse-bet-slips.awk
# Started On        - Fri 14 Jan 14:45:52 GMT 2022
# Last Change       - Fri 14 Jan 14:49:31 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# List total wins, losses, and others for each ID. Aside from boredom, this was
# written for a user on the Linux Mint support forums, as an alternative to a
# BASH script.
#
#   https://forums.linuxmint.com/viewtopic.php?f=213&t=364328
#
# The data this AWK script parses can be found commented at the bottom of this
# file. To use it, add it to a separate file then point this script to it.
#------------------------------------------------------------------------------

BEGIN {
	FS=","
}

NR > 1 {
	IDs[$3] = IDs[$3] $1 ":"
}

END {
	SortLen = asorti(IDs, SortedIDs)
	for (SortIndex = 1; SortIndex <= SortLen; SortIndex++) {
		ID = SortedIDs[SortIndex]

		Win = 0
		Loss = 0
		Other = 0
		SplitLen = split(IDs[ID], States, ":")
		for (SplitIndex = 1; SplitIndex < SplitLen; SplitIndex++) {
			if (States[SplitIndex] == "win") {
				Win++
			} else if (States[SplitIndex] == "lose") {
				Loss++
			} else {
				Other++
			}
		}

		printf("%d: %d wins, %d losses and %d other\n", ID, Win, Loss, Other)

	}
}

#Status,"Bet type","Betslip Id",Date,Sport,League,Event,Wager,Odds,Risk,"To Win"
#win,parlay,10141237701,"Mar 14, 2020 5:29pm UTC","Mixed Martial Arts",UFC,"Gilbert Burns v Demian Maia","Fight: Gilbert Burns ML",1.566," "," "
#win,parlay,10141237701,"Mar 14, 2020 5:29pm UTC","Mixed Martial Arts",UFC,"Francisco Trinaldo v John Makdessi","Fight: Francisco Trinaldo ML",1.619," "," "
#win,parlay,10141237701,"Mar 14, 2020 5:29pm UTC","Mixed Martial Arts",UFC,"Amanda Ribas v Randa Markos","Fight: Amanda Ribas ML",1.255," "," "
#lose,parlay,10141237701,"Mar 14, 2020 5:29pm UTC","Mixed Martial Arts",UFC,"Veronica Macedo v Bea Malecki","Fight: Veronica Macedo ML",1.655," "," "
#push,parlay,10141237701,"Mar 14, 2020 5:29pm UTC","Mixed Martial Arts",UFC,"Enrique Barzola v Rani Yahya","Fight: Enrique Barzola ML",1.505," "," "
#win,parlay,10141237701,"Mar 14, 2020 5:29pm UTC","Mixed Martial Arts",UFC,"Mayra Bueno Silva v Maryna Moroz","Fight: Maryna Moroz ML",2.368," "," "
#lose,parlay,10141237701,"Mar 14, 2020 5:29pm UTC","Mixed Martial Arts",UFC,"Johnny Walker v Nikita Krylov","Fight: Johnny Walker ML",1.744," "," "
#lose,parlay,10141237701,"Mar 14, 2020 5:29pm UTC"," "," "," "," ",21.747,0.001036,0.021500
#win,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Ecuador - Serie A","Liga De Portoviejo v Tecnico Universitario","Match: Tecnico Universitario ML",1.693," "," "
#win,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Mexico - Primera Division","Queretaro FC v CA Monarcas Morelia","Match: CA Monarcas Morelia ML",2.187," "," "
#lose,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Australia - A League","Perth Glory v Sydney FC","Match: over 2.5",1.732," "," "
#lose,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Australia - A League","Western Sydney v Melbourne City","Match: over 2.5",1.661," "," "
#lose,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Turkey - Super League","Genclerbirligi SK v Denizlispor","Match: over 1.5",1.268," "," "
#lose,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Russia - Premier League","Spartak Moscow v Gazovik Orenburg","Match: under 2.5",1.643," "," "
#win,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Turkey - Super League","Gaziantep BB SK v Alanyaspor","Match: Alanyaspor +0.5",1.191," "," "
#lose,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Russia - Premier League","Rubin Kazan v Arsenal Tula","Match: Arsenal Tula +0",1.600," "," "
#lose,parlay,10141227753,"Mar 13, 2020 11:57pm UTC",Soccer,"Turkey - Super League","Fenerbahce v Torku Konyaspor","Match: over 1.5",1.396," "," "
#lose,parlay,10141227753,"Mar 13, 2020 11:57pm UTC"," "," "," "," ",59.033,0.000500,0.029017
