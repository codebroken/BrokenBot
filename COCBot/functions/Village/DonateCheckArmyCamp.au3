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
		If _Sleep(2000) Then Return
		_CaptureRegion()
		$CurCamp = Number(getOther(586, 193, "Camp"))
		If $CurCamp > 0 Then
			SetLog(GetLangText("msgTotalCampCap") & $CurCamp & "/" & $itxtcampCap, $COLOR_GREEN)
		EndIf
		If $CurCamp >= ($itxtcampCap * (GUICtrlRead($cmbRaidcap) / 100)) Then
			$fullArmy = True
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
				Local $TroopKind = _GetPixelColor(230 + 71 * $i, 359)
				Local $TroopKind2 = _GetPixelColor(230 + 71 * $i, 385)
				Local $TroopName = 0
				Local $TroopQ = getOther(229 + 71 * $i, 413, "Camp")
				If _ColorCheck($TroopKind, Hex(0xF85CCB, 6), 20) Then
					If ($CurArch = 0 And $FirstStart) Then $CurArch -= $TroopQ
					$TroopName = "Archers"
				ElseIf _ColorCheck($TroopKind, Hex(0xF8E439, 6), 20) Then
					If ($CurBarb = 0 And $FirstStart) Then $CurBarb -= $TroopQ
					$TroopName = "Barbarians"
				ElseIf _ColorCheck($TroopKind, Hex(0xF8D198, 6), 20) Then
					If ($CurGiant = 0 And $FirstStart) Then $CurGiant -= $TroopQ
					$TroopName = "Giants"
				ElseIf _ColorCheck($TroopKind, Hex(0x93EC60, 6), 20) Then
					If ($CurGoblin = 0 And $FirstStart) Then $CurGoblin -= $TroopQ
					$TroopName = "Goblins"
				ElseIf _ColorCheck($TroopKind, Hex(0x48A8E8, 6), 20) Then
					If ($CurWB = 0 And $FirstStart) Then $CurWB -= $TroopQ
					$TroopName = "Wallbreakers"
				ElseIf _ColorCheck($TroopKind, Hex(0x131D38, 6), 20) Then
					If ($FirstStart) Then $CurMinion -= $TroopQ
					$TroopName = "Minions"
				ElseIf _ColorCheck($TroopKind2, Hex(0x212018, 6), 20) Then
					If ($FirstStart) Then $CurHog -= $TroopQ
					$TroopName = "Hogs"
				ElseIf _ColorCheck($TroopKind, Hex(0x983B08, 6), 20) Then
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
