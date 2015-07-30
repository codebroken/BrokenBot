;ReadyCheck is in charge of build full army and spell.
;When Army is full, ReadyCheck will Return True
;Hero status check will be done later in the loop, right before start search
Func Standard_ReadyCheck($TimeSinceNewTroop)

	If $TimeSinceNewTroop > Standard_GetTrainTime() + 60 Then
		If $stuckCount < 3 Then
			$FirstStart = True
			SetLog(GetLangText("msgAppearsStuck"))
			$stuckCount += 1
		ElseIf $stuckCount >= 3 Then
			SetLog(GetLangText("msgSevereStuck"))
			$stuckCount += 1
		EndIf
	EndIf

	$fullarmy = Standard_CheckArmyCamp()
	If StatusCheck() Then Return False

	If Not $fullarmy And $stuckCount < 3 Then Standard_Train()
	If StatusCheck() Then Return False

	If IsChecked($chkMakeSpells) Then
		$fullSpellFactory = CheckFullSpellFactory()
		If StatusCheck() Then Return False

		If Not $fullSpellFactory Then Standard_MakeSpells()
		If StatusCheck() Then Return False
	EndIf

	If $stuckCount >= 3 And (IsChecked($chkDeadActivate) Or IsChecked($chkAnyActivate)) Then
		$fullarmy = True
	EndIf

	If $fullarmy And (IsChecked($chkDeadActivate) Or IsChecked($chkAnyActivate)) Then
		Return True
	EndIf

	If IsChecked($chkMakeSpells) Then
		If $fullSpellFactory And IsChecked($chkNukeOnly) And Not IsChecked($chkNukeOnlyWithFullArmy) Then
			Return True
		EndIf
	EndIf

	Return False
EndFunc   ;==>Standard_ReadyCheck

;Quick check before start searching
;Check Hero status
;If last search failed, also check spell status and army status
;If army is not full for some reason, return false, else return true
Func Standard_miniReadyCheck()

	; Verify hero availability
	ChkKingAvailability()
	ChkQueenAvailability()
	If $SearchFailed Then ;Last search failed, do additional checks
		$fullarmy = Standard_CheckArmyCamp()
		If Not $fullarmy And $stuckCount < 3 Then
			Return False ;Troop missing in not stuck situation, exit loop and restart training
		Else
			$fullarmy = True ;Set the flag again, search condition can be properly populated
		EndIf
		If StatusCheck() Then Return False

		If IsChecked($chkMakeSpells) Then
			$fullSpellFactory = CheckFullSpellFactory()
			If StatusCheck() Then Return False
		EndIf
	Else ;SearchFailed=False
		;reset SearchCount only when last search wasn't failed
		$SearchCount = 0
	EndIf

	If Not AdjustSearchCond() Then
		;No search condition is valid
		SetLog(GetLangText("msgHeroNotReady"), $COLOR_PURPLE)

		If $KingUG And _
				Not (IsChecked($chkDeadActivate) And Not IsChecked($chkDeadKingAvail)) And _
				Not (IsChecked($chkAnyActivate) And Not IsChecked($chkKingAvail)) Then
			;King is upgrading, and all enabled search method need king
			SetLog(GetLangText("msgWarningKingUG"), $COLOR_RED)
		EndIf
		If $QueenUG And _
				Not (IsChecked($chkDeadActivate) And Not IsChecked($chkDeadQueenAvail)) And _
				Not (IsChecked($chkAnyActivate) And Not IsChecked($chkQueenAvail)) Then
			;Queen is upgrading, and all enabled search method need king
			SetLog(GetLangText("msgWarningQueenUG"), $COLOR_RED)
		EndIf
		;Since Hero is required and not ready, we'd better wait outside, at lease we can donate.
		;Wait a bit before return, avoid bot being too busy ;)
		_Sleep(20000)
		Return False
	EndIf

	Return True

EndFunc   ;==>Standard_miniReadyCheck


