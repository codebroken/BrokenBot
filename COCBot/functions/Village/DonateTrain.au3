;Uses the location of manually set Barracks to train specified troops

; Train the troops (Fill the barracks)

Func Donate_GetDETroopTotals()
; calculates the total of each DE troop to be trained
	Global $totalMinions = 0
	Global $totalHogs = 0
	Global $totalValkyries = 0

	$DarkBarrackTroop[0] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1)
	$DarkBarrackTroop[1] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2)

	$DarkBarrackTroopNext[0] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1Next)
	$DarkBarrackTroopNext[1] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2Next)

	If $DarkBarrackTroop[0] = 0 Then $totalMinions += GUICtrlRead($txtDarkBarrack1)
	If $DarkBarrackTroopNext[0] = 0 Then $totalMinions += GUICtrlRead($txtDarkBarrack1Next)
	If $DarkBarrackTroop[1] = 0 Then $totalMinions += GUICtrlRead($txtDarkBarrack2)
	If $DarkBarrackTroopNext[1] = 0 Then $totalMinions += GUICtrlRead($txtDarkBarrack2Next)

	If $DarkBarrackTroop[0] = 1 Then $totalHogs += GUICtrlRead($txtDarkBarrack1)
	If $DarkBarrackTroopNext[0] = 1 Then $totalHogs += GUICtrlRead($txtDarkBarrack1Next)
	If $DarkBarrackTroop[1] = 1 Then $totalHogs += GUICtrlRead($txtDarkBarrack2)
	If $DarkBarrackTroopNext[1] = 1 Then $totalHogs += GUICtrlRead($txtDarkBarrack2Next)

	If $DarkBarrackTroop[0] = 2 Then $totalValkyries += GUICtrlRead($txtDarkBarrack1)
	If $DarkBarrackTroopNext[0] = 2 Then $totalValkyries += GUICtrlRead($txtDarkBarrack1Next)
	If $DarkBarrackTroop[1] = 2 Then $totalValkyries += GUICtrlRead($txtDarkBarrack2)
	If $DarkBarrackTroopNext[1] = 2 Then $totalValkyries += GUICtrlRead($txtDarkBarrack2Next)

EndFunc   ;==>Donate_GetDETroopTotals

Func Donate_GetTrainPos($troopKind)
	Switch $TroopKind
		Case $eBarbarian ; 261, 366: 0x39D8E0
			Return $TrainBarbarian
		Case $eArcher ; 369, 366: 0x39D8E0
			Return $TrainArcher
		Case $eGiant ; 475, 366: 0x3DD8E0
			Return $TrainGiant
		Case $eGoblin ; 581, 366: 0x39D8E0
			Return $TrainGoblin
		Case $eWallbreaker ; 635, 335, 0x3AD8E0
			Return $TrainWallbreaker
		Case $eMinion
			Return $TrainMinion
		Case $eHog
			Return $TrainHog
		Case $eValkyrie
			Return $TrainValkyrie
		Case Else
			SetLog(GetLangText("msgDontKnow") & $TroopKind & GetLangText("msgYet"))
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

Func Donate_GetTrainPosDll()
	$res = CallHelper("170 290 700 500 BrokenBotMatchObject 200 6 0")

	If $res <> $DLLFailed And $res <> $DLLTimeout Then
		If $res = $DLLLicense or $res = $DLLError Then
			SetLog(GetLangText("msgLicense"), $COLOR_RED)
		ElseIf $res = $DLLNegative Then
			; failed to find training buttons
			SetLog(GetLangText("Failed finding troop training..."), $COLOR_RED)
			Return False
		Else
			$expRet = StringSplit($res, "|", 2)
			$numTroops = $expRet[0]
			$foundMinion = false
			$foundHog = false
			$foundValkyrie = false
			For $j = 1 To UBound($expRet) - 1 Step 6
				$ResX = $expRet[$j] + 170
				$ResY = $expRet[$j + 1] + 290
				$ResID = $expRet[$j + 4]
				If $ResX = 0 And $ResY = 0 Then ExitLoop

				;Only deal with minions, hogs, valks for now
				If $ResID = 11 Then ;minions
					$foundMinion = true
					$TrainMinionDll[0] = $ResX
					$TrainMinionDll[1] = $ResY
				ElseIf $ResID = 12 Then ;hogs
					$foundHog = true
					$TrainHogDll[0] = $ResX
					$TrainHogDll[1] = $ResY
				ElseIf $ResID = 13 Then ;valks
					$foundValkyrie = true
					$TrainValkyrieDll[0] = $ResX
					$TrainValkyrieDll[1] = $ResY
				EndIf
			Next

			If Not $foundMinion Then
				$TrainMinionDll[0] = -1
				$TrainMinionDll[1] = -1
			EndIf

			If Not $foundHog Then
				$TrainHogDll[0] = -1
				$TrainHogDll[1] = -1
			EndIf

			If Not $foundValkyrie Then
				$TrainValkyrieDll[0] = -1
				$TrainValkyrieDll[1] = -1
			EndIf

			If $DebugMode = 2 Then
				SetLog("Minions: X:" & $TrainMinionDll[0] & " Y:" & $TrainMinionDll[1])
				SetLog("Hogs: X:" & $TrainHogDll[0] & " Y:" & $TrainHogDll[1])
				SetLog("Valkyries: X:" & $TrainValkyrieDll[0] & " Y:" & $TrainValkyrieDll[1])
			EndIf

			Return True
		EndIf
	Else
		SetLog(GetLangText("msgDLLError"), $COLOR_RED)
		$ResX = 0
		$ResY = 0
		Return False ; return 0
	EndIf
