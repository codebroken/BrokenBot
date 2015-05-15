;Gets trophy count of village and compares to max trophy input.
;Will drop a troop and return home with no screenshot or gold wait.

Func DropTrophy()
	Local $i = 0
	Local $TrophyCount = getOther(50, 74, "Trophy")
	If Number($TrophyCount) > Number($itxtMaxTrophy) Then
		While Number($TrophyCount) > Number($itxtMinTrophy)
			$TrophyCount = getOther(50, 74, "Trophy")
			SetLog(GetLangText("msgTrophyCount") & $TrophyCount, $COLOR_GREEN)
			If Number($TrophyCount) > Number($itxtMinTrophy) Then
				SetLog(GetLangText("msgDropTrophies"), $COLOR_BLUE)
				If _Sleep(2000) Then ExitLoop

				ZoomOut()
				PrepareSearch()

				If _Sleep(5000) Then ExitLoop
				While getGold(51, 66) = "" ; Loops until gold is readable
					If _Sleep(1000) Then ExitLoop (2)
					$i += 1
					If $i >= 10 Then
						checkMainScreen()
						$Restart = True
						ExitLoop (2)
					EndIf
				WEnd
				Click(34, 310) ;Drop one troop

				$CurArch += 1
				If _Sleep(1000) Then ExitLoop

				ReturnHome(False, False) ;Return home no screenshot
				If _Sleep(1000) Then ExitLoop
			Else
				SetLog(GetLangText("msgDropComplete"), $COLOR_BLUE)
			EndIf
		WEnd
		Return True
	EndIf
EndFunc   ;==>DropTrophy
