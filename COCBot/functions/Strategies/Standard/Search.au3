;Searches for a village that until meets conditions

Func Standard_Search()
	Local $skippedVillages
	Local $conditionlogstr
	Local $AttackMethod
	Local $DG, $DE, $DD, $DT, $G, $E, $D, $T, $DET
	Local $calculateCondition

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; Reduce BlueStacks Memory Usage

	$hTimerClickNext = TimerInit() ;Next button already pressed before call here

	;safe to reset flag here. If failed and return -1, this flag will be set again.
	$SearchFailed = False

	While 1
		$calculateCondition = False
		GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
		If $TakeAllTownSnapShot = 1 Then SetLog(GetLangText("msgWillSaveAll"), $COLOR_GREEN)

		_BlockInputEx(3, "", "", $HWnD)
		While 1
			; Make sure end battle button is visible
			If Not _WaitForColor(36, 523, Hex(0xEE5056, 6), 50, 10) Then
				ChkDisconnection()
				Return -1
			EndIf

			; Make sure clouds have cleared
			If Not _WaitForColor(1, 670, Hex(0x02070D, 6), 50, 5) Then Return -1

			;If _Sleep($speedBump) Then Return -1
			GUICtrlSetState($btnAtkNow, $GUI_ENABLE)

			; Wait just a bit extra
			If _Sleep(100) Then Return

			If IsChecked($chkTakeTownSS) Then
				Local $Date = @MDAY & "." & @MON & "." & @YEAR
				Local $Time = @HOUR & "." & @MIN & "." & @SEC
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\AllTowns\" & $Date & " at " & $Time & ".png")
			EndIf

