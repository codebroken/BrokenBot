Func VillageReport()
	StatusCheck()

	SetLog(GetLangText("msgVillageRep"), $COLOR_GREEN)

	$FreeBuilder = ReadText(320, 23, 41, $textMainScreen)
	Setlog(GetLangText("msgNumFreeBuild") & $FreeBuilder, $COLOR_GREEN)
	$FreeBuilder = Number(StringLeft($FreeBuilder, 1))

	If $PushBulletEnabled = 1 And $PushBulletfreebuilder = 1 And $FreeBuilder > 0 And Not ($buildernotified) Then
		_Push(GetLangText("pushFB"), GetLangText("pushFBb") & ($FreeBuilder = 1) ? (GetLangText("pushFBc") : $FreeBuilder) & GetLangText("pushFBd") & ($FreeBuilder = 1) ? ("" : GetLangText("pushFBe")) & GetLangText("pushFBf"))
		$buildernotified = True
		SetLog(GetLangText("msgPushFreeBuild"), $COLOR_GREEN)
	Else
		$buildernotified = False
	EndIf

	$TrophyCountOld = Number(GUICtrlRead($lblresulttrophynow))
	$TrophyCount = Number(ReadText(59, 75, 60, $textMainScreen))

	If Not $FirstAttack Then
		GUICtrlSetData($lblresulttrophygain, $TrophyCount - $TrophyCountOld)
	EndIf

	$GoldCountOld = $GoldCount
	$ElixirCountOld = $ElixirCount
	$DarkCountOld = $DarkCount
	$GoldCount = Number(ReadText(666, 25, 138, $textMainScreen, 0))
	$ElixirCount = Number(ReadText(666, 76, 138, $textMainScreen, 0))
	If _ColorCheck(_GetPixelColor(718, 131), Hex(0xF8FCFF, 6), 40) Then
		; No DE
		$GemCount = Number(ReadText(736, 124, 68, $textMainScreen, 0))
	Else
		$DarkCount = Number(ReadText(711, 125, 93, $textMainScreen, 0))
		$GemCount = Number(ReadText(736, 173, 68, $textMainScreen, 0))
	EndIf

	SetLog(GetLangText("msgResources") & " [" & GetLangText("msgGoldinitial") & "]: " & $GoldCount & " [" & GetLangText("msgElixirinitial") & "]: " & $ElixirCount & " [" & GetLangText("msgDarkElixinitial") & "]: " & $DarkCount & " [" & GetLangText("msgTrophyInitial") & "]: " & $TrophyCount & " [" & GetLangText("msgGemInitial") & "]: " & $GemCount, $COLOR_GREEN)

	If $FirstAttack Then
		GUICtrlSetData($lblresultgoldtstart, $GoldCount)
		GUICtrlSetData($lblresultelixirstart, $ElixirCount)
		GUICtrlSetData($lblresultdestart, $DarkCount)
		GUICtrlSetData($lblresulttrophystart, $TrophyCount)
	Else
		$GoldGained = $GoldCount - GUICtrlRead($lblresultgoldtstart)
		$ElixirGained = $ElixirCount - GUICtrlRead($lblresultelixirstart)
		$DarkGained = $DarkCount - GUICtrlRead($lblresultdestart)
		$TrophyGained = $TrophyCount - GUICtrlRead($lblresulttrophystart)

		If $PushBulletEnabled = 1 And $PushBulletvillagereport = 1 Then
			If TimerDiff($PushBulletvillagereportTimer) >= $PushBulletvillagereportInterval Then ;Report is due
				_Push(GetLangText("pushVR"), "[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount) & " [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount) & _
						" [" & GetLangText("msgTrophyInitial") & "]: " & $TrophyCount & " [" & GetLangText("msgGemInitial") & "]: " & $GemCount & " [Attacked]: " & GUICtrlRead($lblresultvillagesattacked) & _
						" [Skipped]: " & GUICtrlRead($lblresultvillagesskipped) & " [Wall Upgrade]: " & GUICtrlRead($lblwallupgradecount) & _
						" [Run Time]: " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec) & "\n" & GetLangText("pushStatRq1") & GUICtrlRead($lblresultsearchdisconnected))
				SetLog(GetLangText("msgPushVillageRep"), $COLOR_GREEN)
				$PushBulletvillagereportTimer = TimerInit()
			EndIf
		EndIf

		GUICtrlSetData($lblresultgoldgain, $GoldGained)
		GUICtrlSetData($lblresultelixirgain, $ElixirGained)
		GUICtrlSetData($lblresultdegain, $DarkGained)
		GUICtrlSetData($lblresulttrophygain, $TrophyGained)

		If Not $MidAttack And $Raid = 1 Then ;report when there is a Raid except when bot disconnected
			$SubmissionAttacks += 1
			$SubmissionGold += $LastRaidGold
			$SubmissionElixir += $LastRaidElixir
			$SubmissionDE += $LastRaidDarkElixir
			SetLog(GetLangText("msgLastRaidGain") & " [" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount - $GoldCountOld) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount - $ElixirCountOld) & _
					" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount - $DarkCountOld) & " [" & GetLangText("msgTrophyInitial") & "]: " & ($TrophyCount - $TrophyCountOld))
			SetLog(GetLangText("msgLastRaidLoot") & " [" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($LastRaidGold) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($LastRaidElixir) & _
					" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($LastRaidDarkElixir) & " [" & GetLangText("msgTrophyInitial") & "]: " & $LastRaidTrophy)
			If $PushBulletEnabled = 1 Then ;do pushbullet reports
				Local $PushReportText = GetLangText("pushLRb") & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount - $GoldCountOld) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount - $ElixirCountOld) & _
						" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount - $DarkCountOld) & " [" & GetLangText("msgTrophyInitial") & "]: " & ($TrophyCount - $TrophyCountOld) & _
						"\nLoot: \n[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($LastRaidGold) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($LastRaidElixir) & _
						" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($LastRaidDarkElixir) & " [" & GetLangText("msgTrophyInitial") & "]: " & $LastRaidTrophy & _
						"\n" & GetLangText("pushLootA") & "\n" & $MatchFoundText & _
						"\n" & GetLangText("pushBS") & $SearchCount & _
						GetLangText("pushStatRq1") & GUICtrlRead($lblresultsearchdisconnected) & _
						"\n" & GetLangText("pushVR") & " \n[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount) & _
						" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount) & " [" & GetLangText("msgTrophyInitial") & "]: " & $TrophyCount & " [" & GetLangText("msgGemInitial") & "]: " & $GemCount & _
						" [Attacked]: " & GUICtrlRead($lblresultvillagesattacked) & " [Skipped]: " & GUICtrlRead($lblresultvillagesskipped) & _
						" [Wall Upgrade]: " & GUICtrlRead($lblwallupgradecount)
				If IsChecked($UseJPG) Then
					If _Sleep(1000) Then Return
					_PushFile($FileName, "loots", "image/jpeg", "Last Raid", $FileName & "\n" & $PushReportText)
				EndIf
				If IsChecked($lbllastraid) Then
					_Push(GetLangText("pushLR"), $PushReportText)
					SetLog(GetLangText("msgPushLastRaid"), $COLOR_GREEN)
				EndIf
				$Raid = 0
			EndIf
			StatSubmission(True)
		EndIf
	EndIf

	GUICtrlSetData($lblresultgoldnow, $GoldCount)
	GUICtrlSetData($lblresultelixirnow, $ElixirCount)
	GUICtrlSetData($lblresultdenow, $DarkCount)
	GUICtrlSetData($lblresulttrophynow, $TrophyCount)
	$FirstAttack = False
EndFunc   ;==>VillageReport