Func Standard_GetTrainTime()
	$MaxTrainTime = 0
	Switch _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		Case 0
			$MaxTrainTime = 25
		Case 1
			$MaxTrainTime = 20
		Case 2
			$MaxTrainTime = 30
		Case 3
			$MaxTrainTime = 25
		Case 4
			$MaxTrainTime = 120
		Case 5
			$MaxTrainTime = 120
		Case 6
			$MaxTrainTime = 30
		Case 7
			$MaxTrainTime = 120
		Case 8
			Switch _GUICtrlComboBox_GetCurSel($cmbBarrack1)
				Case 0
					$MaxTrainTime = 20
				Case 1
					$MaxTrainTime = 25
				Case 2
					$MaxTrainTime = 120
				Case 3
					$MaxTrainTime = 30
				Case 4
					$MaxTrainTime = 120
				Case 5
					$MaxTrainTime = 240
				Case 6
					$MaxTrainTime = 480
				Case 7
					$MaxTrainTime = 900
				Case 8
					$MaxTrainTime = 1800
				Case 9
					$MaxTrainTime = 2700
				Case 10
					$MaxTrainTime = 0
			EndSwitch
			Switch _GUICtrlComboBox_GetCurSel($cmbBarrack2)
				Case 0
					If $MaxTrainTime < 20 Then $MaxTrainTime = 20
				Case 1
					If $MaxTrainTime < 25 Then $MaxTrainTime = 25
				Case 2
					If $MaxTrainTime < 120 Then $MaxTrainTime = 120
				Case 3
					If $MaxTrainTime < 30 Then $MaxTrainTime = 30
				Case 4
					If $MaxTrainTime < 120 Then $MaxTrainTime = 120
				Case 5
					If $MaxTrainTime < 240 Then $MaxTrainTime = 240
				Case 6
					If $MaxTrainTime < 480 Then $MaxTrainTime = 480
				Case 7
					If $MaxTrainTime < 900 Then $MaxTrainTime = 900
				Case 8
					If $MaxTrainTime < 1800 Then $MaxTrainTime = 1800
				Case 9
					If $MaxTrainTime < 2700 Then $MaxTrainTime = 2700
				Case 10
					; Nothing
			EndSwitch
			Switch _GUICtrlComboBox_GetCurSel($cmbBarrack3)
				Case 0
					If $MaxTrainTime < 20 Then $MaxTrainTime = 20
				Case 1
					If $MaxTrainTime < 25 Then $MaxTrainTime = 25
				Case 2
					If $MaxTrainTime < 120 Then $MaxTrainTime = 120
				Case 3
					If $MaxTrainTime < 30 Then $MaxTrainTime = 30
				Case 4
					If $MaxTrainTime < 120 Then $MaxTrainTime = 120
				Case 5
					If $MaxTrainTime < 240 Then $MaxTrainTime = 240
				Case 6
					If $MaxTrainTime < 480 Then $MaxTrainTime = 480
				Case 7
					If $MaxTrainTime < 900 Then $MaxTrainTime = 900
				Case 8
					If $MaxTrainTime < 1800 Then $MaxTrainTime = 1800
				Case 9
					If $MaxTrainTime < 2700 Then $MaxTrainTime = 2700
				Case 10
					; Nothing
			EndSwitch
			Switch _GUICtrlComboBox_GetCurSel($cmbBarrack4)
				Case 0
					If $MaxTrainTime < 20 Then $MaxTrainTime = 20
				Case 1
					If $MaxTrainTime < 25 Then $MaxTrainTime = 25
				Case 2
					If $MaxTrainTime < 120 Then $MaxTrainTime = 120
				Case 3
					If $MaxTrainTime < 30 Then $MaxTrainTime = 30
				Case 4
					If $MaxTrainTime < 120 Then $MaxTrainTime = 120
				Case 5
					If $MaxTrainTime < 240 Then $MaxTrainTime = 240
				Case 6
					If $MaxTrainTime < 480 Then $MaxTrainTime = 480
				Case 7
					If $MaxTrainTime < 900 Then $MaxTrainTime = 900
				Case 8
					If $MaxTrainTime < 1800 Then $MaxTrainTime = 1800
				Case 9
					If $MaxTrainTime < 2700 Then $MaxTrainTime = 2700
				Case 10
					; Nothing
			EndSwitch
		Case 9
			; Doesn't work currently
			$MaxTrainTime = 0
	EndSwitch
	Return $MaxTrainTime