EndFunc   ;==>Donate_GetTrainPosDll

Func Donate_TrainItDll($TroopKind, $howMuch = 1, $iSleep = 100)
	Switch $TroopKind
		Case $eMinion
			$pos = $TrainMinionDll
		Case $eHog
			$pos = $TrainHogDll
		Case $eValkyrie
			$pos = $TrainValkyrieDll
		Case Else
			SetLog(GetLangText("msgDontKnow") & $TroopKind & GetLangText("msgYet"))
			Return
	EndSwitch
	If $pos[0] <> -1 Then
		ClickP($pos, $howMuch, 20)
		If _Sleep($iSleep) Then Return False
		Return True
	EndIf

EndFunc   ;==>Donate_TrainItDll

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
		$CurMinion = 0
		$CurHog = 0
		$CurValkyrie = 0
	EndIf

	If (($ArmyComp = 0) And (_GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 8)) Or $FixTrain Then
		If $FixTrain Or $FirstStart And Not $reset Then $ArmyComp = $CurCamp
		$FixTrain = False
		Donate_GetDETroopTotals()
		$CurGiant += GUICtrlRead($txtNumGiants)
		$CurWB += GUICtrlRead($txtNumWallbreakers)
		$CurMinion += $totalMinions
		$CurHog += $totalHogs
		$CurValkyrie += $totalValkyries
		$CurArch += Floor((($itxtcampCap * GUICtrlRead($cmbRaidcap) / 100) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers)) * 2 - ($totalMinions * 2) - ($totalHogs * 5) - ($totalValkyries * 8)) * (GUICtrlRead($txtArchers) / 100))
		$CurBarb += Floor((($itxtcampCap * GUICtrlRead($cmbRaidcap) / 100) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers)) * 2 - ($totalMinions * 2) - ($totalHogs * 5) - ($totalValkyries * 8)) * (GUICtrlRead($txtBarbarians) / 100))
		$CurGoblin += Floor((($itxtcampCap * GUICtrlRead($cmbRaidcap) / 100) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers)) * 2 - ($totalMinions * 2) - ($totalHogs * 5) - ($totalValkyries * 8)) * (GUICtrlRead($txtGoblins) / 100))
