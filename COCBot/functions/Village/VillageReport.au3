

Func VillageReport()
	ClickP($TopLeftClient) ;Click Away
	If _Sleep(500) Then Return

	SetLog(GetLangText("msgVillageRep"), $COLOR_GREEN)

	$FreeBuilder = GetOther(324, 23, "Builder")
	Setlog(GetLangText("msgNumFreeBuild") & $FreeBuilder, $COLOR_GREEN)
	If $PushBulletEnabled = 1 And $PushBulletfreebuilder = 1 And $FreeBuilder > 0 And Not ($buildernotified) Then
		_Push(GetLangText("pushFB"), GetLangText("pushFBb") & ($FreeBuilder = 1) ? (GetLangText("pushFBc") : $FreeBuilder) & GetLangText("pushFBd") & ($FreeBuilder = 1) ? ("" : GetLangText("pushFBe")) & GetLangText("pushFBf"))
		$buildernotified = True
		SetLog(GetLangText("msgPushFreeBuild"), $COLOR_GREEN)
	Else
		$buildernotified = False
	EndIf

	$TrophyCountOld = GUICtrlRead($lblresulttrophynow)
	$TrophyCount = getOther(50, 74, "Trophy")

	If Not $FirstAttack Then
		GUICtrlSetData($lblresulttrophygain, $TrophyCount - $TrophyCountOld)
	EndIf

	SetLog(GetLangText("msgOpeningBuilder"), $COLOR_BLUE)
	Click(388, 30) ; Click Builder Button
	_CaptureRegion()
	Local $i = 0
	While _ColorCheck(_GetPixelColor(819, 39), Hex(0xF8FCFF, 6), 20) = False
		$i += 1
		If _Sleep(50) Then Return
		_CaptureRegion()
		If $i >= 200 Then ExitLoop
	WEnd


	$GoldCountOld = $GoldCount
	$ElixirCountOld = $ElixirCount
	$DarkCountOld = $DarkCount
	If _ColorCheck(_GetPixelColor(318, 637), Hex(0xD854D0, 6), 20) Then
		;without DE, set DarkCount = 0 and different location of gold/elixir reading
		$GoldCount = GetOther(356, 625, "Resource")
		$ElixirCount = GetOther(195, 625, "Resource")
		$GemCount = GetOther(543, 625, "Gems")
		$DarkCount = 0
	Else
		$GoldCount = GetOther(440, 625, "Resource")
		$ElixirCount = GetOther(282, 625, "Resource")
		$DarkCount = GetOther(125, 625, "Resource")
		$GemCount = GetOther(606, 625, "Gems")
	EndIf

	Click(820, 40) ; Close Builder/Shop

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
			_Push(GetLangText("pushVR"), "[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount) & " [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount) & _
					" [" & GetLangText("msgTrophyInitial") & "]: " & $TrophyCount & " [" & GetLangText("msgGemInitial") & "]: " & $GemCount & " [Attacked]: " & GUICtrlRead($lblresultvillagesattacked) & _
					" [Skipped]: " & GUICtrlRead($lblresultvillagesskipped) & " [Wall Upgrade]: " & GUICtrlRead($lblwallupgradecount) & _
					" [Run Time]: " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
			SetLog(GetLangText("msgPushVillageRep"), $COLOR_GREEN)
		EndIf

		GUICtrlSetData($lblresultgoldgain, $GoldGained)
		GUICtrlSetData($lblresultelixirgain, $ElixirGained)
		GUICtrlSetData($lblresultdegain, $DarkGained)
		GUICtrlSetData($lblresulttrophygain, $TrophyGained)

		If Not $MidAttack And $Raid = 1 Then ;report when there is a Raid except when bot disconnected
			SetLog(GetLangText("msgLastRaidGain") & " [" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount - $GoldCountOld) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount - $ElixirCountOld) & _
					" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount - $DarkCountOld) & " [" & GetLangText("msgTrophyInitial") & "]: " & ($TrophyCount - $TrophyCountOld))
			SetLog(GetLangText("msgLastRaidLoot") & " [" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($LastRaidGold) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($LastRaidElixir) & _
					" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($LastRaidDarkElixir) & " [" & GetLangText("msgTrophyInitial") & "]: " & $LastRaidTrophy)
			If $PushBulletEnabled = 1 Then ;do pushbullet reports
				If $PushBullettype = 1 Then ;As JPG
					If _Sleep(2000) Then Return
					_PushFile($FileName, "loots", "image/jpeg", "Last Raid", $FileName)
				EndIf
				If $PushBulletlastraid = 1 Then ;As Txt
					_Push(GetLangText("pushLR"), GetLangText("pushLRb") & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount - $GoldCountOld) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount - $ElixirCountOld) & _
							" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount - $DarkCountOld) & " [" & GetLangText("msgTrophyInitial") & "]: " & ($TrophyCount - $TrophyCountOld) & _
							"\nLoot: \n[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($LastRaidGold) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($LastRaidElixir) & _
							" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($LastRaidDarkElixir) & " [" & GetLangText("msgTrophyInitial") & "]: " & $LastRaidTrophy & _
							"\nVillage Report: \n[" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($GoldCount) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($ElixirCount) & _
							" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($DarkCount) & " [" & GetLangText("msgTrophyInitial") & "]: " & $TrophyCount & " [" & GetLangText("msgGemInitial") & "]: " & $GemCount & _
							" [Attacked]: " & GUICtrlRead($lblresultvillagesattacked) & " [Skipped]: " & GUICtrlRead($lblresultvillagesskipped) & _
							" [Wall Upgrade]: " & GUICtrlRead($lblwallupgradecount))
					SetLog(GetLangText("msgPushLastRaid"), $COLOR_GREEN)
				EndIf
				$Raid = 0
			EndIf
		EndIf
	EndIf

	GUICtrlSetData($lblresultgoldnow, $GoldCount)
	GUICtrlSetData($lblresultelixirnow, $ElixirCount)
	GUICtrlSetData($lblresultdenow, $DarkCount)
	GUICtrlSetData($lblresulttrophynow, $TrophyCount)
	$FirstAttack = False
EndFunc   ;==>VillageReport