EndFunc   ;==>Standard_GetTrainTime

Func Standard_CheckArmyCamp()
	SetLog(GetLangText("msgCheckingCamp"), $COLOR_BLUE)
	$fullarmy = False

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If $ArmyPos[0] = "" Then
		If Not LocateCamp() Then Return
		SaveConfig()
	Else
		If _Sleep(500) Then Return
		Click($ArmyPos[0], $ArmyPos[1]) ;Click Army Camp
	EndIf

	_CaptureRegion()
	If _Sleep(500) Then Return
	Local $BArmyPos = _WaitForPixel(309, 581, 433, 583, Hex(0x4084B8, 6), 5) ;Finds Info button
	If IsArray($BArmyPos) = False Then
		SetLog(GetLangText("msgCampNA"), $COLOR_RED)
	Else
		Click($BArmyPos[0], $BArmyPos[1]) ;Click Info button
		_WaitForPixel(690, 150, 710, 170, Hex(0xD80407, 6), 5, 1) ;Finds Red Cross button in new popup window
		If _Sleep(200) Then Return
		For $readattempts = 1 to 20
			$CurCamp = StringStripWS(ReadText(426, 194, 280, $textWindows), 8)
			$CurCamp = StringStripWS(StringMid($CurCamp, Stringinstr($CurCamp, ":") + 1), 8)
			$itxtcampCap = StringMid($CurCamp, Stringinstr($CurCamp, "/") + 1)
			If Number($itxtcampCap) > 0 And Number($itxtcampCap) < 300 And StringIsDigit($itxtcampCap) Then
				$CurCamp = StringLeft($CurCamp, StringInStr($CurCamp, "/") - 1)
				If Number($CurCamp) >= 0 And Number($CurCamp) <= $itxtcampCap And StringIsDigit($CurCamp) Then
					SetLog(GetLangText("msgTotalCampCap") & $CurCamp & "/" & $itxtcampCap, $COLOR_GREEN)
					ExitLoop
				EndIf
			EndIf
			If _Sleep(500) Then Return
			If $readattempts = 20 Then
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
				Local $TroopName = ""
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
				If $TroopName = "" Then $TroopName = "Unknown"
				If $TroopQ <> 0 Then SetLog("- " & $TroopName & " " & $TroopQ, $COLOR_GREEN)
			Next
		EndIf
		ClickP($TopLeftClient) ;Click Away
		$FirstCampView = True
	EndIf
	Return $fullarmy
EndFunc   ;==>Standard_CheckArmyCamp

;Uses the location of manually set Barracks to train specified troops

; Train the troops (Fill the barracks)

Func Standard_GetTrainPos($TroopKind)
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
EndFunc   ;==>Standard_GetTrainPos

Func Standard_TrainIt($TroopKind, $howMuch = 1, $iSleep = 100)
	_CaptureRegion()
	Local $pos = Standard_GetTrainPos($TroopKind)
	If IsArray($pos) Then
		If CheckPixel($pos) Then
			ClickP($pos, $howMuch, 20)
			If _Sleep($iSleep) Then Return False
			Return True
		EndIf
	EndIf
EndFunc   ;==>Standard_TrainIt

Func Standard_GetTrainPosDll()
	$res = CallHelper("170 290 700 500 BrokenBotMatchObject 200 6 0")

	If $res <> $DLLFailed And $res <> $DLLTimeout Then
		If $res = $DLLLicense Then
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
EndFunc   ;==>Standard_GetTrainPosDll