;~ 		SetLog("CurArch" & $CurArch & "one: " & $itxtcampCap & ":" & GUICtrlRead($cmbRaidcap) & "two :" & (GUICtrlRead($txtNumGiants) * 5) & "three:" & (GUICtrlRead($txtNumWallbreakers) * 2) & "four:" & (GUICtrlRead($txtArchers) / 100))
;~ 		SetLog("CurBarb" & $CurBarb)
;~ 		SetLog("CurGoblin" & $CurGoblin)
		If $CurArch < 0 Then $CurArch = 0
		If $CurBarb < 0 Then $CurBarb = 0
		If $CurGoblin < 0 Then $CurGoblin = 0
		If $CurWB < 0 Then $CurWB = 0
		If $CurGiant < 0 Then $CurGiant = 0
		If $CurMinion < 0 Then $CurMinion = 0
		If $CurHog < 0 Then $CurHog = 0
		If $CurValkyrie < 0 Then $CurValkyrie = 0

		If ($CurArch + $CurBarb + $CurGoblin + (5 * $CurGiant) + (2 * $CurWB) + (2 * $CurMinion) + (5 * $CurHog) + (8 * $CurValkyrie)) < $itxtcampCap Then
			If $CurArch > 0 Then
				$CurArch += 1
			EndIf
			If ($CurArch + $CurBarb + $CurGoblin + (5 * $CurGiant) + (2 * $CurWB) + (2 * $CurMinion) + (5 * $CurHog) + (8 * $CurValkyrie)) < $itxtcampCap Then
				If $CurBarb > 0 Then
					$CurBarb += 1
				EndIf
				If ($CurArch + $CurBarb + $CurGoblin + (5 * $CurGiant) + (2 * $CurWB) + (2 * $CurMinion) + (5 * $CurHog) + (8 * $CurValkyrie)) < $itxtcampCap Then
					If $CurGoblin > 0 Then
						$CurGoblin += 1
					EndIf
				EndIf
			EndIf
		EndIf
		SetLog(GetLangText("msgForcesNeededB") & $CurBarb & GetLangText("msgForcesNeededA") & $CurArch & GetLangText("msgForcesNeededGo") & $CurGoblin & GetLangText("msgForcesNeededGi") & $CurGiant & GetLangText("msgForcesNeededWB") & $CurWB, $COLOR_GREEN)

	ElseIf (($ArmyComp = 0) And (_GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8)) Or $FixTrain Then
		Donate_GetDETroopTotals()
		$CurMinion += $totalMinions
		$CurHog += $totalHogs
		$CurValkyrie += $totalValkyries
		If $CurMinion < 0 Then $CurMinion = 0
		If $CurHog < 0 Then $CurHog = 0
		If $CurValkyrie < 0 Then $CurValkyrie = 0
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

	For $i = 0 To 3
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop

		Click($barrackPos[$i][0], $barrackPos[$i][1]) ;Click Barrack
		If _Sleep(500) Then ExitLoop

		$expUIRet[0] = -1
		$resUI = CallHelper("0 0 860 720 BrokenBotMatchButton 108 1 3")
		If $resUI <> $DLLFailed And $resUI <> $DLLTimeout Then
			If $resUI = $DLLNegative or $resUI = $DLLError Then
				; Didn't find button
			ElseIf $resUI = $DLLLicense Then
				SetLog(GetLangText("msgLicense"), $COLOR_RED)
			Else
				$expUIRet = StringSplit($resUI, "|", 2)
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
				Local $safeguarding = 0
				Switch _GUICtrlComboBox_GetCurSel($BarrackControl)
					Case 0
						While _ColorCheck(_GetPixelColor(216, 325), Hex(0xF09D1C, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(216, 325, 75) ;Barbarian
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 1
						While _ColorCheck(_GetPixelColor(330, 323), Hex(0xE84070, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(325, 320, 75) ;Archer
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 2
						While _ColorCheck(_GetPixelColor(419, 319), Hex(0xF88409, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(419, 319, 20) ;Giant
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 3
						While _ColorCheck(_GetPixelColor(549, 328), Hex(0xFB4C24, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(535, 320, 75) ;Goblin
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 4
						While _ColorCheck(_GetPixelColor(685, 327), Hex(0x9E4716, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(641, 341, 20) ;Wall Breaker
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 5
						While _ColorCheck(_GetPixelColor(213, 418), Hex(0x861F15, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(213, 418, 20) ;Balloon
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 6
						While _ColorCheck(_GetPixelColor(340, 449), Hex(0xF09C85, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(325, 425, 20) ;Wizard
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 7
						While _ColorCheck(_GetPixelColor(440, 445), Hex(0xFDD8C0, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(440, 445, 10) ;Healer
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 8
						While _ColorCheck(_GetPixelColor(539, 444), Hex(0x302848, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
							Click(539, 444, 10) ;Dragon
							If _Sleep(150) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 9
						While _ColorCheck(_GetPixelColor(647, 440), Hex(0x456180, 6), 30) And ($safeguarding < 200)
							$safeguarding += 1
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


				;Check to see if we are stuck or done with training by trying to locate the "[!] All Camps Full!"
				$checkFull = _PixelSearch(374, 146, 423, 163, Hex(0xE84D50,6), 5)
				If IsArray($checkFull) Then
					$barracksCampFull = True
					$FirstStart = False
					If _Sleep(100) Then ExitLoop
					Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
					Return
				EndIf

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
					$troopSecondGiant = StringStripWS(ReadText(181 + (2 * 107), 298, 35, $textWindows),3)
					If StringRight($troopSecondGiant, 1) = "x" Then
					   $troopSecondGiant = StringLeft($troopSecondGiant, StringLen($troopSecondGiant) - 1)
				    Else
					 $troopSecondGiant = 0
					EndIf
				EndIf

				If GUICtrlRead($txtNumWallbreakers) <> "0" Then
					$troopSecondWall = StringStripWS(ReadText(181 + (4 * 107), 298, 35, $textWindows),3)
					If StringRight($troopSecondWall, 1) = "x" Then
					   $troopSecondWall = StringLeft($troopSecondWall, StringLen($troopSecondWall) - 1)
					Else
					   $troopSecondWall = 0
					EndIf
				EndIf

				If GUICtrlRead($txtGoblins) <> "0" Then
					$troopSecondGoblin = StringStripWS(ReadText(181 + (3* 107), 298, 35, $textWindows),3)
					If StringRight($troopSecondGoblin, 1) = "x" Then
						$troopSecondGoblin = StringLeft($troopSecondGoblin, StringLen($troopSecondGoblin) - 1)
					Else
						$troopSecondGoblin = 0
					EndIf
				EndIf

				If GUICtrlRead($txtBarbarians) <> "0" Then
					$troopSecondBarba = StringStripWS(ReadText(181, 298, 35, $textWindows),3)
					If StringRight($troopSecondBarba, 1) = "x" Then
					   $troopSecondBarba = StringLeft($troopSecondBarba, StringLen($troopSecondBarba) - 1)
					Else
						$troopSecondBarba = 0
					EndIf
				EndIf

				If GUICtrlRead($txtArchers) <> "0" Then
					$troopSecondArch = StringStripWS(ReadText(181 + 107, 298, 35, $textWindows),3)
					If StringRight($troopSecondArch, 1) = "x" Then
					   $troopSecondArch = StringLeft($troopSecondArch, StringLen($troopSecondArch) - 1)
					Else
					   $troopSecondArch = 0
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

;~ 	BEGIN DARK TROOPS
	$ichkDarkTroop = Not (($DarkBarrackTroop[0] = 3 And $DarkBarrackTroop[1] = 3 And $DarkBarrackTroopNext[0] = 3 And $DarkBarrackTroopNext[0] = 3) Or (GUICtrlRead($txtDarkBarrack1) + GUICtrlRead($txtDarkBarrack2) + GUICtrlRead($txtDarkBarrack1Next) + GUICtrlRead($txtDarkBarrack2Next) = 0))
 	If $ichkDarkTroop = False Then
		$FirstStart = False
		Return
	EndIf
	$DarkBarrackTroop[0] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1)
	$DarkBarrackTroop[1] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2)

	$DarkBarrackTroopNext[0] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1Next)
	$DarkBarrackTroopNext[1] = _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2Next)



 	Local $TrainPos[2]
 	If $DarkBarrackPos[0][0] = "" And GUICtrlRead($txtDarkBarrack1) <> "0" And GUICtrlRead($txtDarkBarrack2) <> "0" Then
 		LocateDarkBarrack()
 		SaveConfig()
 		If _Sleep(2000) Then Return
 	EndIf

 	Global $LeftRax1, $LeftRax2, $TrainDrax1, $TrainDrax2, $ClickRax1, $ClickRax2
	Global $LeftRax1Next, $LeftRax2Next, $TrainDrax1Next, $TrainDrax2Next, $ClickRax1Next, $ClickRax2Next
	Global $FirstDarkTrain, $FirstDarkTrain2, $FirstDarkTrainNext, $FirstDarkTrain2Next

 	If $fullArmy Or $FirstStart Then
		$TrainDrax1 = True
		$TrainDrax2 = True
		$TrainDrax1Next = True
		$TrainDrax2Next = True
		$FirstDarkTrain = true
		$FirstDarkTrain2 = true
		$FirstDarkTrainNext = true
		$FirstDarkTrain2Next = true
 	EndIf

 	If $TrainDrax1 = False And $TrainDrax2 = False And $TrainDrax1Next = False And $TrainDrax2Next = False Then Return

 	SetLog(GetLangText("msgTrainingDark"), $COLOR_BLUE)

	If $fullArmy Or $FirstStart Then
		SetLog("Forces Needed: Minions-" & $CurMinion & ", Hogs-" & $CurHog & ", Valks-" & $CurValkyrie, $COLOR_GREEN)
	EndIf


 	For $i = 0 To 1
 		If _Sleep(500) Then ExitLoop

 		ClickP($TopLeftClient) ;Click Away

 		If _Sleep(500) Then ExitLoop
 		Click($DarkBarrackPos[$i][0], $DarkBarrackPos[$i][1]) ;Click Dark Barrack
 		If _Sleep(500) Then ExitLoop

		$res = CallHelper("0 0 860 720 BrokenBotMatchObject 108 3 0")
 		If $res <> $DLLFailed And $res <> $DLLTimeout Then
			If $res = $DLLNegative or $res = $DLLError Then
 			   SetLog(GetLangText("msgDarkBarrack") & $i + 1 & GetLangText("msgNotAvailable"), $COLOR_RED)
 			   Return
 			ElseIf $res = $DLLLicense Then
 				SetLog(GetLangText("msgLicense"), $COLOR_RED)
 			Else
 			   $expUIRet = StringSplit($res, "|", 2)
 			   $TrainPos[0] = $expUIRet[1]
 			   $TrainPos[1] = $expUIRet[2]
 			   If $DebugMode = 2 Then SetLog("DB Train:" & $TrainPos[0] & " Y:" & $TrainPos[1])
 			EndIf
 	    EndIf
 		Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
 		If _Sleep(800) Then ExitLoop

 		If $fullArmy Or $FirstStart Then ;Reset troops on first loop, or if army is full to start cooking for next attack
			_CaptureRegion()
			If Not _ColorCheck(_GetPixelColor(502, 179), Hex(0xD1D0C2, 6), 20) Then
				Click(502, 179, 80, 2)
			EndIf
 		EndIf

		;Check to see if we are stuck or done with training by trying to locate the "[!] All Camps Full!"
		$checkFull = _PixelSearch(374, 146, 423, 163, Hex(0xE84D50,6), 5)
		If IsArray($checkFull) Then
			$barracksCampFull = True
			$FirstStart = False
			If _Sleep(100) Then ExitLoop
			Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
			Return
		EndIf

		Donate_GetTrainPosDll()

 		;Dark Barrack 1
 		If GUICtrlRead($txtDarkBarrack1) <> "0" And $i = 0 And $TrainDrax1 = True Then
			$itxtDarkBarrack1 = GUICtrlRead($txtDarkBarrack1)
			If $DarkBarrackTroop[$i] = 0 Then
				$itxtDarkBarrack1 = Floor(($itxtDarkBarrack1 / $totalMinions) * $CurMinion)

				Local $troopMinion = StringStripWS(ReadText(181, 298, 35, $textWindows),3)
				If StringRight($troopMinion, 1) = "x" Then $troopMinion = StringLeft($troopMinion, StringLen($troopMinion) - 1)
				;SetLog($troopMinion & " Minions training already", $COLOR_BLUE)

				If $itxtDarkBarrack1 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
				   Donate_TrainItDll($eMinion, $itxtDarkBarrack1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $itxtDarkBarrack1 > 20 And ($fullArmy Or $FirstDarkTrain) Then
				   Donate_TrainItDll($eMinion, 20)
				   $LeftRax1 = ($itxtDarkBarrack1 - 20)
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 > ($troopMinion < 20) Then
				   Donate_TrainItDll($eMinion, (20 - $troopMinion))
				   $LeftRax1 = ($ClickRax1 - (20 - $troopMinion))
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 <= ($troopMinion < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 <= 1 And ($troopMinion < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				Else
					SetLog("Dark Barrack 1 Training in progress, Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
					$FirstDarkTrain = False
				EndIf
			EndIf

			If $DarkBarrackTroop[$i] = 1 Then
				$itxtDarkBarrack1 = Floor(($itxtDarkBarrack1 / $totalHogs) * $CurHog)

				Local $troopHog = StringStripWS(ReadText(181 + 107, 298, 35, $textWindows),3)
				If StringRight($troopHog, 1) = "x" Then $troopHog = StringLeft($troopHog, StringLen($troopHog) - 1)
				;SetLog($troopHog & " Hogs training already", $COLOR_BLUE)

				If $itxtDarkBarrack1 <= 10 And ($fullArmy Or $FirstDarkTrain) Then
				   Donate_TrainItDll($eHog, $itxtDarkBarrack1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $itxtDarkBarrack1 > 10 And ($fullArmy Or $FirstDarkTrain) Then
				   Donate_TrainItDll($eHog, 10)
				   $LeftRax1 = ($itxtDarkBarrack1 - 10)
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 > ($troopHog < 10) Then
				   Donate_TrainItDll($eHog, (10 - $troopHog))
				   $LeftRax1 = ($ClickRax1 - (10 - $troopHog))
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 <= ($troopHog < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 <= 1 And ($troopHog < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				Else
				   SetLog("Dark Barrack 1 Training in progress, Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				EndIf
			EndIf

			If $DarkBarrackTroop[$i] = 2 Then
				$itxtDarkBarrack1 = Floor(($itxtDarkBarrack1 / $totalValkyries) * $CurValkyrie)
				Local $troopValkyrie = StringStripWS(ReadText(181 + 107 * 2, 298, 35, $textWindows),3)
				If StringRight($troopValkyrie, 1) = "x" Then $troopValkyrie = StringLeft($troopValkyrie, StringLen($troopValkyrie) - 1)
				;SetLog($troopValkyrie & " Valkyries training already", $COLOR_BLUE)

				If $itxtDarkBarrack1 <= 7 And ($fullArmy Or $FirstDarkTrain) Then
				   Donate_TrainItDll($eValkyrie, $itxtDarkBarrack1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $itxtDarkBarrack1 > 7 And ($fullArmy Or $FirstDarkTrain) Then
				   Donate_TrainItDll($eValkyrie, 7)
				   $LeftRax1 = ($itxtDarkBarrack1 - 7)
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 > ($troopValkyrie < 7) Then
				   Donate_TrainItDll($eValkyrie, (7 - $troopValkyrie))
				   $LeftRax1 = ($ClickRax1 - (7 - $troopValkyrie))
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 <= ($troopValkyrie < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 <= 1 And ($troopValkyrie < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				Else
				   SetLog("Dark Barrack 1 Training in progress, Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				EndIf
			EndIf
 		EndIf

		;Second Troop type
		If GUICtrlRead($txtDarkBarrack1Next) <> "0" And $i = 0 And $TrainDrax1Next = True Then
			$itxtDarkBarrack1Next = GUICtrlRead($txtDarkBarrack1Next)
			If $DarkBarrackTroopNext[$i] = 0 Then
				$itxtDarkBarrack1Next = Floor(($itxtDarkBarrack1Next / $totalMinions) * $CurMinion)
				Local $troopMinion = StringStripWS(ReadText(181, 298, 35, $textWindows),3)
				If StringRight($troopMinion, 1) = "x" Then $troopMinion = StringLeft($troopMinion, StringLen($troopMinion) - 1)
				;SetLog($troopMinion & " Minions training already", $COLOR_BLUE)

				If $itxtDarkBarrack1Next <= 20 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Donate_TrainItDll($eMinion, $itxtDarkBarrack1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $itxtDarkBarrack1Next > 20 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Donate_TrainItDll($eMinion, 20)
				   $LeftRax1Next = ($itxtDarkBarrack1Next - 20)
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopMinion < 20) And $LeftRax1Next > ($troopMinion < 20) Then
				   Donate_TrainItDll($eMinion, (20 - $troopMinion))
				   $LeftRax1Next = ($ClickRax1Next - (20 - $troopMinion))
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopMinion < 20) And $LeftRax1Next <= ($troopMinion < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next <= 1 And ($troopMinion < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				Else
					SetLog("Dark Barrack 1 Training in progress, Minion Remaining : " & $LeftRax1Next, $COLOR_BLUE)
					$FirstDarkTrainNext = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 1 Then
				$itxtDarkBarrack1Next = Floor(($itxtDarkBarrack1Next / $totalHogs) * $CurHog)
				Local $troopHog = StringStripWS(ReadText(181 + 107, 298, 35, $textWindows),3)
				If StringRight($troopHog, 1) = "x" Then $troopHog = StringLeft($troopHog, StringLen($troopHog) - 1)
				;SetLog($troopHog & " Hogs training already", $COLOR_BLUE)

				If $itxtDarkBarrack1Next <= 10 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Donate_TrainItDll($eHog, $itxtDarkBarrack1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $itxtDarkBarrack1Next > 10 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Donate_TrainItDll($eHog, 10)
				   $LeftRax1Next = ($itxtDarkBarrack1Next - 10)
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopHog < 10) And $LeftRax1Next > ($troopHog < 10) Then
				   Donate_TrainItDll($eHog, (10 - $troopHog))
				   $LeftRax1Next = ($ClickRax1Next - (10 - $troopHog))
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopHog < 10) And $LeftRax1Next <= ($troopHog < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next <= 1 And ($troopHog < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				Else
				   SetLog("Dark Barrack 1 Training in progress, Hog Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 2 Then
				$itxtDarkBarrack1Next = Floor(($itxtDarkBarrack1Next / $totalValkyries) * $CurValkyrie)
				Local $troopValkyrie = StringStripWS(ReadText(181 + 107 * 2, 298, 35, $textWindows),3)
				If StringRight($troopValkyrie, 1) = "x" Then $troopValkyrie = StringLeft($troopValkyrie, StringLen($troopValkyrie) - 1)
				;SetLog($troopValkyrie & " Valkyries training already", $COLOR_BLUE)

				If $itxtDarkBarrack1Next <= 7 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Donate_TrainItDll($eValkyrie, $itxtDarkBarrack1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $itxtDarkBarrack1Next > 7 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Donate_TrainItDll($eValkyrie, 7)
				   $LeftRax1Next = ($itxtDarkBarrack1Next - 7)
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopValkyrie < 7) And $LeftRax1Next > ($troopValkyrie < 7) Then
				   Donate_TrainItDll($eValkyrie, (7 - $troopValkyrie))
				   $LeftRax1Next = ($ClickRax1Next - (7 - $troopValkyrie))
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopValkyrie < 7) And $LeftRax1Next <= ($troopValkyrie < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next <= 1 And ($troopValkyrie < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				Else
				   SetLog("Dark Barrack 1 Training in progress, Valkyrie Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				EndIf
			EndIf
 		EndIf

 		;Dark Barrack 2
 		If GUICtrlRead($txtDarkBarrack2) <> "0" And $i = 1 And $TrainDrax2 = True Then
			$itxtDarkBarrack2 = GUICtrlRead($txtDarkBarrack2)
			If $DarkBarrackTroop[$i] = 0 Then
				$itxtDarkBarrack2 = Ceiling(($itxtDarkBarrack2 / $totalMinions) * $CurMinion)
				Local $troopMinion2 = StringStripWS(ReadText(181, 298, 35, $textWindows),3)
				If StringRight($troopMinion2, 1) = "x" Then $troopMinion2 = StringLeft($troopMinion2, StringLen($troopMinion2) - 1)
				;SetLog($troopMinion2 & " Minions training already", $COLOR_BLUE)

				If $itxtDarkBarrack2 <= 20 And ($fullArmy Or $FirstDarkTrain2) Then
				   Donate_TrainItDll($eMinion, $itxtDarkBarrack2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $itxtDarkBarrack2 > 20 And ($fullArmy Or $FirstDarkTrain2) Then
				   Donate_TrainItDll($eMinion, 20)
				   $LeftRax2 = ($itxtDarkBarrack2 - 20)
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 > ($troopMinion2 < 20) Then
				   Donate_TrainItDll($eMinion, (20 - $troopMinion2))
				   $LeftRax2 = ($ClickRax2 - (20 - $troopMinion2))
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 <= ($troopMinion2 < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 <= 1 And ($troopMinion2 < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				EndIf
			EndIf

			If $DarkBarrackTroop[$i] = 1 Then
				$itxtDarkBarrack2 = Ceiling(($itxtDarkBarrack2 / $totalHogs) * $CurHog)
				Local $troopHog2 = StringStripWS(ReadText(181 + 107, 298, 35, $textWindows),3)
				If StringRight($troopHog2, 1) = "x" Then $troopHog2 = StringLeft($troopHog2, StringLen($troopHog2) - 1)
				;SetLog($troopHog2 & " Hogs training already", $COLOR_BLUE)


				If $itxtDarkBarrack2 <= 10 And ($fullArmy Or $FirstDarkTrain2) Then
				   Donate_TrainItDll($eHog, $itxtDarkBarrack2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $itxtDarkBarrack2 > 10 And ($fullArmy Or $FirstDarkTrain2) Then
				   Donate_TrainItDll($eHog, 10)
				   $LeftRax2 = ($itxtDarkBarrack2 - 10)
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 > ($troopHog2 < 10) Then
				   Donate_TrainItDll($eHog, (10 - $troopHog2))
				   $LeftRax2 = ($ClickRax2 - (10 - $troopHog2))
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 <= ($troopHog2 < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 <= 1 And ($troopHog2 < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				EndIf
			EndIf

			If $DarkBarrackTroop[$i] = 2 Then
				$itxtDarkBarrack2 = Ceiling(($itxtDarkBarrack2 / $totalValkyries) * $CurValkyrie)
				Local $troopValkyrie2 = StringStripWS(ReadText(181 + 107 * 2, 298, 35, $textWindows),3)
				If StringRight($troopValkyrie2, 1) = "x" Then $troopValkyrie2 = StringLeft($troopValkyrie2, StringLen($troopValkyrie2) - 1)
				;SetLog($troopValkyrie2 & " Valkyries training already", $COLOR_BLUE)

				If $itxtDarkBarrack2 <= 7 And ($fullArmy Or $FirstDarkTrain2) Then
				   Donate_TrainItDll($eValkyrie, $itxtDarkBarrack2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $itxtDarkBarrack2 > 7 And ($fullArmy Or $FirstDarkTrain2) Then
				   Donate_TrainItDll($eValkyrie, 7)
				   $LeftRax2 = ($itxtDarkBarrack2 - 7)
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 > ($troopValkyrie2 < 7) Then
				   Donate_TrainItDll($eValkyrie, (7 - $troopValkyrie2))
				   $LeftRax2 = ($ClickRax2 - (7 - $troopValkyrie2))
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 <= ($troopValkyrie2 < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 <= 1 And ($troopValkyrie2 < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				EndIf
			EndIf
 		EndIf

		;Second Troop type
		If GUICtrlRead($txtDarkBarrack2Next) <> "0" And $i = 1 And $TrainDrax2Next = True Then
			$itxtDarkBarrack2Next = GUICtrlRead($txtDarkBarrack2Next)
			If $DarkBarrackTroopNext[$i] = 0 Then
				$itxtDarkBarrack2Next = Ceiling(($itxtDarkBarrack2Next / $totalMinions) * $CurMinion)
				Local $troopMinion2 = StringStripWS(ReadText(181, 298, 35, $textWindows),3)
				If StringRight($troopMinion2, 1) = "x" Then $troopMinion2 = StringLeft($troopMinion2, StringLen($troopMinion2) - 1)
				;SetLog($troopMinion2 & " Minions training already", $COLOR_BLUE)

				If $itxtDarkBarrack2Next <= 20 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Donate_TrainItDll($eMinion, $itxtDarkBarrack2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $itxtDarkBarrack2Next > 20 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Donate_TrainItDll($eMinion, 20)
				   $LeftRax2Next = ($itxtDarkBarrack2Next - 20)
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopMinion2 < 20) And $LeftRax2Next > ($troopMinion2 < 20) Then
				   Donate_TrainItDll($eMinion, (20 - $troopMinion2))
				   $LeftRax2Next = ($ClickRax2Next - (20 - $troopMinion2))
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopMinion2 < 20) And $LeftRax2Next <= ($troopMinion2 < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next <= 1 And ($troopMinion2 < 20) Then
				   Donate_TrainItDll($eMinion, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				Else
					SetLog("Dark Barrack 2 Training in progress, Minion Remaining : " & $LeftRax2Next, $COLOR_BLUE)
					$FirstDarkTrain2Next = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 1 Then
				$itxtDarkBarrack2Next = Ceiling(($itxtDarkBarrack2Next / $totalHogs) * $CurHogs)
				Local $troopHog2 = StringStripWS(ReadText(181 + 107, 298, 35, $textWindows),3)
				If StringRight($troopHog2, 1) = "x" Then $troopHog2 = StringLeft($troopHog2, StringLen($troopHog2) - 1)
				;SetLog($troopHog2 & " Hogs training already", $COLOR_BLUE)

				If $itxtDarkBarrack2Next <= 10 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Donate_TrainItDll($eHog, $itxtDarkBarrack2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $itxtDarkBarrack2Next > 10 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Donate_TrainItDll($eHog, 10)
				   $LeftRax2Next = ($itxtDarkBarrack2Next - 10)
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopHog2 < 10) And $LeftRax2Next > ($troopHog2 < 10) Then
				   Donate_TrainItDll($eHog, (10 - $troopHog2))
				   $LeftRax2Next = ($ClickRax2Next - (10 - $troopHog2))
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopHog2 < 10) And $LeftRax2Next <= ($troopHog2 < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next <= 1 And ($troopHog2 < 10) Then
				   Donate_TrainItDll($eHog, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Hog Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 2 Then
				$itxtDarkBarrack2Next = Ceiling(($itxtDarkBarrack2Next / $totalValkyries) * $CurValkyrie)
				Local $troopValkyrie2 = StringStripWS(ReadText(181 + 107 * 2, 298, 35, $textWindows),3)
				If StringRight($troopValkyrie2, 1) = "x" Then $troopValkyrie2 = StringLeft($troopValkyrie2, StringLen($troopValkyrie2) - 1)
				;SetLog($troopValkyrie2 & " Valkyries training already", $COLOR_BLUE)

				If $itxtDarkBarrack2Next <= 7 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Donate_TrainItDll($eValkyrie, $itxtDarkBarrack2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $itxtDarkBarrack2Next > 7 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Donate_TrainItDll($eValkyrie, 7)
				   $LeftRax2Next = ($itxtDarkBarrack2Next - 7)
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopValkyrie2 < 7) And $LeftRax2Next > ($troopValkyrie2 < 7) Then
				   Donate_TrainItDll($eValkyrie, (7 - $troopValkyrie2))
				   $LeftRax2Next = ($ClickRax2Next - (7 - $troopValkyrie2))
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopValkyrie2 < 7) And $LeftRax2Next <= ($troopValkyrie2 < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next <= 1 And ($troopValkyrie2 < 7) Then
				   Donate_TrainItDll($eValkyrie, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Valkyrie Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				EndIf
			EndIf
 		EndIf

 		If _Sleep(100) Then ExitLoop
 		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
    Next
	SetLog(GetLangText("msgDarkTroopComplete"), $COLOR_BLUE)
	$FirstDarkTrain = False
	$FirstDarkTrain2 = False
	$FirstDarkTrainNext = False
	$FirstDarkTrain2Next = False
	$FirstStart = False
;~ 	END DARK TROOPS
EndFunc   ;==>Donate_Train
