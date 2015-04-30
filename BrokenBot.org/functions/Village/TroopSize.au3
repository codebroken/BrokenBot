; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
; Returns the camp size of a given troop

Func getTroopSize($troop)
	Switch $troop
		Case 0,"barb","barbarian","B","Ba"
			return 1
		Case 1,"arch","archer","Ar","Arch"
			return 1
		Case 2,"gob","goblin","Gob"
			return 1
		Case 3,"giant","Gi","G"
			return 5
		Case 4,"Wa","WB","wb","wall breaker"
			return 2
		Case 5,"loon","balloon","Loon"
			return 5
		Case 6,"wiz","wizard"
			return 4
		Case 7,"He","Heal","healer"
			return 14
		Case 8,"drag","dragon"
			return 20
		Case 9,"Pe","pekka"
			return 25
		Case 10,"min","minion","Min"
			return 2
		Case 11,"hog","hogger","hog rider","pigger","Ho"
			return 5
		Case 12,"valk","valkyrie","Val"
			return 1
		Case 13,"Go","golem"
			return 30
		Case 14,"witch"
			return 12
		Case Else
			return 999
	EndSwitch
EndFunc