Func Standard_TrainItDll($TroopKind, $howMuch = 1, $iSleep = 100)
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

EndFunc   ;==>Standard_TrainItDll

Func Standard_Train($reset = False)
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
;~ 		SetLog("CurArch" & $CurArch & "one: " & $itxtcampCap & ":" & GUICtrlRead($cmbRaidcap) & "two :" & (GUICtrlRead($txtNumGiants) * 5) & "three:" & (GUICtrlRead($txtNumWallbreakers) * 2) & "four:" & (GUICtrlRead($txtArchers) / 100))
;~ 		SetLog("CurBarb" & $CurBarb)
;~ 		SetLog("CurGoblin" & $CurGoblin)
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

	For $i = 0 To 3

		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop

		Click($barrackPos[$i][0], $barrackPos[$i][1]) ;Click Barrack
		If _Sleep(500) Then ExitLoop

		$expUIRet[0] = -1
		$resUI = CallHelper("0 0 860 720 BrokenBotMatchButton 108 1 3")
		If $resUI <> $DLLFailed And $resUI <> $DLLTimeout Then
			If $resUI = $DLLNegative Then
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
							Standard_TrainIt($eGiant, 1)
						ElseIf $GiantEBarrack >= $CurGiant Or $GiantEBarrack = 0 Then
							Standard_TrainIt($eGiant, $CurGiant)
						Else
							Standard_TrainIt($eGiant, $GiantEBarrack)
						EndIf
					EndIf
				EndIf

				If GUICtrlRead($txtNumWallbreakers) <> "0" And $CurWB > 0 Then
					;If _ColorCheck(_GetPixelColor(688, 366), Hex(0x3AD8E0, 6), 20) And $CurWB > 0  Then
					If $CurWB > 0 Then
						If $WallEBarrack = 0 Then
							Standard_TrainIt($eWallbreaker, 1)
						ElseIf $WallEBarrack >= $CurWB Or $WallEBarrack = 0 Then
							Standard_TrainIt($eWallbreaker, $CurWB)
						Else
							Standard_TrainIt($eWallbreaker, $WallEBarrack)
						EndIf
					EndIf
				EndIf

				If GUICtrlRead($txtGoblins) <> "0" And $CurGoblin > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurGoblin > 0 Then
					If $CurGoblin > 0 Then
						If $GoblinEBarrack = 0 Then
							Standard_TrainIt($eGoblin, 1)
						ElseIf $GoblinEBarrack >= $CurGoblin Or $GoblinEBarrack = 0 Then
							Standard_TrainIt($eGoblin, $CurGoblin)
						Else
							Standard_TrainIt($eGoblin, $GoblinEBarrack)
						EndIf
					EndIf
				EndIf

				If GUICtrlRead($txtArchers) <> "0" And $CurArch > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If $CurArch > 0 Then
						If $ArchEBarrack = 0 Then
							Standard_TrainIt($eArcher, 1)
						ElseIf $ArchEBarrack >= $CurArch Then
							Standard_TrainIt($eArcher, $CurArch)
						Else
							Standard_TrainIt($eArcher, $ArchEBarrack)
						EndIf
					EndIf
				EndIf

				If GUICtrlRead($txtBarbarians) <> "0" And $CurBarb > 0 Then
					;If _ColorCheck(_GetPixelColor(369, 366), Hex(0x39D8E0, 6), 20) And $CurBarb > 0 Then
					If $CurBarb > 0 Then
						If $BarbEBarrack = 0 Then
							Standard_TrainIt($eBarbarian, 1)
						ElseIf $BarbEBarrack >= $CurBarb Or $BarbEBarrack = 0 Then
							Standard_TrainIt($eBarbarian, $CurBarb)
						Else
							Standard_TrainIt($eBarbarian, $BarbEBarrack)
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
					SetLog("Giant Remaining : " & $CurGiant, $COLOR_BLUE)
				EndIf


				If $troopSecondWall > $troopFirstWall And GUICtrlRead($txtNumWallbreakers) <> "0" Then
					$ArmyComp += ($troopSecondWall - $troopFirstWall) * 2
					$CurWB -= ($troopSecondWall - $troopFirstWall)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameWallBreaker") & " : " & ($troopSecondWall - $troopFirstWall), $COLOR_GREEN)
					SetLog("WallBreaker Remaining : " & $CurWB, $COLOR_BLUE)
				EndIf

				If $troopSecondGoblin > $troopFirstGoblin And GUICtrlRead($txtGoblins) <> "0" Then
					$ArmyComp += ($troopSecondGoblin - $troopFirstGoblin)
					$CurGoblin -= ($troopSecondGoblin - $troopFirstGoblin)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameGoblin") & " : " & ($troopSecondGoblin - $troopFirstGoblin), $COLOR_GREEN)
					SetLog("Goblin Remaining : " & $CurGoblin, $COLOR_BLUE)
				EndIf

				If $troopSecondBarba > $troopFirstBarba And GUICtrlRead($txtBarbarians) <> "0" Then
					$ArmyComp += ($troopSecondBarba - $troopFirstBarba)
					$CurBarb -= ($troopSecondBarba - $troopFirstBarba)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameBarbarian") & " : " & ($troopSecondBarba - $troopFirstBarba), $COLOR_GREEN)
					SetLog("Barbarian Remaining : " & $CurBarb, $COLOR_BLUE)
				EndIf

				If $troopSecondArch > $troopFirstArch And GUICtrlRead($txtArchers) <> "0" Then
					$ArmyComp += ($troopSecondArch - $troopFirstArch)
					$CurArch -= ($troopSecondArch - $troopFirstArch)
					SetLog(GetLangText("msgBarrack") & ($i + 1) & GetLangText("msgTraining") & GetLangText("troopNameArcher") & " : " & ($troopSecondArch - $troopFirstArch), $COLOR_GREEN)
					SetLog("Archer Remaining : " & $CurArch, $COLOR_BLUE)
				EndIf
				SetLog(GetLangText("msgTotalBuilding") & $ArmyComp, $COLOR_RED)
			EndIf
		EndIf
		If _Sleep(100) Then ExitLoop
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
	Next
	If $brerror[0] = True And $brerror[1] = True And $brerror[2] = True And $brerror[3] = True Then
		resetBarracksError()
		$needzoomout = True
		SetLog(GetLangText("msgRestartComplete"), $COLOR_RED)
	Else
		SetLog(GetLangText("msgTrainingComp"), $COLOR_BLUE)
	EndIf

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
 	For $i = 0 To 1
 		If _Sleep(500) Then ExitLoop

 		ClickP($TopLeftClient) ;Click Away

 		If _Sleep(500) Then ExitLoop
 		Click($DarkBarrackPos[$i][0], $DarkBarrackPos[$i][1]) ;Click Dark Barrack
 		If _Sleep(500) Then ExitLoop

		$res = CallHelper("0 0 860 720 BrokenBotMatchObject 108 3 0")
 		If $res <> $DLLFailed And $res <> $DLLTimeout Then
			If $res = $DLLNegative Then
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

		_CaptureRegion()
 		If $fullArmy Or $FirstStart Then ;Reset troops on first loop, or if army is full to start cooking for next attack
			If Not _ColorCheck(_GetPixelColor(502, 179), Hex(0xD1D0C2, 6), 20) Then
				Click(502, 179, 80, 2)
			EndIf
 		EndIf

		Standard_GetTrainPosDll()

 		;Dark Barrack 1
 		If GUICtrlRead($txtDarkBarrack1) <> "0" And $i = 0 And $TrainDrax1 = True Then
			$itxtDarkBarrack1 = GUICtrlRead($txtDarkBarrack1)
			If $DarkBarrackTroop[$i] = 0 Then
				Local $troopMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
				If $itxtDarkBarrack1 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
				   Standard_TrainItDll($eMinion, $itxtDarkBarrack1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $itxtDarkBarrack1 > 20 And ($fullArmy Or $FirstDarkTrain) Then
				   Standard_TrainItDll($eMinion, 20)
				   $LeftRax1 = ($itxtDarkBarrack1 - 20)
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 > ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, (20 - $troopMinion))
				   $LeftRax1 = ($ClickRax1 - (20 - $troopMinion))
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 <= ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 <= 1 And ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax1)
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
				   Standard_TrainItDll($eHog, $itxtDarkBarrack1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $itxtDarkBarrack1 > 10 And ($fullArmy Or $FirstDarkTrain) Then
				   Standard_TrainItDll($eHog, 10)
				   $LeftRax1 = ($itxtDarkBarrack1 - 10)
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 > ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, (10 - $troopHog))
				   $LeftRax1 = ($ClickRax1 - (10 - $troopHog))
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 <= ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 <= 1 And ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax1)
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
				   Standard_TrainItDll($eValkyrie, $itxtDarkBarrack1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $itxtDarkBarrack1 > 7 And ($fullArmy Or $FirstDarkTrain) Then
				   Standard_TrainItDll($eValkyrie, 7)
				   $LeftRax1 = ($itxtDarkBarrack1 - 7)
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 > ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, (7 - $troopValkyrie))
				   $LeftRax1 = ($ClickRax1 - (7 - $troopValkyrie))
				   $ClickRax1 = $LeftRax1
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 <= ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax1)
				   $TrainDrax1 = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain = False
				ElseIf $LeftRax1 <= 1 And ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax1)
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
				Local $troopMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
				If $itxtDarkBarrack1Next <= 20 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Standard_TrainItDll($eMinion, $itxtDarkBarrack1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $itxtDarkBarrack1Next > 20 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Standard_TrainItDll($eMinion, 20)
				   $LeftRax1Next = ($itxtDarkBarrack1Next - 20)
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopMinion < 20) And $LeftRax1Next > ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, (20 - $troopMinion))
				   $LeftRax1Next = ($ClickRax1Next - (20 - $troopMinion))
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopMinion < 20) And $LeftRax1Next <= ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next <= 1 And ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				Else
					SetLog("Dark Barrack 1 Training in progress, Minion Remaining : " & $LeftRax1Next, $COLOR_BLUE)
					$FirstDarkTrainNext = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 1 Then
				Local $troopHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
				If $itxtDarkBarrack1Next <= 10 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Standard_TrainItDll($eHog, $itxtDarkBarrack1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $itxtDarkBarrack1Next > 10 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Standard_TrainItDll($eHog, 10)
				   $LeftRax1Next = ($itxtDarkBarrack1Next - 10)
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopHog < 10) And $LeftRax1Next > ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, (10 - $troopHog))
				   $LeftRax1Next = ($ClickRax1Next - (10 - $troopHog))
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopHog < 10) And $LeftRax1Next <= ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next <= 1 And ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				Else
				   SetLog("Dark Barrack 1 Training in progress, Hog Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 2 Then
				Local $troopValkyrie = Number(getOther(171 + 107 * 2, 278, "Barrack"))
				If $itxtDarkBarrack1Next <= 7 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Standard_TrainItDll($eValkyrie, $itxtDarkBarrack1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $itxtDarkBarrack1Next > 7 And ($fullArmy Or $FirstDarkTrainNext) Then
				   Standard_TrainItDll($eValkyrie, 7)
				   $LeftRax1Next = ($itxtDarkBarrack1Next - 7)
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopValkyrie < 7) And $LeftRax1Next > ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, (7 - $troopValkyrie))
				   $LeftRax1Next = ($ClickRax1Next - (7 - $troopValkyrie))
				   $ClickRax1Next = $LeftRax1Next
				   SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1Next, $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next > 1 And ($troopValkyrie < 7) And $LeftRax1Next <= ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax1Next)
				   $TrainDrax1Next = False
				   SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrainNext = False
				ElseIf $LeftRax1Next <= 1 And ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax1Next)
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
				Local $troopMinion2 = Number(getOther(171 + 107 * 0, 278, "Barrack"))
				If $itxtDarkBarrack2 <= 20 And ($fullArmy Or $FirstDarkTrain2) Then
				   Standard_TrainItDll($eMinion, $itxtDarkBarrack2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $itxtDarkBarrack2 > 20 And ($fullArmy Or $FirstDarkTrain2) Then
				   Standard_TrainItDll($eMinion, 20)
				   $LeftRax2 = ($itxtDarkBarrack2 - 20)
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 > ($troopMinion2 < 20) Then
				   Standard_TrainItDll($eMinion, (20 - $troopMinion2))
				   $LeftRax2 = ($ClickRax2 - (20 - $troopMinion2))
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 <= ($troopMinion2 < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 <= 1 And ($troopMinion2 < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				EndIf
			EndIf

			If $DarkBarrackTroop[$i] = 1 Then
				Local $troopHog2 = Number(getOther(171 + 107 * 1, 278, "Barrack"))
				If $itxtDarkBarrack2 <= 10 And ($fullArmy Or $FirstDarkTrain2) Then
				   Standard_TrainItDll($eHog, $itxtDarkBarrack2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $itxtDarkBarrack2 > 10 And ($fullArmy Or $FirstDarkTrain2) Then
				   Standard_TrainItDll($eHog, 10)
				   $LeftRax2 = ($itxtDarkBarrack2 - 10)
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 > ($troopHog2 < 10) Then
				   Standard_TrainItDll($eHog, (10 - $troopHog2))
				   $LeftRax2 = ($ClickRax2 - (10 - $troopHog2))
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 <= ($troopHog2 < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 <= 1 And ($troopHog2 < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				EndIf
			EndIf

			If $DarkBarrackTroop[$i] = 2 Then
				Local $troopValkyrie2 = Number(getOther(171 + 107 * 2, 278, "Barrack"))
				If $itxtDarkBarrack2 <= 7 And ($fullArmy Or $FirstDarkTrain2) Then
				   Standard_TrainItDll($eValkyrie, $itxtDarkBarrack2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $itxtDarkBarrack2 > 7 And ($fullArmy Or $FirstDarkTrain2) Then
				   Standard_TrainItDll($eValkyrie, 7)
				   $LeftRax2 = ($itxtDarkBarrack2 - 7)
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 > ($troopValkyrie2 < 7) Then
				   Standard_TrainItDll($eValkyrie, (7 - $troopValkyrie2))
				   $LeftRax2 = ($ClickRax2 - (7 - $troopValkyrie2))
				   $ClickRax2 = $LeftRax2
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 <= ($troopValkyrie2 < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax2)
				   $TrainDrax2 = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2 = False
				ElseIf $LeftRax2 <= 1 And ($troopValkyrie2 < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax2)
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
				Local $troopMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
				If $itxtDarkBarrack2Next <= 20 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Standard_TrainItDll($eMinion, $itxtDarkBarrack2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $itxtDarkBarrack2Next > 20 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Standard_TrainItDll($eMinion, 20)
				   $LeftRax2Next = ($itxtDarkBarrack2Next - 20)
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopMinion < 20) And $LeftRax2Next > ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, (20 - $troopMinion))
				   $LeftRax2Next = ($ClickRax2Next - (20 - $troopMinion))
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopMinion < 20) And $LeftRax2Next <= ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next <= 1 And ($troopMinion < 20) Then
				   Standard_TrainItDll($eMinion, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				Else
					SetLog("Dark Barrack 2 Training in progress, Minion Remaining : " & $LeftRax2Next, $COLOR_BLUE)
					$FirstDarkTrain2Next = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 1 Then
				Local $troopHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
				If $itxtDarkBarrack2Next <= 10 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Standard_TrainItDll($eHog, $itxtDarkBarrack2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $itxtDarkBarrack2Next > 10 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Standard_TrainItDll($eHog, 10)
				   $LeftRax2Next = ($itxtDarkBarrack2Next - 10)
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopHog < 10) And $LeftRax2Next > ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, (10 - $troopHog))
				   $LeftRax2Next = ($ClickRax2Next - (10 - $troopHog))
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopHog < 10) And $LeftRax2Next <= ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next <= 1 And ($troopHog < 10) Then
				   Standard_TrainItDll($eHog, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				Else
				   SetLog("Dark Barrack 2 Training in progress, Hog Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				EndIf
			EndIf

			If $DarkBarrackTroopNext[$i] = 2 Then
				Local $troopValkyrie = Number(getOther(171 + 107 * 2, 278, "Barrack"))
				If $itxtDarkBarrack2Next <= 7 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Standard_TrainItDll($eValkyrie, $itxtDarkBarrack2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $itxtDarkBarrack2Next > 7 And ($fullArmy Or $FirstDarkTrain2Next) Then
				   Standard_TrainItDll($eValkyrie, 7)
				   $LeftRax2Next = ($itxtDarkBarrack2Next - 7)
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopValkyrie < 7) And $LeftRax2Next > ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, (7 - $troopValkyrie))
				   $LeftRax2Next = ($ClickRax2Next - (7 - $troopValkyrie))
				   $ClickRax2Next = $LeftRax2Next
				   SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2Next, $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next > 1 And ($troopValkyrie < 7) And $LeftRax2Next <= ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax2Next)
				   $TrainDrax2Next = False
				   SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
				   $FirstDarkTrain2Next = False
				ElseIf $LeftRax2Next <= 1 And ($troopValkyrie < 7) Then
				   Standard_TrainItDll($eValkyrie, $LeftRax2Next)
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
EndFunc   ;==>Standard_Train

Func Standard_MakeSpells()
	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If $SpellPos[0] = "" Then
		If Not LocateSpellFactory() Then Return
		SaveConfig()
	Else
		If _Sleep(500) Then Return
		Click($SpellPos[0], $SpellPos[1]) ;Click Spell Factory
	EndIf

	If _Sleep(500) Then Return ;Do a bit slower
	_CaptureRegion()
	Local $BSpellPos = _WaitForPixel(214, 581, 368, 583, Hex(0x4084B8, 6), 5, 3) ;Finds Info button, wait max 3 seconds
	If IsArray($BSpellPos) = False Then
		SetLog(GetLangText("msgSFUnavailable"), $COLOR_RED)
		If $DebugMode = 2 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "SpellNA-" & @HOUR & @MIN & @SEC & ".png")
	EndIf

	;If _Sleep(1000) Then Return
	Local $BSpellPos = _PixelSearch(500, 603, 570, 605, Hex(0x07346F, 6), 5) ;Finds create spells button
	If IsArray($BSpellPos) Then
		Click($BSpellPos[0], $BSpellPos[1])
		_WaitForPixel(720, 150, 740, 170, Hex(0xD80404, 6), 5, 1) ;Finds Red Cross button in new Training popup window
		SetLog(GetLangText("msgMakingSpell") & GUICtrlRead($cmbSpellCreate) & " x " & $itxtspellcap, $COLOR_BLUE)
		Click(220 + _GUICtrlComboBox_GetCurSel($cmbSpellCreate) * 106, 320, $itxtspellcap)
		If _Sleep(500) Then Return
		ClickP($TopLeftClient)
		$spellsstarted = True
	Else
		SetLog(GetLangText("msgUnableCreate"), $COLOR_RED)
	EndIf

	;ClickP($TopLeftClient) ;Click Away
	If _Sleep(500) Then Return
	ClickP($TopLeftClient) ;Click Away
EndFunc   ;==>Standard_MakeSpells