;~ 			If $DebugMode = 1  And $Hide = False Then ActivateOverlay()
;~ 			SeekEdges()

			If $calculateCondition = True And ($SearchCount <> 0 And Mod($SearchCount, GUICtrlRead($txtRedNumOfSerach)) = 0) Then
				_BumpMouse()
				AdjustSearchCond()
			EndIf
			$calculateCondition = True

			;Initial working variables
			$GoodBase = False
			$DEx = 0
			$DEy = 0
			Local $conditionlogstr
			$NukeAttack = False

			$BaseData = GetResources()
			If Not IsArray($BaseData) Then
				SetLog(GetLangText("msgNoNextRestart"), $COLOR_RED)
				ChkDisconnection()
				Return -1
			EndIf

			$SubmissionSearches += 1
			If StringLen($SubmissionSGold) > 0 Then
				$SubmissionSGold &= "|"
				$SubmissionSElix &= "|"
				$SubmissionSDE &= "|"
				$SubmissionSTH &= "|"
				$SubmissionSDead &= "|"
			EndIf
			$SubmissionSGold &= String($BaseData[2])
			$SubmissionSElix &= String($BaseData[3])
			$SubmissionSDE &= String($BaseData[4])
			$SubmissionSTH &= String($BaseData[1])
			$LastAttackTH = String($BaseData[1])
			If $BaseData[0] Then
				$SubmissionSDead &= "0"
				$LastAttackDead = "0"
			Else
				$SubmissionSDead &= "1"
				$LastAttackDead = "1"
			EndIf

			StatSubmission()

			$DG = (Number($BaseData[2]) >= Number($MinDeadGold))
			$DE = (Number($BaseData[3]) >= Number($MinDeadElixir))
			$DD = (Number($BaseData[4]) >= Number($MinDeadDark))
			$DT = (Number($BaseData[5]) >= Number($MinDeadTrophy))
			$G = (Number($BaseData[2]) >= Number($MinGold))
			$E = (Number($BaseData[3]) >= Number($MinElixir))
			$D = (Number($BaseData[4]) >= Number($MinDark))
			$T = (Number($BaseData[5]) >= Number($MinTrophy))
			$DET = ((Number($BaseData[2]) + Number($BaseData[3])) >= (Number($MinDeadGold) + (Number($MinDeadElixir))))

			$THL = -1
			$THLO = -1

			For $i = 0 To 4
				If $BaseData[1] = $THText[$i] Then $THL = $i
			Next

			Switch $THLoc
				Case "In"
					$THLO = 0
				Case "Out"
					$THLO = 1
			EndSwitch

			If $THLoc = "Out" Then
				If (Number(GUICtrlRead($lblresulttrophynow)) < Number(GUICtrlRead($txtSnipeBelow))) Or (IsChecked($chkDeadActivate) And IsChecked($chkDeadSnipe) And $BaseData[0]) Or (IsChecked($chkAnyActivate) And IsChecked($chkSnipe) And Not $BaseData[0]) Then
					SetLog(GetLangText("msgSnipeFound"), $COLOR_PURPLE)
					$AttackMethod = 3
					ExitLoop
				EndIf
			EndIf

			; Variables to check whether to attack dead bases
			Local $conditionDeadPass = True

			If IsChecked($chkDeadActivate) And $fullArmy And _
					(Not IsChecked($chkDeadKingAvail) Or $KingAvailable) And _
					(Not IsChecked($chkDeadQueenAvail) Or $QueenAvailable) Then
				If IsChecked($chkDeadGE) Then
					$deadEnabled = True
					If _GUICtrlComboBox_GetCurSel($cmbDead) = 0 Then ; And
						If $DG = False Or $DE = False Then $conditionDeadPass = False
					ElseIf _GUICtrlComboBox_GetCurSel($cmbDead) = 1 ; And
						If $DG = False And $DE = False Then $conditionDeadPass = False
					Else
						If $DET=False Then $conditionDeadPass=False
					EndIf
				EndIf

				If IsChecked($chkDeadMeetDE) Then
					If $DD = False Then $conditionDeadPass = False
				EndIf

				If IsChecked($chkDeadMeetTrophy) Then
					If $DT = False Then $conditionDeadPass = False
				EndIf

				If IsChecked($chkDeadMeetTH) Then
					If $THL = -1 Or $THL > _GUICtrlComboBox_GetCurSel($cmbDeadTH) Then $conditionDeadPass = False
				EndIf

				If IsChecked($chkDeadMeetTHO) Then
					If $THLO <> 1 Then $conditionDeadPass = False
				EndIf

				If $BaseData[0] And $conditionDeadPass Then
					SetLog(GetLangText("msgDeadFound"), $COLOR_GREEN)
					$GoodBase = True
					$AttackMethod = 0
				EndIf
			EndIf

			If Not $GoodBase Then
				; Variables to check whether to attack non-dead bases
				Local $conditionAnyPass = True
				If IsChecked($chkAnyActivate) And $fullArmy And _
						(Not IsChecked($chkKingAvail) Or $KingAvailable) And _
						(Not IsChecked($chkQueenAvail) Or $QueenAvailable) Then
					If IsChecked($chkMeetGE) Then
						$anyEnabled = True
						If _GUICtrlComboBox_GetCurSel($cmbAny) = 0 Then ; And
							If $G = False Or $E = False Then $conditionAnyPass = False
						Else ; Or
							If $G = False And $E = False Then $conditionAnyPass = False
						EndIf
					EndIf

					If IsChecked($chkMeetDE) Then
						If $D = False Then $conditionAnyPass = False
					EndIf

					If IsChecked($chkMeetTrophy) Then
						If $T = False Then $conditionAnyPass = False
					EndIf

					If IsChecked($chkMeetTH) Then
						If $THL = -1 Or $THL > _GUICtrlComboBox_GetCurSel($cmbTH) Then $conditionAnyPass = False
					EndIf

					If IsChecked($chkMeetTHO) Then
						If $THLO <> 1 Then $conditionAnyPass = False
					EndIf

					If $conditionAnyPass Then
						SetLog(GetLangText("msgOtherFound"), $COLOR_GREEN)
						$GoodBase = True
						$AttackMethod = 1
					EndIf
				EndIf
			EndIf

			If Not $GoodBase Then
				; Variables to check whether to zap Dark elixir
				If IsChecked($chkNukeOnly) And $fullSpellFactory And $iNukeLimit > 0 Then
					If Number($BaseData[4]) >= Number($iNukeLimit) Then
						If checkDarkElix() Then
							$NukeAttack = True
							SetLog(GetLangText("msgZapFound"), $COLOR_GREEN)
							$GoodBase = True
							$AttackMethod = 2
						EndIf
					EndIf
				EndIf
			EndIf

