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
		SetLog(GetLangText("msgForcesNeededB")& $CurBarb & GetLangText("msgForcesNeededA") & $CurArch & GetLangText("msgForcesNeededGo") & $CurGoblin & GetLangText("msgForcesNeededGi") & $CurGiant & GetLangText("msgForcesNeededWB") & $CurWB, $COLOR_GREEN)
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
	For $i = 0 To 3
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(1000) Then ExitLoop

		Click($barrackPos[$i][0], $barrackPos[$i][1]) ;Click Barrack
		If _Sleep(1000) Then ExitLoop

		Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x9C7C37, 6), 5) ;Finds Train Troops button
		If IsArray($TrainPos) = False Then
			SetLog(GetLangText("msgBarrack") & $i + 1 & GetLangText("msgNotAvailable"), $COLOR_RED)
			handleBarracksError($i)
			If _Sleep(500) Then ExitLoop
		Else
			Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
			;SetLog(GetLangText("msgBarrack") & $i + 1 & " ...", $COLOR_GREEN)
			If _Sleep(1000) Then ExitLoop
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
						While _ColorCheck(_GetPixelColor(220, 320), Hex(0xF89683, 6), 20)
							Click(220, 320, 75) ;Barbarian
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 1
						While _ColorCheck(_GetPixelColor(325, 330), Hex(0xF8C3B0, 6), 20)
							Click(325, 320, 75) ;Archer
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 2
						While _ColorCheck(_GetPixelColor(430, 320), Hex(0xE68358, 6), 20)
							Click(430, 320, 20) ;Giant
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 3
						While _ColorCheck(_GetPixelColor(535, 310), Hex(0x7AA440, 6), 20)
							Click(535, 320, 75) ;Goblin
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 4
						While _ColorCheck(_GetPixelColor(640, 290), Hex(0x5FC6D6, 6), 20)
							Click(640, 320, 20) ;Wall Breaker
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 5
						While _ColorCheck(_GetPixelColor(220, 410), Hex(0x58C0D8, 6), 20)
							Click(220, 425, 20) ;Balloon
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 6
						While _ColorCheck(_GetPixelColor(325, 425), Hex(0xA46052, 6), 20)
							Click(325, 425, 20) ;Wizard
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 7
						While _ColorCheck(_GetPixelColor(430, 425), Hex(0xEFBB96, 6), 20)
							Click(430, 425, 10) ;Healer
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 8
						While _ColorCheck(_GetPixelColor(535, 410), Hex(0x8B7CA8, 6), 20)
							Click(535, 425, 10) ;Dragon
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 9
						While _ColorCheck(_GetPixelColor(640, 410), Hex(0x7092AC, 6), 20)
							Click(640, 425, 10) ;PEKKA
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
					Click(496, 190, 80, 5)
				EndIf
				;wend

				If _Sleep(500) Then ExitLoop
				_CaptureRegion()
				If GUICtrlRead($txtNumGiants) <> "0" Then
					$troopFirstGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $troopFirstGiant = 0 Then
						$troopFirstGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtNumWallbreakers) <> "0" Then
					$troopFirstWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					If $troopFirstWall = 0 Then
						$troopFirstWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtGoblins) <> "0" Then
					$troopFirstGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					If $troopFirstGoblin = 0 Then
						$troopFirstGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtBarbarians) <> "0" Then
					$troopFirstBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $troopFirstBarba = 0 Then
						$troopFirstBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtArchers) <> "0" Then
					$troopFirstArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $troopFirstArch = 0 Then
						$troopFirstArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtArchers) <> "0" And $CurArch > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If $CurArch > 0 Then
						If $ArchEBarrack = 0 Then
							Donate_TrainIt($eArcher, 1)
						ElseIf $ArchEBarrack >= $CurArch Then
							Donate_TrainIt($eArcher, $CurArch)
						Else
							Donate_TrainIt($eArcher, $ArchEBarrack)
						EndIf
					EndIf
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
					$troopSecondGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $troopSecondGiant = 0 Then
						$troopSecondGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtNumWallbreakers) <> "0" Then
					$troopSecondWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					If $troopSecondWall = 0 Then
						$troopSecondWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtGoblins) <> "0" Then
					$troopSecondGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					If $troopSecondGoblin = 0 Then
						$troopSecondGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtBarbarians) <> "0" Then
					$troopSecondBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $troopSecondBarba = 0 Then
						$troopSecondBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					EndIf
				EndIf

				If GUICtrlRead($txtArchers) <> "0" Then
					$troopSecondArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $troopSecondArch = 0 Then
						$troopSecondArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					EndIf
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

	#cs
		If $ichkDarkTroop = 0 Then Return

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

		SetLog("Training Dark Troops...", $COLOR_BLUE)

		For $i = 0 To 1
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop

		Click($DarkBarrackPos[$i][0], $DarkBarrackPos[$i][1]) ;Click Dark Barrack
		If _Sleep(500) Then ExitLoop

		Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x603818, 6), 5) ;Finds Train Troops button
		If IsArray($TrainPos) = False Then
		SetLog("Dark Barrack " & $i + 1 & " is not available", $COLOR_RED)
		If _Sleep(500) Then ExitLoop
		Else
		Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
		If _Sleep(800) Then ExitLoop

		If $fullArmy Or $FirstDarkTrain Then
		If Not _ColorCheck(_GetPixelColor(497, 195), Hex(0xE0E4D0, 6), 20) Then
		Click(496, 190, 80, 2)
		EndIf
		EndIf

		;Dark Barrack 1
		If GUICtrlRead($txtDarkBarrack1) <> "0" And $i = 0 And $TrainDrax1 Then
		$itxtDarkBarrack1 = GUICtrlRead($txtDarkBarrack1)
		If $DarkBarrackTroop[$i] = 0 Then
		Local $troopMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
		If $itxtDarkBarrack1 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eMinion, $itxtDarkBarrack1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
		ElseIf $itxtDarkBarrack1 > 20 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eMinion, 20)
		$LeftRax1 = ($itxtDarkBarrack1 - 20)
		$ClickRax1 = $LeftRax1
		SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
		ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 > ($troopMinion < 20) Then
		Donate_TrainIt($eMinion, (20 - $troopMinion))
		$LeftRax1 = ($ClickRax1 - (20 - $troopMinion))
		$ClickRax1 = $LeftRax1
		SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
		ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 <= ($troopMinion < 20) Then
		Donate_TrainIt($eMinion, $LeftRax1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
		ElseIf $LeftRax1 <= 1 And ($troopMinion < 20) Then
		Donate_TrainIt($eMinion, $LeftRax1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
		Else
		SetLog("Dark Barrack 1 Training in progress, Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 1 Then
		Local $troopHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
		If $itxtDarkBarrack1 <= 10 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eHog, $itxtDarkBarrack1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
		ElseIf $itxtDarkBarrack1 > 10 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eHog, 10)
		$LeftRax1 = ($itxtDarkBarrack1 - 10)
		$ClickRax1 = $LeftRax1
		SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
		ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 > ($troopHog < 10) Then
		Donate_TrainIt($eHog, (10 - $troopHog))
		$LeftRax1 = ($ClickRax1 - (10 - $troopHog))
		$ClickRax1 = $LeftRax1
		SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
		ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 <= ($troopHog < 10) Then
		Donate_TrainIt($eHog, $LeftRax1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
		ElseIf $LeftRax1 <= 1 And ($troopHog < 10) Then
		Donate_TrainIt($eHog, $LeftRax1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
		Else
		SetLog("Dark Barrack 1 Training in progress, Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 2 Then
		Local $troopValkyrie = Number(getOther(171 + 107 * 2, 278, "Barrack"))
		If $itxtDarkBarrack1 <= 7 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eValkyrie, $itxtDarkBarrack1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
		ElseIf $itxtDarkBarrack1 > 7 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eValkyrie, 7)
		$LeftRax1 = ($itxtDarkBarrack1 - 7)
		$ClickRax1 = $LeftRax1
		SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
		ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 > ($troopValkyrie < 7) Then
		Donate_TrainIt($eValkyrie, (7 - $troopValkyrie))
		$LeftRax1 = ($ClickRax1 - (7 - $troopValkyrie))
		$ClickRax1 = $LeftRax1
		SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
		ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 <= ($troopValkyrie < 7) Then
		Donate_TrainIt($eValkyrie, $LeftRax1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
		ElseIf $LeftRax1 <= 1 And ($troopValkyrie < 7) Then
		Donate_TrainIt($eValkyrie, $LeftRax1)
		$TrainDrax1 = False
		SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
		Else
		SetLog("Dark Barrack 1 Training in progress, Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
		EndIf
		EndIf
		EndIf

		;Dark Barrack 2
		If GUICtrlRead($txtDarkBarrack2) <> "0" And $i = 1 And $TrainDrax2 Then
		$itxtDarkBarrack1 = GUICtrlRead($txtDarkBarrack1)
		If $DarkBarrackTroop[$i] = 0 Then
		Local $troopMinion2 = Number(getOther(171 + 107 * 0, 278, "Barrack"))
		If $itxtDarkBarrack2 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eMinion, $itxtDarkBarrack2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
		ElseIf $itxtDarkBarrack2 > 20 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eMinion, 20)
		$LeftRax2 = ($itxtDarkBarrack2 - 20)
		$ClickRax2 = $LeftRax2
		SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
		ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 > ($troopMinion2 < 20) Then
		Donate_TrainIt($eMinion, (20 - $troopMinion2))
		$LeftRax2 = ($ClickRax2 - (20 - $troopMinion2))
		$ClickRax2 = $LeftRax2
		SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
		ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 <= ($troopMinion2 < 20) Then
		Donate_TrainIt($eMinion, $LeftRax2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
		ElseIf $LeftRax2 <= 1 And ($troopMinion2 < 20) Then
		Donate_TrainIt($eMinion, $LeftRax2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
		Else
		SetLog("Dark Barrack 2 Training in progress, Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 1 Then
		Local $troopHog2 = Number(getOther(171 + 107 * 1, 278, "Barrack"))
		If $itxtDarkBarrack2 <= 10 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eHog, $itxtDarkBarrack2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
		ElseIf $itxtDarkBarrack2 > 10 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eHog, 10)
		$LeftRax2 = ($itxtDarkBarrack2 - 10)
		$ClickRax2 = $LeftRax2
		SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
		ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 > ($troopHog2 < 10) Then
		Donate_TrainIt($eHog, (10 - $troopHog2))
		$LeftRax2 = ($ClickRax2 - (10 - $troopHog2))
		$ClickRax2 = $LeftRax2
		SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
		ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 <= ($troopHog2 < 10) Then
		Donate_TrainIt($eHog, $LeftRax2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
		ElseIf $LeftRax2 <= 1 And ($troopHog2 < 10) Then
		Donate_TrainIt($eHog, $LeftRax2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
		Else
		SetLog("Dark Barrack 2 Training in progress, Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
		EndIf
		EndIf

		If $DarkBarrackTroop[$i] = 2 Then
		Local $troopValkyrie2 = Number(getOther(171 + 107 * 2, 278, "Barrack"))
		If $itxtDarkBarrack2 <= 7 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eValkyrie, $itxtDarkBarrack2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
		ElseIf $itxtDarkBarrack2 > 7 And ($fullArmy Or $FirstDarkTrain) Then
		Donate_TrainIt($eValkyrie, 7)
		$LeftRax2 = ($itxtDarkBarrack2 - 7)
		$ClickRax2 = $LeftRax2
		SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
		ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 > ($troopValkyrie2 < 7) Then
		Donate_TrainIt($eValkyrie, (7 - $troopValkyrie2))
		$LeftRax2 = ($ClickRax2 - (7 - $troopValkyrie2))
		$ClickRax2 = $LeftRax2
		SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
		ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 <= ($troopValkyrie2 < 7) Then
		Donate_TrainIt($eValkyrie, $LeftRax2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
		ElseIf $LeftRax2 <= 1 And ($troopValkyrie2 < 7) Then
		Donate_TrainIt($eValkyrie, $LeftRax2)
		$TrainDrax2 = False
		SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
		Else
		SetLog("Dark Barrack 2 Training in progress, Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
		EndIf
		EndIf
		EndIf

		EndIf
		If _Sleep(100) Then ExitLoop
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
		Next
		SetLog("Dark Troop Training Complete...", $COLOR_BLUE)
		$FirstDarkTrain = False
	#ce
EndFunc   ;==>Donate_Train
