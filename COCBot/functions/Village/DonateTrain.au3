;Uses the location of manually set Barracks to train specified troops

; Train the troops (Fill the barracks)

Func Donate_GetTrainPos($troopKind)
	Switch $troopKind
		Case $eBarbarian ; 261, 366: 0x39D8E0
			Return $TrainBarbarian
		Case $eArcher ; 369, 366: 0x39D8E0
			Return $TrainArcher
		Case $eGiant ; 475, 366: 0x3DD8E0
			Return $TrainGiant
		Case $eGoblin ; 581, 366: 0x39D8E0
			Return $TrainGoblin
		Case $eWallbreaker ; 688, 366, 0x3AD8E0
			Return $TrainWallbreaker
		Case $eMinion
			Return $TrainMinion
		Case $eHog
			Return $TrainHog
		Case $eValkyrie
			Return $TrainValkyrie
		Case Else
			SetLog(GetLangText("msgDontKnow") & $troopKind & GetLangText("msgYet"))
			Return 0
	EndSwitch
EndFunc   ;==>Donate_GetTrainPos

Func Donate_TrainIt($troopKind, $howMuch = 1, $iSleep = 100)
	_CaptureRegion()
	Local $pos = Donate_GetTrainPos($troopKind)
	If IsArray($pos) Then
		If CheckPixel($pos) Then
			ClickP($pos, $howMuch, 20)
			If _Sleep($iSleep) Then Return False
			Return True
		EndIf
	EndIf
EndFunc   ;==>Donate_TrainIt