;~ 			If $OverlayVisible Then DeleteOverlay()

			If $GoodBase Then
				GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
				ExitLoop
			Else
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(726, 497), Hex(0xF0AE28, 6), 20) Then
					; Attack instantly if Attack Now button pressed
					If $AttackNow Then
						GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
						$AttackNow = False
						SetLog(GetLangText("msgAttackNowClicked"), $COLOR_GREEN)
						ExitLoop
					EndIf

					Local $fDiffNow = TimerDiff($hTimerClickNext) - $fdiffReadGold ;How long in attack prep mode
					$RandomDelay = _Random_Gaussian($icmbSearchsp * 1500, ($icmbSearchsp * 1500) / 6)
					If $fDiffNow < $speedBump + $RandomDelay Then ; Wait accoridng to search speed + speedBump
						If _Sleep($speedBump + $RandomDelay - $fDiffNow) Then ExitLoop (2)
					EndIf

					If $AttackNow Then
						GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
						$AttackNow = False
						SetLog(GetLangText("msgAttackNowClicked"), $COLOR_GREEN)
						ExitLoop
					EndIf

					GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
					Click(750, 500) ;Click Next
					$hTimerClickNext = TimerInit()
					;Take time to do search
					GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
					GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
					If _Sleep(1000) Then Return -1
				ElseIf _ColorCheck(_GetPixelColor(36, 523), Hex(0xEE5056, 6), 20) Then ;If End battle is available
					GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
					SetLog(GetLangText("msgNoNextReturn"), $COLOR_RED)
					ChkDisconnection(True)
					ReturnHome(False, False, True)
					Return -1
				Else
					GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
					SetLog(GetLangText("msgNoNextRestart"), $COLOR_RED)
					ChkDisconnection()
					Return -1
				EndIf
			EndIf
		WEnd
		GUICtrlSetData($lblresultvillagesattacked, GUICtrlRead($lblresultvillagesattacked) + 1)
		GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
		If IsChecked($chkAlertSearch) Then
			TrayTip("Match Found!", "Gold: " & $BaseData[2] & "; Elixir: " & $BaseData[3] & "; Dark: " & $BaseData[4] & "; Trophy: " & $BaseData[5] & "; Townhall: " & $BaseData[1] & ", " & $THLoc, 0)
			If FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
				SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
			Else
				SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
			EndIf
		EndIf
		$MatchFoundText = "[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($BaseData[2]) & "; [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($BaseData[3]) & _
				"; [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($BaseData[4]) & "; [" & GetLangText("msgTrophyInitial") & "]: " & $BaseData[5] & _
				"; [TH Lvl]: " & $BaseData[1] & ", Loc: " & $THLoc & "; [" & GetLangText("msgDeadBase ") & "]:" & $BaseData[0]
		If $PushBulletEnabled = 1 And $PushBulletmatchfound = 1 Then
			_Push(GetLangText("pushMatch"), $MatchFoundText)
			SetLog(GetLangText("msgPushMatch"), $COLOR_GREEN)
		EndIf
		SetLog(GetLangText("msgSearchComplete"), $COLOR_BLUE)
		;Match found, reset stuckCount flag & searchfailed falg before run readycheck again.
		$SearchFailed = False
		$stuckCount = 0
		_BlockInputEx(0, "", "", $HWnD)
		Return $AttackMethod
	WEnd
EndFunc   ;==>Standard_Search

;Adjust and Print out search condition if there is any
;Return True if there is valid condition
;Return False if no valid search condition
Func AdjustSearchCond()
	Local $conditionlogsarray[3] ;max three types of base to search
	Local $condCounts = 0
	Local $conditionlogstr
	Local $CondMultipler

	$CondMultipler = Int($SearchCount / GUICtrlRead($txtRedNumOfSerach))

	$MaxDeadTH = _GUICtrlComboBox_GetCurSel($cmbDeadTH)
	$MaxTH = _GUICtrlComboBox_GetCurSel($cmbTH)

	$MinDeadGold = GUICtrlRead($txtDeadMinGold) * (1 - $CondMultipler * GUICtrlRead($txtRedGoldPercent) / 100)
	$MinDeadGold = ($MinDeadGold > 0) ? $MinDeadGold : 0
	$MinDeadElixir = GUICtrlRead($txtDeadMinElixir) * (1 - $CondMultipler * GUICtrlRead($txtRedElixirPercent) / 100)
	$MinDeadElixir = ($MinDeadElixir > 0) ? $MinDeadElixir : 0
	$MinDeadDark = GUICtrlRead($txtDeadMinDarkElixir) * (1 - $CondMultipler * GUICtrlRead($txtRedDEPercent) / 100)
	$MinDeadDark = ($MinDeadDark > 0) ? $MinDeadDark : 0
	$MinDeadTrophy = Int(GUICtrlRead($txtDeadMinTrophy) * (1 - $CondMultipler * GUICtrlRead($txtRedTrophyPercent) / 100))
	$MinDeadTrophy = ($MinDeadTrophy > 0) ? $MinDeadTrophy : 0
	$MinGold = GUICtrlRead($txtMinGold) * (1 - $CondMultipler * GUICtrlRead($txtRedGoldPercent) / 100)
	$MinGold = ($MinGold > 0) ? $MinGold : 0
	$MinElixir = GUICtrlRead($txtMinElixir) * (1 - $CondMultipler * GUICtrlRead($txtRedElixirPercent) / 100)
	$MinElixir = ($MinElixir > 0) ? $MinElixir : 0
	$MinDark = GUICtrlRead($txtMinDarkElixir) * (1 - $CondMultipler * GUICtrlRead($txtRedDEPercent) / 100)
	$MinDark = ($MinDark > 0) ? $MinDark : 0
	$MinTrophy = Int(GUICtrlRead($txtMinTrophy) * (1 - $CondMultipler * GUICtrlRead($txtRedTrophyPercent) / 100))
	$MinTrophy = ($MinTrophy > 0) ? $MinTrophy : 0
	$iNukeLimit = GUICtrlRead($txtDENukeLimit) * (1 - $CondMultipler * GUICtrlRead($txtRedNukePercent) / 100)
	$iNukeLimit = ($iNukeLimit > 0) ? $iNukeLimit : 0

	;New condition test for king & queen availablity
	If IsChecked($chkDeadActivate) And $fullArmy And _
			(Not IsChecked($chkDeadKingAvail) Or $KingAvailable) And _
			(Not IsChecked($chkDeadQueenAvail) Or $QueenAvailable) Then
		$conditionlogstr = "Dead Base ("
		If IsChecked($chkDeadGE) Then
			If _GUICtrlComboBox_GetCurSel($cmbDead) = 0 Then
				$conditionlogstr = $conditionlogstr & " Gold: " & $MinDeadGold & " And " & "Elixir: " & $MinDeadElixir
			ElseIf _GUICtrlComboBox_GetCurSel($cmbDead) = 1 Then
				$conditionlogstr = $conditionlogstr & " Gold: " & $MinDeadGold & " Or " & "Elixir: " & $MinDeadElixir
			Else
				$conditionlogstr = $conditionlogstr & " Gold " &  " + " & "Elixir: " & ($MinDeadGold+$MinDeadElixir)
			EndIf
		EndIf
		If IsChecked($chkDeadMeetDE) Then
			If $conditionlogstr <> "Dead Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Dark: " & $MinDeadDark
		EndIf
		If IsChecked($chkDeadMeetTrophy) Then
			If $conditionlogstr <> "Dead Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Trophy: " & $MinDeadTrophy
		EndIf
		If IsChecked($chkDeadMeetTH) Then
			If $conditionlogstr <> "Dead Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Max Townhall: " & $THText[$MaxDeadTH]
		EndIf
		If IsChecked($chkDeadMeetTHO) Then
			If $conditionlogstr <> "Dead Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Townhall Outside"
		EndIf
		$conditionlogstr = $conditionlogstr & " )"
		$conditionlogsarray[$condCounts] = $conditionlogstr
		$condCounts += 1
		;SetLog($conditionlogstr, $COLOR_GREEN)
	EndIf
	;New condition test for king & queen availablity
	If IsChecked($chkAnyActivate) And $fullArmy And _
			(Not IsChecked($chkKingAvail) Or $KingAvailable) And _
			(Not IsChecked($chkQueenAvail) Or $QueenAvailable) Then
		$conditionlogstr = "Live Base ("
		If IsChecked($chkMeetGE) Then
			If _GUICtrlComboBox_GetCurSel($cmbDead) = 0 Then
				$conditionlogstr = $conditionlogstr & " Gold: " & $MinGold & " And " & "Elixir: " & $MinElixir
			Else
				$conditionlogstr = $conditionlogstr & " Gold: " & $MinGold & " Or " & "Elixir: " & $MinElixir
			EndIf
		EndIf
		If IsChecked($chkMeetDE) Then
			If $conditionlogstr <> "Live Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Dark: " & $MinDark
		EndIf
		If IsChecked($chkMeetTrophy) Then
			If $conditionlogstr <> "Live Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Trophy: " & $MinTrophy
		EndIf
		If IsChecked($chkMeetTH) Then
			If $conditionlogstr <> "Live Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Max Townhall: " & $THText[$MaxTH]
		EndIf
		If IsChecked($chkMeetTHO) Then
			If $conditionlogstr <> "Live Base (" Then
				$conditionlogstr = $conditionlogstr & ";"
			EndIf
			$conditionlogstr = $conditionlogstr & " Townhall Outside"
		EndIf
		$conditionlogstr = $conditionlogstr & " )"
		$conditionlogsarray[$condCounts] = $conditionlogstr
		$condCounts += 1
		;SetLog($conditionlogstr, $COLOR_GREEN)
	EndIf
	If IsChecked($chkNukeOnly) And $fullSpellFactory And $iNukeLimit > 0 Then
		$conditionlogstr = "Zap Base ( Dark: " & $iNukeLimit & " )"
		$conditionlogsarray[$condCounts] = $conditionlogstr
		$condCounts += 1
		;SetLog($conditionlogstr, $COLOR_GREEN)
	EndIf

	;All condtions here, if there is any
	If $condCounts > 0 Then
		;we have valid search condition
		SetLog(GetLangText("msgSearchCond"), $COLOR_RED)
		For $i = 0 To $condCounts - 1
			SetLog($conditionlogsarray[$i], $COLOR_GREEN)
		Next
		Return True
	Else
		Return False
	EndIf

EndFunc   ;==>AdjustSearchCond
