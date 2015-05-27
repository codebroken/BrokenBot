Func UpgradeHero()
	$ichkUpgradeBK = GUICtrlRead($chkUpgradeBK)
	$ichkUpgradeAQ = GUICtrlRead($chkUpgradeAQ)
	
	If $ichkUpgradeBK = 0 And $ichkUpgradeAQ = 0 Then Return

	If $ichkUpgradeBK = 1  And $KingPos[0] = "" Then
		If Not LocateKingAltar() Then Return
		SaveConfig()
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient) ;Click Away
	EndIf
	
	If $ichkUpgradeAQ And $QueenPos[0] = "" Then
		If Not LocateQueenAltar() Then Return
		SaveConfig()
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient) ;Click Away
	EndIf
	
	VillageReport()
	If $FreeBuilder = 0 Then
		SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf

	Local $itxtMinHeroDE = Number(GUICtrlRead($txtMinHeroDE))
	Local $iDEStorage = Number($DarkCount)

	;Upgrade BK
	If $iDEStorage < $itxtMinHeroDE Then Return

	If $ichkUpgradeBK = 1 Then
		SetLog(GetLangText("msgAttemptUpgrBK"))

		If _Sleep(500) Then Return
		Click($KingPos[0], $KingPos[1])
		If _Sleep(500) Then Return
		
		;Local $ElixirUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF759E8, 6), 10) ;Finds Elixir Upgrade Button
		;Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button
		Local $DEUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0x574460, 6), 10) ;Finds DE Upgrade Button

		If IsArray($DEUpgrade) Then
			Click($DEUpgrade[0], $DEUpgrade[1]) ;Click Upgrade Button
			If _Sleep(1000) Then Return
			Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
			If IsArray($UpgradeCheck) Then
				Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(571, 263) <> Hex(0xD90404, 6), 20) Then 
					SetLog("BK " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
					If _Sleep(1000) Then Return
					ClickP($TopLeftClient, 2)
					SetLog(GetLangText("msgUnchecking"), $COLOR_GREEN)
					GUICtrlSetState($chkUpgradeBK, $GUI_UNCHECKED)
				Else
					SetLog(GetLangText("msgNotEnoughDE"), $COLOR_RED)
					ClickP($TopLeftClient, 2)					
				EndIf
			EndIf
		Else
			SetLog(GetLangText("msgHeroUpgradeNotFound"), $COLOR_RED)
			ClickP($TopLeftClient, 2)	
		EndIf		

		VillageReport()
		If _Sleep(1000) Then Return
		If $FreeBuilder = 0 Then
			SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
			ClickP($TopLeftClient) ; Click Away
			Return
		EndIf
		If _Sleep(1000) Then Return
		$iDEStorage = Number($DarkCount)
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf

	If $iDEStorage < $itxtMinHeroDE Then Return

	;Upgrade AQ

	If $ichkUpgradeAQ = 1 Then
		SetLog(GetLangText("msgAttemptUpgrAQ"))

		If _Sleep(500) Then Return
		Click($QueenPos[0], $QueenPos[1])
		If _Sleep(500) Then Return
		
		;Local $ElixirUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF759E8, 6), 10) ;Finds Elixir Upgrade Button
		;Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button
		Local $DEUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0x574460, 6), 10) ;Finds DE Upgrade Button

		If IsArray($DEUpgrade) Then
			Click($DEUpgrade[0], $DEUpgrade[1]) ;Click Upgrade Button
			If _Sleep(1000) Then Return
			Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
			If IsArray($UpgradeCheck) Then
				Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(571, 263) <> Hex(0xD90404, 6), 20) Then
					SetLog("AQ " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
					If _Sleep(1000) Then Return
					ClickP($TopLeftClient, 2)
				Else
					SetLog(GetLangText("msgNotEnoughDE"), $COLOR_RED)
					ClickP($TopLeftClient, 2)					
				EndIf				
			EndIf
		Else
			SetLog(GetLangText("msgHeroUpgradeNotFound"), $COLOR_RED)
			ClickP($TopLeftClient, 2)
		EndIf		

		VillageReport()
		If _Sleep(1000) Then Return
		If $FreeBuilder = 0 Then
			SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
			ClickP($TopLeftClient) ; Click Away
			Return
		EndIf
		If _Sleep(1000) Then Return
		$iDEStorage = Number($DarkCount)
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf
EndFunc