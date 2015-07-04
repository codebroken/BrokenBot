;==========================================================================
; Function name: GoldElixirChange
; Authored by:
; Edited by: Samota,
;
; Description: Checks if the gold/elixir changes values within 20 seconds, Returns True if changed. Also
; checks every 5 seconds if gold/elixir = "", meaning battle is over. If either condition is met, return
; false.
; Now also check Dark Elixir
;
; Notes: If all troops are used, the battle will end when they are all dead, the timer runs out, or the
; base has been 3-starred. When the battle ends, it is detected within 5 seconds, otherwise it takes up
; to 20 seconds.
;
;==========================================================================
Func GoldElixirChange()
	Local $Gold1, $Gold2
	Local $Elixir1, $Elixir2
	Local $Dark1, $Dark2
	Local $ExitOkay = False
	Local $FirstTime = True
	$ExitTimer = TimerInit()
	$Gold1 = ReadText(50, 70, 150, $textVillageSearch)
	$Elixir1 = ReadText(50, 99, 150, $textVillageSearch)
	$Dark1 = ReadText(50, 128, 80, $textVillageSearch)

	$NoResources = False

	While True
		$Gold2 = ReadText(50, 70, 150, $textVillageSearch)
		$Elixir2 = ReadText(50, 99, 150, $textVillageSearch)
		$Dark2 = ReadText(50, 128, 80, $textVillageSearch)
		If ($Gold1 <> $Gold2 Or $Elixir1 <> $Elixir2 Or $Dark1 <> $Dark2) Then
			If TimerDiff($ExitTimer)/1000 > ($itxtReturnh/2) Then
				SetLog(GetLangText("msgLootChange"), $COLOR_GREEN)
			EndIf
			If Not $NoResources Then $ExitTimer = TimerInit()
			$Gold1 = ReadText(50, 70, 150, $textVillageSearch)
			$Elixir1 = ReadText(50, 99, 150, $textVillageSearch)
			$Dark1 = ReadText(50, 128, 80, $textVillageSearch)
		ElseIf TimerDiff($ExitTimer)/1000 > $itxtReturnh Then
			If Not $NoResources Then SetLog(GetLangText("msgNoIncome"), $COLOR_GREEN)
			Return
		ElseIf ($Gold2 = "" And $Elixir2 = "" And $Dark2 = "") Then
			SetLog(GetLangText("msgBattleFinished"), $COLOR_GREEN)
			Return
		ElseIf ($Gold2 = 0 And $Elixir2 = 0 And ((getTrophy(51, 66 + 90) = "") ? (True) : ($Dark2 = 0))) Then
			If Not $NoResources Then
				SetLog(GetLangText("msgNoResource") & $itxtReturnh & GetLangText("msgSeconds"), $COLOR_GREEN)
				$NoResources = True
				$ExitTimer = TimerInit()
			EndIf
		EndIf
		If _Sleep(100) Then Return
	WEnd

EndFunc   ;==>GoldElixirChange

