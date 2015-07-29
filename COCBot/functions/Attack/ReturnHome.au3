;Returns home when in battle, will take screenshot and check for gold/elixir change unless specified not to.
;Added AbortSearch flag to avoid deadloop while try to recover from search error
Func ReturnHome($TakeSS = 1, $GoldChangeCheck = True, $AbortSearch = False) ;Return main screen

	If $GoldChangeCheck = True Then
		GoldElixirChange() ; Waits for gold and elixir to stop changing
		If _Sleep(100) Then Return
	EndIf

	If $OverlayVisible Then DeleteOverlay()

	$checkKPower = False
	$checkQPower = False
	SetLog(GetLangText("msgReturnHome"), $COLOR_BLUE)
	If $Running = False Then Return
	_CaptureRegion()
	If _WaitForColorArea(19, 519, 100, 30, Hex(0xEE5056, 6), 50, 2) Then
		Click(77, 529) ;Click Surrender
		If _WaitForColorArea(280, 372, 130, 50, Hex(0xCF4010, 6), 30, 2) Then
			Click(522, 384) ; Click confirm
		EndIf
	EndIf

	If (_WaitForColor(304, 569, Hex(0x020202, 6), 30, 5) And $AbortSearch = False) Then
		If _Sleep(1500) Then Return	;wait until number stop changing.
		_CaptureRegion()
		$Raid = 1
		;Get Last Raid Resources
		$LastRaidGold = ReadText(300, 291, 140, $textReturnHome, 0)
		$LastRaidElixir = ReadText(300, 329, 140, $textReturnHome, 0)
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(462, 372), Hex(0xF2D668, 6), 40) Then
			; No DE
			$LastRaidDarkElixir = 0
			$LastRaidTrophy = ReadText(380, 367, 60, $textReturnHome, 0)
		Else
			$LastRaidDarkElixir = ReadText(300, 367, 140, $textReturnHome, 0)
			$LastRaidTrophy = ReadText(380, 403, 60, $textReturnHome, 0)
		EndIf

		$GoldTotalLoot += $LastRaidGold
		$ElixirTotalLoot += $LastRaidElixir
		$DarkTotalLoot += $LastRaidDarkElixir
		$TrophyTotalLoot += $LastRaidTrophy

		If $TakeSS = 1 Then
			SetLog(GetLangText("msgTakingLootSS"), $COLOR_ORANGE)
			Local $Date = @MDAY & "." & @MON & "." & @YEAR
			Local $Time = @HOUR & "." & @MIN
			$FileName = $Date & "_at_" & $Time & ".jpg"
			_CaptureRegion()
			_GDIPlus_ImageSaveToFile($hBitmap, $dirLoots & $FileName)
		EndIf
		If _Sleep(2000) Then Return
		Click(428, 544) ;Click Return Home Button
	Else
		checkMainScreen(True)
	EndIf

	If _GUICtrlEdit_GetLineCount($txtLog) > 5000 Then
		_GUICtrlEdit_SetText($txtLog, "")
	EndIf
	Local $counter = 0
	While 1
		If _Sleep(200) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(284, 28), Hex(0x41B1CD, 6), 20) Then
			Return
		EndIf

		$counter += 1

		If $counter >= 50 Then
			SetLog(GetLangText("msgCannotReturn"), $COLOR_RED)
			checkMainScreen()
			Return
		EndIf
	WEnd
EndFunc   ;==>ReturnHome
