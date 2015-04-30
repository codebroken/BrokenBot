Func NameOfTroop($kind, $plurial = 0)
	Switch $kind
		Case $eBarbarian
			Return "Barbarians"
		Case $eArcher
			Return "Archers"
		Case $eGoblin
			Return "Goblins"
		Case $eGiant
			Return "Giants"
		Case $eWallbreaker
			Return "Wall Breakers"
		Case $eMinion
			Return "Minions"
		Case $eHog
			Return "Hogs"
		Case $eValkyrie
			Return "Valkyries"
		Case $eKing
			Return "King"
		Case $eQueen
			Return "Queen"
		Case $eCastle
			Return "Clan castle"
		Case $eLSpell
			Return "Lightning Spell"
		Case Else
			Return ""
	EndSwitch
EndFunc   ;==>NameOfTroop
