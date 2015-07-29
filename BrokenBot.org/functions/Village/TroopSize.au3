; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
; Returns the camp size of a given troop

Func getTroopSize($troop)
	Switch $troop
		Case 0, "barb", "barbarian", "B", "Ba"
			Return 1
		Case 1, "arch", "archer", "Ar", "Arch"
			Return 1
		Case 2, "gob", "goblin", "Gob"
			Return 1
		Case 3, "giant", "Gi", "G"
			Return 5
		Case 4, "Wa", "WB", "wb", "wall breaker"
			Return 2
		Case 5, "loon", "balloon", "Loon"
			Return 5
		Case 6, "wiz", "wizard"
			Return 4
		Case 7, "He", "Heal", "healer"
			Return 14
		Case 8, "drag", "dragon"
			Return 20
		Case 9, "Pe", "pekka"
			Return 25
		Case 10, "min", "minion", "Min"
			Return 2
		Case 11, "hog", "hogger", "hog rider", "pigger", "Ho"
			Return 5
		Case 12, "valk", "valkyrie", "Val"
			Return 1
		Case 13, "Go", "golem"
			Return 30
		Case 14, "witch"
			Return 12
		Case Else
			Return 999
	EndSwitch
EndFunc   ;==>getTroopSize
