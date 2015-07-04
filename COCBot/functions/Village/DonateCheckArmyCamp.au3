Func Donate_CheckArmyCamp()
	SetLog(GetLangText("msgCheckingCamp"), $COLOR_BLUE)
	$fullArmy = False

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If $ArmyPos[0] = "" Then
		If Not LocateCamp() Then Return
		SaveConfig()
	Else
		If _Sleep(1000) Then Return
		Click($ArmyPos[0], $ArmyPos[1]) ;Click Army Camp
	EndIf

	_CaptureRegion()
	If _Sleep(1000) Then Return
	Local $BArmyPos = _WaitForPixel(309, 581, 433, 583, Hex(0x4084B8, 6), 5) ;Finds Info button
	If IsArray($BArmyPos) = False Then
		SetLog(GetLangText("msgCampNA"), $COLOR_RED)
	Else
		Click($BArmyPos[0], $BArmyPos[1]) ;Click Info button
		_WaitForPixel(690, 150, 710, 170, Hex(0xD80407, 6), 5, 1) ;Finds Red Cross button in new popup window
		If _Sleep(200) Then Return
		For $readattempts = 1 to 3
			$CurCamp = StringStripWS(ReadText(426, 194, 280, $textWindows), 3)
			$CurCamp = StringStripWS(StringMid($CurCamp, Stringinstr($CurCamp, ":") + 1), 3)
			Local $itxtcampCap = StringMid($CurCamp, Stringinstr($CurCamp, "/") + 1)
			If Number($itxtcampCap) > 0 And Number($itxtcampCap) < 300 Then
				$CurCamp = StringLeft($CurCamp, StringInStr($CurCamp, "/") - 1)
				If Number($CurCamp) >= 0 And Number($CurCamp) <= $itxtcampCap Then
					SetLog(GetLangText("msgTotalCampCap") & $CurCamp & "/" & $itxtcampCap, $COLOR_GREEN)
					ExitLoop
				EndIf
			EndIf
			If _Sleep(500) Then Return
			If $readattempts = 3 Then
				SetLog(GetLangText("msgTotalCampCap") & GetLangText("lblUnknownCap"), $COLOR_GREEN)
				$CurCamp = 0
				If $itxtcampCap = 0 then $itxtcampCap = 240
			EndIf
		Next

		If ($CurCamp/$itxtcampCap) >= ((_GUICtrlComboBox_GetCurSel($cmbRaidcap)+1)/10) Then
			$fullarmy = True
		Else
			_CaptureRegion()
			If $FirstStart Then
				$ArmyComp = 0
				$CurGiant = 0
				$CurWB = 0
				$CurArch = 0
				$CurBarb = 0
				$CurGoblin = 0
			EndIf
			For $i = 0 To 6
				Local $TroopKind = _GetPixelColor(254 + 62 * $i, 375)
				Local $TroopKind2 = _GetPixelColor(264 + 62 * $i, 380)
				Local $TroopName = 0
				Local $TroopQ = StringStripWS(ReadText(239 + (62 * $i), 350, 37, $textWindows), 3)
				If StringLeft($TroopQ, 1) = "x" Then $TroopQ = StringRight($TroopQ, StringLen($TroopQ) - 1)
				$TroopQ = Number($TroopQ)
				If _ColorCheck($TroopKind, Hex(0xEC4989, 6), 30) Then
					If ($CurArch = 0 And $FirstStart) Then $CurArch -= $TroopQ
					$TroopName = "Archers"
				ElseIf _ColorCheck($TroopKind, Hex(0xFFC020, 6), 30) Then
					If ($CurBarb = 0 And $FirstStart) Then $CurBarb -= $TroopQ
					$TroopName = "Barbarians"
				ElseIf _ColorCheck($TroopKind, Hex(0xFFC17F, 6), 30) Then
					If ($CurGiant = 0 And $FirstStart) Then $CurGiant -= $TroopQ
					$TroopName = "Giants"
				ElseIf _ColorCheck($TroopKind, Hex(0x90E658, 6), 30) Then
					If ($CurGoblin = 0 And $FirstStart) Then $CurGoblin -= $TroopQ
					$TroopName = "Goblins"
				ElseIf _ColorCheck($TroopKind2, Hex(0xD06C38, 6), 30) Then
					If ($CurWB = 0 And $FirstStart) Then $CurWB -= $TroopQ
					$TroopName = "Wallbreakers"
				ElseIf _ColorCheck($TroopKind, Hex(0x151F37, 6), 20) Then
					If ($FirstStart) Then $CurMinion -= $TroopQ
					$TroopName = "Minions"
				ElseIf _ColorCheck($TroopKind, Hex(0x4C2E26, 6), 30) Then
					If ($FirstStart) Then $CurHog -= $TroopQ
					$TroopName = "Hogs"
				ElseIf _ColorCheck($TroopKind, Hex(0xA95E58, 6), 30) Then
					If ($FirstStart) Then $CurValkyrie -= $TroopQ
					$TroopName = "Valkyries"
				EndIf
				If $TroopQ <> 0 Then SetLog("- " & $TroopName & " " & $TroopQ, $COLOR_GREEN)
			Next
		EndIf
		ClickP($TopLeftClient) ;Click Away
		$FirstCampView = True
	EndIf
	Return $fullArmy
EndFunc   ;==>Donate_CheckArmyCamp
