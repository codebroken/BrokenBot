;Searches for a village that until meets conditions

Func Standard_Search()
	Local $skippedVillages
	Local $conditionlogstr
	Local $AttackMethod
	Local $DG, $DE, $DD, $DT, $G, $E, $D, $T
	local $calculateCondition = True

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; Reduce BlueStacks Memory Usage

	$hTimerClickNext = TimerInit() ;Next button already pressed before call here

	$MinDeadGold = GUICtrlRead($txtDeadMinGold)
	$MinDeadElixir = GUICtrlRead($txtDeadMinElixir)
	$MinDeadDark = GUICtrlRead($txtDeadMinDarkElixir)
	$MinDeadTrophy = GUICtrlRead($txtDeadMinTrophy)
	$MaxDeadTH = _GUICtrlComboBox_GetCurSel($cmbDeadTH)
	$MinGold = GUICtrlRead($txtMinGold)
	$MinElixir = GUICtrlRead($txtMinElixir)
	$MinDark = GUICtrlRead($txtMinDarkElixir)
	$MinTrophy = GUICtrlRead($txtMinTrophy)
	$MaxTH = _GUICtrlComboBox_GetCurSel($cmbTH)
	$iNukeLimit = GUICtrlRead($txtDENukeLimit)

	While 1
		$calculateCondition = True
		GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
		If $TakeAllTownSnapShot = 1 Then SetLog(GetLangText("msgWillSaveAll"), $COLOR_GREEN)

		If $SearchFailed = False Then ;reset SearchCount only when last search wasn't failed
			$SearchCount = 0
		EndIf
		$SearchFailed = False
		_BlockInputEx(3, "", "", $HWnD)


		While 1
			If Not _WaitForColor(30, 505, Hex(0xE80008, 6), 50, 10) Then
				ChkDisconnection()
				Return -1
			EndIf
			;If _Sleep($speedBump) Then Return -1
			GUICtrlSetState($btnAtkNow, $GUI_ENABLE)

			If IsChecked($chkTakeTownSS) Then
				Local $Date = @MDAY & "." & @MON & "." & @YEAR
				Local $Time = @HOUR & "." & @MIN & "." & @SEC
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\AllTowns\" & $Date & " at " & $Time & ".png")
			EndIf

			If _Sleep($icmbSearchsp * 1500) Then Return -1

			If $calculateCondition = True or ($SearchCount <> 0 And Mod($SearchCount, 30) = 0) Then
				_BumpMouse()
				$calculateCondition = False
				Local $CondMultipler
				$CondMultipler = Int($SearchCount/30)

				If GUICtrlRead($txtDeadMinGold) - $CondMultipler*5000 >= 0 Then $MinDeadGold = GUICtrlRead($txtDeadMinGold) - $CondMultipler*5000
				If GUICtrlRead($txtDeadMinElixir) - $CondMultipler*5000 >= 0 Then $MinDeadElixir = GUICtrlRead($txtDeadMinElixir) - $CondMultipler*5000
				If GUICtrlRead($txtDeadMinDarkElixir) - $CondMultipler*100 >= 0 Then $MinDeadDark = GUICtrlRead($txtDeadMinDarkElixir) - $CondMultipler*100
				If GUICtrlRead($txtDeadMinTrophy) - $CondMultipler*2 >= 0 Then $MinDeadTrophy = GUICtrlRead($txtDeadMinTrophy) - $CondMultipler*2
				If GUICtrlRead($txtMinGold) - $CondMultipler*5000 >= 0 Then $MinGold = GUICtrlRead($txtMinGold) - $CondMultipler*5000
				If GUICtrlRead($txtMinElixir) - $CondMultipler*5000 >= 0 Then $MinElixir = GUICtrlRead($txtMinElixir) - $CondMultipler*5000
				If GUICtrlRead($txtMinDarkElixir) - $CondMultipler*100 >= 0 Then $MinDark = GUICtrlRead($txtMinDarkElixir) - $CondMultipler*100
				If GUICtrlRead($txtMinTrophy) - $CondMultipler*2 >= 0 Then $MinTrophy = GUICtrlRead($txtMinTrophy) - $CondMultipler*2
				If GUICtrlRead($txtDENukeLimit) - $CondMultipler*300 >= 0 Then $iNukeLimit = GUICtrlRead($txtDENukeLimit) - $CondMultipler*300
				SetLog(GetLangText("msgSearchCond"), $COLOR_RED)
				If IsChecked($chkDeadActivate) And $fullArmy Then
					$conditionlogstr = "Dead Base ("
					If IsChecked($chkDeadGE) Then
						If _GUICtrlComboBox_GetCurSel($cmbDead) = 0 Then
							$conditionlogstr = $conditionlogstr & " Gold: " & $MinDeadGold & " And " & "Elixir: " & $MinDeadElixir
						Else
							$conditionlogstr = $conditionlogstr & " Gold: " & $MinDeadGold & " Or " & "Elixir: " & $MinDeadElixir
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
						$conditionlogstr = $conditionlogstr & " Max Townhall: " & $MaxDeadTH
					EndIf
					If IsChecked($chkDeadMeetTHO) Then
						If $conditionlogstr <> "Dead Base (" Then
							$conditionlogstr = $conditionlogstr & ";"
						EndIf
						$conditionlogstr = $conditionlogstr & " Townhall Outside"
					EndIf
					$conditionlogstr = $conditionlogstr & " )"
					SetLog($conditionlogstr, $COLOR_GREEN)
				EndIf
				If IsChecked($chkAnyActivate) And $fullArmy Then
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
						$conditionlogstr = $conditionlogstr & " Max Townhall: " & $MaxTH
					EndIf
					If IsChecked($chkMeetTHO) Then
						If $conditionlogstr <> "Live Base (" Then
							$conditionlogstr = $conditionlogstr & ";"
						EndIf
						$conditionlogstr = $conditionlogstr & " Townhall Outside"
					EndIf
					$conditionlogstr = $conditionlogstr & " )"
					SetLog($conditionlogstr, $COLOR_GREEN)
				EndIf
				If IsChecked($chkNukeOnly) And $fullSpellFactory And $iNukeLimit > 0 Then
					$conditionlogstr = "Zap Base ( Dark: " & $iNukeLimit & " )"
					SetLog($conditionlogstr, $COLOR_GREEN)
				EndIf
			EndIf

			$GoodBase = False
			Local $conditionlogstr
			$NukeAttack = False

			$BaseData = GetResources()

			If Not IsArray($BaseData) Then Return -1

			$DG = (Number($BaseData[2]) >= Number($MinDeadGold))
			$DE = (Number($BaseData[3]) >= Number($MinDeadElixir))
			$DD = (Number($BaseData[4]) >= Number($MinDeadDark))
			$DT = (Number($BaseData[5]) >= Number($MinDeadTrophy))
			$G = (Number($BaseData[2]) >= Number($MinGold))
			$E = (Number($BaseData[3]) >= Number($MinElixir))
			$D = (Number($BaseData[4]) >= Number($MinDark))
			$T = (Number($BaseData[5]) >= Number($MinTrophy))

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

			If $THLoc = "Out" And IsChecked($chkDeadActivate) And IsChecked($chkDeadSnipe) And $BaseData[0] Then
				SetLog(GetLangText("msgOutDeadFound"), $COLOR_PURPLE)
				Return 0
			ElseIf $THLoc = "Out" And IsChecked($chkAnyActivate) And IsChecked($chkSnipe) And Not $BaseData[0] Then
				SetLog(GetLangText("msgOutLiveFound"), $COLOR_PURPLE)
				Return 1
			EndIf

			; Variables to check whether to attack dead bases
			Local $conditionDeadPass = True

			If IsChecked($chkDeadActivate) And $fullArmy Then
				If IsChecked($chkDeadGE) Then
					$deadEnabled = True
					If _GUICtrlComboBox_GetCurSel($cmbDead) = 0 Then ; And
						If $DG = False Or $DE = False Then $conditionDeadPass = False
					Else ; Or
						If $DG = False And $DE = False Then $conditionDeadPass = False
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

				If IsChecked($chkAnyActivate) And $fullArmy Then
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

			; Attack instantly if Attack Now button pressed
			GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
			If $AttackNow Then
				$AttackNow = False
				SetLog(GetLangText("msgAttackNowClicked"), $COLOR_GREEN)
				ExitLoop
			EndIf

			If $GoodBase Then
				ExitLoop
			Else
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(703, 520), Hex(0xD84400, 6), 20) Then
					Local $fDiffNow = TimerDiff($hTimerClickNext) - $fdiffReadGold  ;How long in attack prep mode
					if $fDiffNow < $speedBump + $icmbSearchsp * 1500 Then ; Wait accoridng to search speed + speedBump
						if _Sleep($speedBump + $icmbSearchsp * 1500 - $fDiffNow) Then ExitLoop (2)
					EndIf
					Click(750, 500) ;Click Next
					$hTimerClickNext = TimerInit()
					;Take time to do search
					GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
					GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
					If _Sleep(1000) Then Return -1
				ElseIf _ColorCheck(_GetPixelColor(71, 530), Hex(0xC00000, 6), 20) Then ;If End battle is available
					SetLog(GetLangText("msgNoNextReturn"), $COLOR_RED)
					ChkDisconnection(True)
					ReturnHome(False, False, True)
					Return -1
				Else
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
		If $PushBulletEnabled = 1 And $PushBulletmatchfound = 1 Then
			_Push(GetLangText("pushMatch"), "[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($BaseData[2]) & "; [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($BaseData[3]) & "; [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($BaseData[4]) & "; [" & GetLangText("msgTrophyInitial") & "]: " & $BaseData[5] & "; [TH Lvl]: " & $BaseData[1] & ", Loc: " & $THLoc)
			SetLog(GetLangText("msgPushMatch"), $COLOR_GREEN)
		EndIf
		SetLog(GetLangText("msgSearchComplete"), $COLOR_BLUE)
		_BlockInputEx(0, "", "", $HWnD)
		Return $AttackMethod
	WEnd
EndFunc   ;==>Standard_Search