Func Donate_Train($reset = False)
	resetBarracksError()
	If $barrackPos[0][0] = "" Then
		If Not LocateBarrack() Then Return
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf

	SetLog(GetLangText("msgTrainingTroops"), $COLOR_BLUE)

	If $reset Then ; reset all for cook again on startup
		$ArmyComp = 0
		$CurGiant = 0
		$CurWB = 0
		$CurArch = 0
		$CurBarb = 0
		$CurGoblin = 0
	EndIf

	If (($ArmyComp = 0) And (_GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 8)) Or $FixTrain Then
		If $FixTrain Or $FirstStart And Not $reset Then $ArmyComp = $CurCamp
		$FixTrain = False
		$CurGiant += GUICtrlRead($txtNumGiants)
		$CurWB += GUICtrlRead($txtNumWallbreakers)
		$CurArch += Floor((($itxtcampCap * GUICtrlRead($cmbRaidcap) / 100) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers) * 2)) * (GUICtrlRead($txtArchers) / 100))
		$CurBarb += Floor((($itxtcampCap * GUICtrlRead($cmbRaidcap) / 100) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers) * 2)) * (GUICtrlRead($txtBarbarians) / 100))
		$CurGoblin += Floor((($itxtcampCap * GUICtrlRead($cmbRaidcap) / 100) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers) * 2)) * (GUICtrlRead($txtGoblins) / 100))
		SetLog("D-CurArch" & $CurArch)
		SetLog("D-CurBarb" & $CurBarb)
		SetLog("D-CurGoblin" & $CurGoblin)
		If $CurArch < 0 Then $CurArch = 0
		If $CurBarb < 0 Then $CurBarb = 0
		If $CurGoblin < 0 Then $CurGoblin = 0
		If $CurWB < 0 Then $CurWB = 0
		If $CurGiant < 0 Then $CurGiant = 0
		If ($CurArch + $CurBarb + $CurGoblin + (5 * $CurGiant) + (2 * $CurWB)) < $itxtcampCap Then
			If $CurArch > 0 Then
				$CurArch += 1
			EndIf
			If ($CurArch + $CurBarb + $CurGoblin + (5 * $CurGiant) + (2 * $CurWB)) < $itxtcampCap Then
				If $CurBarb > 0 Then
					$CurBarb += 1
				EndIf
				If ($CurArch + $CurBarb + $CurGoblin + (5 * $CurGiant) + (2 * $CurWB)) < $itxtcampCap Then
					If $CurGoblin > 0 Then
						$CurGoblin += 1
					EndIf
				EndIf
			EndIf
		EndIf
		SetLog(GetLangText("msgForcesNeededB") & $CurBarb & GetLangText("msgForcesNeededA") & $CurArch & GetLangText("msgForcesNeededGo") & $CurGoblin & GetLangText("msgForcesNeededGi") & $CurGiant & GetLangText("msgForcesNeededWB") & $CurWB, $COLOR_GREEN)
	EndIf

	Local $GiantEBarrack, $WallEBarrack, $ArchEBarrack, $BarbEBarrack, $GoblinEBarrack
	$GiantEBarrack = Floor($CurGiant / 4)
	$WallEBarrack = Floor($CurWB / 4)
	$ArchEBarrack = Floor($CurArch / 4)
	$BarbEBarrack = Floor($CurBarb / 4)
	$GoblinEBarrack = Floor($CurGoblin / 4)

	Local $troopFirstGiant, $troopSecondGiant, $troopFirstWall, $troopSecondWall, $troopFirstGoblin, $troopSecondGoblin, $troopFirstBarba, $troopSecondBarba, $troopFirstArch, $troopSecondArch
	$troopFirstGiant = 0
	$troopSecondGiant = 0
	$troopFirstWall = 0
	$troopSecondWall = 0
	$troopFirstGoblin = 0
	$troopSecondGoblin = 0
	$troopFirstBarba = 0
	$troopSecondBarba = 0
	$troopFirstArch = 0
	$troopSecondArch = 0

	Local $BarrackControl
	Local $expUIRet[2]

	$hDLL = DllOpen(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll")
	For $i = 0 To 3
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop

		Click($barrackPos[$i][0], $barrackPos[$i][1]) ;Click Barrack
		If _Sleep(500) Then ExitLoop

		_CaptureRegion()
		$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
		$resUI = DllCall($hDLL, "str", "BrokenBotMatchButton", "ptr", $sendHBitmap, "int", 108, "int", 3, "int", 1, "int", 3, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
		_WinAPI_DeleteObject($sendHBitmap)
		$expUIRet[0] = -1
		If IsArray($resUI) Then
			If $resUI[0] = -1 Then
				; Didn't find button
			ElseIf $resUI[0] = -2 Then
				SetLog(GetLangText("msgLicense"), $COLOR_RED)
			Else
				$expUIRet = StringSplit($resUI[0], "|", 2)
			EndIf
		Else
			SetLog(GetLangText("msgDLLError"), $COLOR_RED)
		EndIf
		If $expUIRet[0] = -1 Then
			SetLog(GetLangText("msgBarrack") & $i + 1 & GetLangText("msgNotAvailable"), $COLOR_RED)
			handleBarracksError($i)
			If _Sleep(500) Then ExitLoop
		Else
			Click($expUIRet[1], $expUIRet[2]) ;Click Train Troops button
			_WaitForPixel(720, 150, 740, 170, Hex(0xD80404, 6), 5, 1) ;Finds Red Cross button in new Training popup window

			If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then
				Switch $i
					Case 0
						$BarrackControl = $cmbBarrack1
					Case 1
						$BarrackControl = $cmbBarrack2
					Case 2
						$BarrackControl = $cmbBarrack3
					Case 3
						$BarrackControl = $cmbBarrack4
				EndSwitch
				_CaptureRegion()
				Switch _GUICtrlComboBox_GetCurSel($BarrackControl)
					Case 0
						While _ColorCheck(_GetPixelColor(216, 325), Hex(0xF09D1C, 6), 30)
							Click(216, 325, 75) ;Barbarian
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 1
						While _ColorCheck(_GetPixelColor(330, 323), Hex(0xE84070, 6), 30)
							Click(325, 320, 75) ;Archer
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 2
						While _ColorCheck(_GetPixelColor(419, 319), Hex(0xF88409, 6), 30)
							Click(419, 319, 20) ;Giant
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 3
						While _ColorCheck(_GetPixelColor(549, 328), Hex(0xFB4C24, 6), 30)
							Click(535, 320, 75) ;Goblin
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 4
						While _ColorCheck(_GetPixelColor(685, 327), Hex(0x9E4716, 6), 30)
							Click(685, 327, 20) ;Wall Breaker
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 5
						While _ColorCheck(_GetPixelColor(213, 418), Hex(0x861F15, 6), 30)
							Click(213, 418, 20) ;Balloon
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 6
						While _ColorCheck(_GetPixelColor(340, 449), Hex(0xF09C85, 6), 30)
							Click(325, 425, 20) ;Wizard
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 7
						While _ColorCheck(_GetPixelColor(440, 445), Hex(0xFDD8C0, 6), 30)
							Click(440, 445, 10) ;Healer
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 8
						While _ColorCheck(_GetPixelColor(539, 444), Hex(0x302848, 6), 30)
							Click(539, 444, 10) ;Dragon
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 9
						While _ColorCheck(_GetPixelColor(647, 440), Hex(0x456180, 6), 30)
							Click(647, 440, 10) ;PEKKA
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case Else
						If _Sleep(50) Then ExitLoop
						_CaptureRegion()
				EndSwitch
			Else
				SetLog("====== " & GetLangText("msgBarrack") & $i + 1 & " : ======", $COLOR_BLUE)
				_CaptureRegion()
				;while _ColorCheck(_GetPixelColor(496, 200), Hex(0x880000, 6), 20) Then
				If $reset Or $FirstStart Then
					Click(503, 180, 80, 5)
				EndIf
				;wend

				If _Sleep(500) Then ExitLoop
				_CaptureRegion()
				If GUICtrlRead($txtNumGiants) <> "0" Then
					$troopFirstGiant = StringStripWS(ReadText(181 + (2 * 107), 298, 35, $textWindows),3)
					If StringRight($troopFirstGiant, 1) = "x" Then $troopFirstGiant = StringLeft($troopFirstGiant, StringLen($troopFirstGiant) - 1)
				EndIf

				If GUICtrlRead($txtNumWallbreakers) <> "0" Then
					$troopFirstWall = StringStripWS(ReadText(181 + (4 * 107), 298, 35, $textWindows),3)
					If StringRight($troopFirstWall, 1) = "x" Then $troopFirstWall = StringLeft($troopFirstWall, StringLen($troopFirstWall) - 1)
				EndIf

				If GUICtrlRead($txtGoblins) <> "0" Then
					$troopFirstGoblin = StringStripWS(ReadText(181 + (3* 107), 298, 35, $textWindows),3)
					If StringRight($troopFirstGoblin, 1) = "x" Then $troopFirstGoblin = StringLeft($troopFirstGoblin, StringLen($troopFirstGoblin) - 1)
				EndIf

				If GUICtrlRead($txtBarbarians) <> "0" Then
					$troopFirstBarba = StringStripWS(ReadText(181, 298, 35, $textWindows),3)
					If StringRight($troopFirstBarba, 1) = "x" Then $troopFirstBarba = StringLeft($troopFirstBarba, StringLen($troopFirstBarba) - 1)
				EndIf

				If GUICtrlRead($txtArchers) <> "0" Then
					$troopFirstArch = StringStripWS(ReadText(181 + 107, 298, 35, $textWindows),3)
					If StringRight($troopFirstArch, 1) = "x" Then $troopFirstArch = StringLeft($troopFirstArch, StringLen($troopFirstArch) - 1)
				EndIf

				If GUICtrlRead($txtNumGiants) <> "0" And $CurGiant > 0 Then
					;If _ColorCheck(_GetPixelColor(475, 366), Hex(0x3DD8E0, 6), 20) And $CurGiant > 0 Then
					If $CurGiant > 0 Then
						If $GiantEBarrack = 0 Then
							Donate_TrainIt($eGiant, 1)
						ElseIf $GiantEBarrack >= $CurGiant Or $GiantEBarrack = 0 Then
							Donate_TrainIt($eGiant, $CurGiant)
						Else
							Donate_TrainIt($eGiant, $GiantEBarrack)
						EndIf
					EndIf
				EndIf


				If GUICtrlRead($txtNumWallbreakers) <> "0" And $CurWB > 0 Then
					;If _ColorCheck(_GetPixelColor(688, 366), Hex(0x3AD8E0, 6), 20) And $CurWB > 0  Then
					If $CurWB > 0 Then
						If $WallEBarrack = 0 Then
							Donate_TrainIt($eWallbreaker, 1)
						ElseIf $WallEBarrack >= $CurWB Or $WallEBarrack = 0 Then
							Donate_TrainIt($eWallbreaker, $CurWB)
						Else
							Donate_TrainIt($eWallbreaker, $WallEBarrack)
						EndIf
					EndIf
				EndIf


				If GUICtrlRead($txtBarbarians) <> "0" And $CurBarb > 0 Then
					;If _ColorCheck(_GetPixelColor(369, 366), Hex(0x39D8E0, 6), 20) And $CurBarb > 0 Then
					If $CurBarb > 0 Then
						If $BarbEBarrack = 0 Then
							Donate_TrainIt($eBarbarian, 1)
						ElseIf $BarbEBarrack >= $CurBarb Or $BarbEBarrack = 0 Then
							Donate_TrainIt($eBarbarian, $CurBarb)
						Else
							Donate_TrainIt($eBarbarian, $BarbEBarrack)
						EndIf
					EndIf
				EndIf


				If GUICtrlRead($txtGoblins) <> "0" And $CurGoblin > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurGoblin > 0 Then
					If $CurGoblin > 0 Then
						If $GoblinEBarrack = 0 Then
							Donate_TrainIt($eGoblin, 1)
						ElseIf $GoblinEBarrack >= $CurGoblin Or $GoblinEBarrack = 0 Then
							Donate_TrainIt($eGoblin, $CurGoblin)
						Else
							Donate_TrainIt($eGoblin, $GoblinEBarrack)
						EndIf
					EndIf
				EndIf

				If _Sleep(900) Then ExitLoop
				_CaptureRegion()

				If GUICtrlRead($txtNumGiants) <> "0" Then
					$troopSecondGiant = StringStripWS(ReadText(181 + (2 * 107), 298, 35, $textWindows))
					If StringRight($troopSecondGiant, 1) = "x" Then $troopSecondGiant = StringLeft($troopSecondGiant, StringLen($troopSecondGiant) - 1)
				EndIf

				If GUICtrlRead($txtNumWallbreakers) <> "0" Then
					$troopSecondWall = StringStripWS(ReadText(181 + (4 * 107), 298, 35, $textWindows))
					If StringRight($troopSecondWall, 1) = "x" Then $troopSecondWall = StringLeft($troopSecondWall, StringLen($troopSecondWall) - 1)
				EndIf

				If GUICtrlRead($txtGoblins) <> "0" Then
					$troopSecondGoblin = StringStripWS(ReadText(181 + (3* 107), 298, 35, $textWindows))
					If StringRight($troopSecondGoblin, 1) = "x" Then $troopSecondGoblin = StringLeft($troopSecondGoblin, StringLen($troopSecondGoblin) - 1)
				EndIf

				If GUICtrlRead($txtBarbarians) <> "0" Then
					$troopSecondBarba = StringStripWS(ReadText(181, 298, 35, $textWindows))
					If StringRight($troopSecondBarba, 1) = "x" Then $troopSecondBarba = StringLeft($troopSecondBarba, StringLen($troopSecondBarba) - 1)
				EndIf

				If GUICtrlRead($txtArchers) <> "0" Then
					$troopSecondArch = StringStripWS(ReadText(181 + 107, 298, 35, $textWindows))
					If StringRight($troopSecondArch, 1) = "x" Then $troopSecondArch = StringLeft($troopSecondArch, StringLen($troopSecondArch) - 1)
				EndIf


				If $troopSecondGiant > $troopFirstGiant And GUICtrlRead($txtNumGiants) <> "0" Then
					$ArmyComp += ($troopSecondGiant - $troopFirstGiant) * 5
					$CurGiant -= ($troopSecondGiant - $troopFirstGiant)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameGiant") & " : " & ($troopSecondGiant - $troopFirstGiant), $COLOR_GREEN)
					SetLog(GetLangText("troopNameGiant") & GetLangText("msgRemaining") & $CurGiant, $COLOR_BLUE)
				EndIf


				If $troopSecondWall > $troopFirstWall And GUICtrlRead($txtNumWallbreakers) <> "0" Then
					$ArmyComp += ($troopSecondWall - $troopFirstWall) * 2
					$CurWB -= ($troopSecondWall - $troopFirstWall)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameWallBreaker") & " : " & ($troopSecondGiant - $troopFirstGiant), $COLOR_GREEN)
					SetLog(GetLangText("troopNameWallBreaker") & GetLangText("msgRemaining") & $CurGiant, $COLOR_BLUE)
				EndIf

				If $troopSecondGoblin > $troopFirstGoblin And GUICtrlRead($txtGoblins) <> "0" Then
					$ArmyComp += ($troopSecondGoblin - $troopFirstGoblin)
					$CurGoblin -= ($troopSecondGoblin - $troopFirstGoblin)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameGoblin") & " : " & ($troopSecondGiant - $troopFirstGiant), $COLOR_GREEN)
					SetLog(GetLangText("troopNameGoblin") & GetLangText("msgRemaining") & $CurGiant, $COLOR_BLUE)
				EndIf

				If $troopSecondBarba > $troopFirstBarba And GUICtrlRead($txtBarbarians) <> "0" Then
					$ArmyComp += ($troopSecondBarba - $troopFirstBarba)
					$CurBarb -= ($troopSecondBarba - $troopFirstBarba)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameBarbarian") & " : " & ($troopSecondGiant - $troopFirstGiant), $COLOR_GREEN)
					SetLog(GetLangText("troopNameBarbarian") & GetLangText("msgRemaining") & $CurGiant, $COLOR_BLUE)
				EndIf

				If $troopSecondArch > $troopFirstArch And GUICtrlRead($txtArchers) <> "0" Then
					$ArmyComp += ($troopSecondArch - $troopFirstArch)
					$CurArch -= ($troopSecondArch - $troopFirstArch)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameArcher") & " : " & ($troopSecondGiant - $troopFirstGiant), $COLOR_GREEN)
					SetLog(GetLangText("troopNameArcher") & GetLangText("msgRemaining") & $CurGiant, $COLOR_BLUE)
				EndIf
				SetLog(GetLangText("msgTotalBuilding") & $ArmyComp, $COLOR_RED)
			EndIf
		EndIf
		If _Sleep(100) Then ExitLoop
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
	Next
	If $brerror[0] And $brerror[1] And $brerror[2] And $brerror[3] Then
		resetBarracksError()
		$needzoomout = True
		SetLog(GetLangText("msgRestartComplete"), $COLOR_RED)
	Else
		SetLog(GetLangText("msgTrainingComp"), $COLOR_BLUE)
	EndIf
	$FirstStart = False

;~ 	BEGIN DARK TROOPS
;~ 		If $ichkDarkTroop = 0 Then Return
		Local $TrainPos[2]
		If $DarkBarrackPos[0][0] = "" Then
		LocateDarkBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
		EndIf

		Global $LeftRax1, $LeftRax2, $TrainDrax1, $TrainDrax2, $ClickRax1, $ClickRax2

		If $fullArmy Or $FirstDarkTrain Then
		$TrainDrax1 = True
		$TrainDrax2 = True
		EndIf

		If $TrainDrax1 = False And $TrainDrax2 = False Then Return

		SetLog(GetLangText("msgTrainingDark"), $COLOR_BLUE)
		For $i = 0 To 1
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop
		Click($DarkBarrackPos[$i][0], $DarkBarrackPos[$i][1]) ;Click Dark Barrack
		If _Sleep(500) Then ExitLoop

;~ 		Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x603818, 6), 5) ;Finds Train Troops button
	    _CaptureRegion()
		If _Sleep(500) Then ExitLoop
		$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
		$res = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotMatchButton", "ptr", $sendHBitmap, "int", 108, "int", 3, "int", 1, "int", 3, "int", (IsChecked($chkSpeedBoost) ? (1) : (0))) ; remove icon
		_WinAPI_DeleteObject($sendHBitmap)
		If IsArray($res) Then
			If $res[0] = -1 Then
			   SetLog(GetLangText("msgDarkBarrack") & $i + 1 & GetLangText("msgNotAvailable"), $COLOR_RED)
			   Return
			ElseIf $res[0] = -2 Then
				SetLog(GetLangText("msgLicense"), $COLOR_RED)
			 Else
			   $expUIRet = StringSplit($res[0], "|", 2)
			   $TrainPos[0] = $expUIRet[1]
			   $TrainPos[1] = $expUIRet[2]
			   If $DebugMode = 1 Then SetLog("DB Train:" & $TrainPos[0] & " Y:" & $TrainPos[1])
			EndIf
	    EndIf
		Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
		If _Sleep(800) Then ExitLoop
		If $fullArmy Or $FirstDarkTrain Then
		If Not _ColorCheck(_GetPixelColor(497, 195), Hex(0xE0E4D0, 6), 20) Then
		Click(496, 190, 80, 2)
		EndIf
		EndIf

		;Dark Barrack 1
		If GUICtrlRead($txtDarkBarrack1) <> "0" And $i = 0 And $TrainDrax1 = True Then
		$itxtDarkBarrack1 = GUICtrlRead($txtDarkBarrack1)
		If $DarkBarrackTroop[$i] = 0 Then
		Local $troopMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
		If $itxtDarkBarrack1 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eMinion, $itxtDarkBarrack1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $itxtDarkBarrack1 > 20 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eMinion, 20)
		   $LeftRax1 = ($itxtDarkBarrack1 - 20)
		   $ClickRax1 = $LeftRax1
		   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 > ($troopMinion < 20) Then
		   Donate_TrainIt($eMinion, (20 - $troopMinion))
		   $LeftRax1 = ($ClickRax1 - (20 - $troopMinion))
		   $ClickRax1 = $LeftRax1
		   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 <= ($troopMinion < 20) Then
		   Donate_TrainIt($eMinion, $LeftRax1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 <= 1 And ($troopMinion < 20) Then
		   Donate_TrainIt($eMinion, $LeftRax1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		Else
			SetLog("Dark Barrack 1 Training in progress, Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
			$FirstDarkTrain = False
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 1 Then
		Local $troopHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
		If $itxtDarkBarrack1 <= 10 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eHog, $itxtDarkBarrack1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $itxtDarkBarrack1 > 10 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eHog, 10)
		   $LeftRax1 = ($itxtDarkBarrack1 - 10)
		   $ClickRax1 = $LeftRax1
		   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 > ($troopHog < 10) Then
		   Donate_TrainIt($eHog, (10 - $troopHog))
		   $LeftRax1 = ($ClickRax1 - (10 - $troopHog))
		   $ClickRax1 = $LeftRax1
		   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 <= ($troopHog < 10) Then
		   Donate_TrainIt($eHog, $LeftRax1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 <= 1 And ($troopHog < 10) Then
		   Donate_TrainIt($eHog, $LeftRax1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		Else
		   SetLog("Dark Barrack 1 Training in progress, Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 2 Then
		Local $troopValkyrie = Number(getOther(171 + 107 * 2, 278, "Barrack"))
		If $itxtDarkBarrack1 <= 7 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eValkyrie, $itxtDarkBarrack1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $itxtDarkBarrack1 > 7 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eValkyrie, 7)
		   $LeftRax1 = ($itxtDarkBarrack1 - 7)
		   $ClickRax1 = $LeftRax1
		   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 > ($troopValkyrie < 7) Then
		   Donate_TrainIt($eValkyrie, (7 - $troopValkyrie))
		   $LeftRax1 = ($ClickRax1 - (7 - $troopValkyrie))
		   $ClickRax1 = $LeftRax1
		   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 <= ($troopValkyrie < 7) Then
		   Donate_TrainIt($eValkyrie, $LeftRax1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax1 <= 1 And ($troopValkyrie < 7) Then
		   Donate_TrainIt($eValkyrie, $LeftRax1)
		   $TrainDrax1 = False
		   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		Else
		   SetLog("Dark Barrack 1 Training in progress, Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
		   $FirstDarkTrain = False
		EndIf
		EndIf
		EndIf

		;Dark Barrack 2
		If GUICtrlRead($txtDarkBarrack2) <> "0" And $i = 1 And $TrainDrax2 = True Then
		$itxtDarkBarrack2 = GUICtrlRead($txtDarkBarrack2)
		If $DarkBarrackTroop[$i] = 0 Then
		Local $troopMinion2 = Number(getOther(171 + 107 * 0, 278, "Barrack"))
		If $itxtDarkBarrack2 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eMinion, $itxtDarkBarrack2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $itxtDarkBarrack2 > 20 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eMinion, 20)
		   $LeftRax2 = ($itxtDarkBarrack2 - 20)
		   $ClickRax2 = $LeftRax2
		   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 > ($troopMinion2 < 20) Then
		   Donate_TrainIt($eMinion, (20 - $troopMinion2))
		   $LeftRax2 = ($ClickRax2 - (20 - $troopMinion2))
		   $ClickRax2 = $LeftRax2
		   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 <= ($troopMinion2 < 20) Then
		   Donate_TrainIt($eMinion, $LeftRax2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 <= 1 And ($troopMinion2 < 20) Then
		   Donate_TrainIt($eMinion, $LeftRax2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		Else
		   SetLog("Dark Barrack 2 Training in progress, Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 1 Then
		Local $troopHog2 = Number(getOther(171 + 107 * 1, 278, "Barrack"))
		   If $itxtDarkBarrack2 <= 10 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eHog, $itxtDarkBarrack2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $itxtDarkBarrack2 > 10 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eHog, 10)
		   $LeftRax2 = ($itxtDarkBarrack2 - 10)
		   $ClickRax2 = $LeftRax2
		   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 > ($troopHog2 < 10) Then
		   Donate_TrainIt($eHog, (10 - $troopHog2))
		   $LeftRax2 = ($ClickRax2 - (10 - $troopHog2))
		   $ClickRax2 = $LeftRax2
		   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 <= ($troopHog2 < 10) Then
		   Donate_TrainIt($eHog, $LeftRax2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 <= 1 And ($troopHog2 < 10) Then
		   Donate_TrainIt($eHog, $LeftRax2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		Else
		   SetLog("Dark Barrack 2 Training in progress, Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 2 Then
		Local $troopValkyrie2 = Number(getOther(171 + 107 * 2, 278, "Barrack"))
		If $itxtDarkBarrack2 <= 7 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eValkyrie, $itxtDarkBarrack2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $itxtDarkBarrack2 > 7 And ($fullArmy Or $FirstDarkTrain) Then
		   Donate_TrainIt($eValkyrie, 7)
		   $LeftRax2 = ($itxtDarkBarrack2 - 7)
		   $ClickRax2 = $LeftRax2
		   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 > ($troopValkyrie2 < 7) Then
		   Donate_TrainIt($eValkyrie, (7 - $troopValkyrie2))
		   $LeftRax2 = ($ClickRax2 - (7 - $troopValkyrie2))
		   $ClickRax2 = $LeftRax2
		   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 <= ($troopValkyrie2 < 7) Then
		   Donate_TrainIt($eValkyrie, $LeftRax2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		ElseIf $LeftRax2 <= 1 And ($troopValkyrie2 < 7) Then
		   Donate_TrainIt($eValkyrie, $LeftRax2)
		   $TrainDrax2 = False
		   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
		   $FirstDarkTrain = False
		Else
		   SetLog("Dark Barrack 2 Training in progress, Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
		   $FirstDarkTrain = False
		EndIf
		EndIf
		EndIf

		If _Sleep(100) Then ExitLoop
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
   Next
		SetLog(GetLangText("msgDarkTroopComplete"), $COLOR_BLUE)
		$FirstDarkTrain = False
;~ 	END DARK TROOPS
EndFunc   ;==>Donate_Train
