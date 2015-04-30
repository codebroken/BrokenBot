;Returns home when in battle, will take screenshot and check for gold/elixir change unless specified not to.

Func ReturnHome($TakeSS = 1, $GoldChangeCheck = True) ;Return main screen
	If $GoldChangeCheck = True Then
		If _Sleep(15000) Then Return
		While GoldElixirChange()
			If _Sleep(1000) Then Return
		WEnd
	EndIf

	$checkKPower = False
	$checkQPower = False
	SetLog("Returning Home", $COLOR_BLUE)
	If $Running = False Then Return
	Click(62, 519) ;Click Surrender
	If _Sleep(500) Then Return
	Click(512, 394) ;Click Confirm
	If _Sleep(750) Then Return

	If _Sleep(3000) Then Return
	_CaptureRegion()
	$Raid = 1
	;Get Last Raid Resources
	$LastRaidDarkElixir = 0 ;in case of no DE gain, reset it to 0 first
	$LastRaidGold = getOther(330, 289, "LastRaidGold")
	$LastRaidElixir = getOther(330, 328, "LastRaidElixir")
	Local $trophyicon = _PixelSearch(457, 403, 467, 418, Hex(0xE8C528, 6), 5) ;Finds Trophy icon in the bottom, if it finds it then Dark Elixir is available
	If IsArray($trophyicon) = True Then
		$LastRaidDarkElixir = getOther(330, 365, "LastRaidDarkElixir")
		$LastRaidTrophy = getOther(330, 402, "LastRaidTrophy")
	Else
		$LastRaidTrophy = getOther(330, 365, "LastRaidTrophy")
	EndIf

	If $TakeSS = 1 Then
		SetLog("Taking snapshot of your loot", $COLOR_ORANGE)
		Local $Date = @MDAY & "." & @MON & "." & @YEAR
		Local $Time = @HOUR & "." & @MIN
		$FileName = $Date & "_at_" & $Time & ".jpg"
		_CaptureRegion()
		_GDIPlus_ImageSaveToFile($hBitmap, $dirLoots & $FileName)
	EndIf

	If _Sleep(2000) Then Return
	Click(428, 544) ;Click Return Home Button

	Local $counter = 0
	While 1
		If _Sleep(2000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(284, 28), Hex(0x41B1CD, 6), 20) Then
			If _GUICtrlEdit_GetLineCount($txtLog) > 5000 Then
				_GUICtrlEdit_SetText($txtLog, "")
			EndIf
			Return
		EndIf

		$counter += 1

		If $counter >= 50 Then
			SetLog("Cannot return home.", $COLOR_RED)
			checkMainScreen()
			Return
		EndIf
	WEnd
EndFunc   ;==>ReturnHome