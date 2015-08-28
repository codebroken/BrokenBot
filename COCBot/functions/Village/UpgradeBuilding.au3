Func UpgradeBuilding()
	$ichkUpgrade1 = GUICtrlRead($chkUpgrade1)
	$ichkUpgrade2 = GUICtrlRead($chkUpgrade2)
	$ichkUpgrade3 = GUICtrlRead($chkUpgrade3)
	If $ichkUpgrade1 = 0 And $ichkUpgrade2 = 0 And $ichkUpgrade3 = 0 Then Return

	If GUICtrlRead($txtUpgradeX1) = "" And GUICtrlRead($txtUpgradeX2) = "" And GUICtrlRead($txtUpgradeX3) = "" Then
		SetLog(GetLangText("msgUpgLocNotSet"), $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf
	VillageReport()
	If $FreeBuilder < $itxtKeepFreeBuilder+1 Then
		SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf

	Local $ElixirUpgrade1 = False
	Local $ElixirUpgrade2 = False
	Local $ElixirUpgrade3 = False
	Local $iMinGold = Number(GUICtrlRead($txtWallMinGold))
	Local $iMinElixir = Number(GUICtrlRead($txtWallMinElixir))
	Local $iGoldStorage = Number($GoldCount)
	Local $iElixirStorage = Number($ElixirCount)

	;Upgrade 1
	If $iElixirStorage < $iMinElixir And $iGoldStorage < $iMinGold Then Return

	If $ichkUpgrade1 = 1 Then
		SetLog(GetLangText("msgAttemptUpgr") & " 1...")

		If _Sleep(500) Then Return
		Click(GUICtrlRead($txtUpgradeX1), GUICtrlRead($txtUpgradeY1))
		If _Sleep(500) Then Return

		Local $ElixirUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF759E8, 6), 10) ;Finds Elixir Upgrade Button
		Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button

		If IsArray($ElixirUpgrade) Then
			If $iElixirStorage < $iMinElixir Then
				SetLog(GetLangText("msgNotEnoughElix"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				$ElixirUpgrade1 = True
				Click($ElixirUpgrade[0], $ElixirUpgrade[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
				If IsArray($UpgradeCheck) Then
					Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
					If _Sleep(1000) Then Return
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(571, 263) <> Hex(0xD90404, 6), 20) Then
						SetLog(GetLangText("msgBuilding") & " 1 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						SetLog(GetLangText("msgUnchecking"), $COLOR_GREEN)
						GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
					Else
						SetLog(GetLangText("msgNotEnoughElix"), $COLOR_RED)
						ClickP($TopLeftClient, 2)
						If $iGoldStorage >= $iMinGold Then
							Click(GUICtrlRead($txtUpgradeX1), GUICtrlRead($txtUpgradeY1))
							If _Sleep(500) Then Return
							GoldUpgrade1()
						ElseIf $iGoldStorage < $iMinGold Then
							SetLog(GetLangText("msgGoldLower"), $COLOR_RED)
							If _Sleep(1000) Then Return
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf

		If IsArray($GoldUpgrade) And Not $ElixirUpgrade1 Then
			If $iGoldStorage < $iMinGold Then
				SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				Click($GoldUpgrade[0], $GoldUpgrade[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
				If IsArray($UpgradeCheck) Then
					Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
					If _Sleep(1000) Then Return
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
						SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
						ClickP($TopLeftClient, 2)
					Else
						SetLog(GetLangText("msgBuilding") & " 1 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						SetLog(GetLangText("msgUnchecking"), $COLOR_GREEN)
						GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
					EndIf
				EndIf
			EndIf
		EndIf

		VillageReport()
		If _Sleep(1000) Then Return
		If $FreeBuilder < $itxtKeepFreeBuilder+1 Then
			SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
			ClickP($TopLeftClient) ; Click Away
			Return
		EndIf
		If _Sleep(1000) Then Return
		$iGoldStorage = Number($GoldCount)
		$iElixirStorage = Number($ElixirCount)
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf

	If $iElixirStorage < $iMinElixir And $iGoldStorage < $iMinGold Then Return

	;Upgrade 2

	If $ichkUpgrade2 = 1 Then
		SetLog(GetLangText("msgAttemptUpgr") & " 2...")

		If _Sleep(500) Then Return
		Click(GUICtrlRead($txtUpgradeX2), GUICtrlRead($txtUpgradeY2))
		If _Sleep(500) Then Return

		Local $ElixirUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF759E8, 6), 10) ;Finds Elixir Upgrade Button
		Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button

		If IsArray($ElixirUpgrade) Then
			If $iElixirStorage < $iMinElixir Then
				SetLog(GetLangText("msgNotEnoughElix"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				$ElixirUpgrade2 = True
				Click($ElixirUpgrade[0], $ElixirUpgrade[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
				If IsArray($UpgradeCheck) Then
					Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
					If _Sleep(1000) Then Return
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(571, 263) <> Hex(0xD90404, 6), 20) Then
						SetLog(GetLangText("msgBuilding") & " 2 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						GUICtrlSetState($chkUpgrade2, $GUI_UNCHECKED)
					Else
						SetLog(GetLangText("msgNotEnoughElix"), $COLOR_RED)
						ClickP($TopLeftClient, 2)
						If $iGoldStorage >= $iMinGold Then
							Click(GUICtrlRead($txtUpgradeX2), GUICtrlRead($txtUpgradeY2))
							If _Sleep(500) Then Return
							GoldUpgrade2()
						ElseIf $iGoldStorage < $iMinGold Then
							SetLog(GetLangText("msgGoldLower"), $COLOR_RED)
							If _Sleep(1000) Then Return
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf

		If IsArray($GoldUpgrade) And Not $ElixirUpgrade2 Then
			If $iGoldStorage < $iMinGold Then
				SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				Click($GoldUpgrade[0], $GoldUpgrade[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
				If IsArray($UpgradeCheck) Then
					Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
					If _Sleep(1000) Then Return
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
						SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
						ClickP($TopLeftClient, 2)
					Else
						SetLog(GetLangText("msgBuilding") & " 2 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						GUICtrlSetState($chkUpgrade2, $GUI_UNCHECKED)
					EndIf
				EndIf
			EndIf
		EndIf

		VillageReport()
		If _Sleep(1000) Then Return
		If $FreeBuilder < $itxtKeepFreeBuilder+1 Then
			SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
			ClickP($TopLeftClient) ; Click Away
			Return
		EndIf
		If _Sleep(1000) Then Return
		$iGoldStorage = Number($GoldCount)
		$iElixirStorage = Number($ElixirCount)
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf

	If $iElixirStorage < $iMinElixir And $iGoldStorage < $iMinGold Then Return

	;Upgrade 3
	If $ichkUpgrade3 = 1 Then
		SetLog(GetLangText("msgAttemptUpgr") & " 3...")

		If _Sleep(500) Then Return
		Click(GUICtrlRead($txtUpgradeX3), GUICtrlRead($txtUpgradeY3))
		If _Sleep(500) Then Return

		Local $ElixirUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF759E8, 6), 10) ;Finds Elixir Upgrade Button
		Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button

		If IsArray($ElixirUpgrade) Then
			If $iElixirStorage < $iMinElixir Then
				SetLog(GetLangText("msgNotEnoughElix"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				$ElixirUpgrade3 = True
				Click($ElixirUpgrade[0], $ElixirUpgrade[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
				If IsArray($UpgradeCheck) Then
					Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
					If _Sleep(1000) Then Return
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(571, 263) <> Hex(0xD90404, 6), 20) Then
						SetLog(GetLangText("msgBuilding") & " 3 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						GUICtrlSetState($chkUpgrade3, $GUI_UNCHECKED)
					Else
						SetLog(GetLangText("msgNotEnoughElix"), $COLOR_RED)
						ClickP($TopLeftClient, 2)
						If $iGoldStorage >= $iMinGold Then
							Click(GUICtrlRead($txtUpgradeX3), GUICtrlRead($txtUpgradeY3))
							If _Sleep(500) Then Return
							GoldUpgrade3()
						ElseIf $iGoldStorage < $iMinGold Then
							SetLog(GetLangText("msgGoldLower"), $COLOR_RED)
							If _Sleep(1000) Then Return
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf

		If IsArray($GoldUpgrade) And Not $ElixirUpgrade3 Then
			If $iGoldStorage < $iMinGold Then
				SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				Click($GoldUpgrade[0], $GoldUpgrade[1]) ;Click Upgrade Button
				If _Sleep(1000) Then Return
				Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
				If IsArray($UpgradeCheck) Then
					Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
					If _Sleep(1000) Then Return
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
						SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
						ClickP($TopLeftClient, 2)
					Else
						SetLog(GetLangText("msgBuilding") & " 3 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						GUICtrlSetState($chkUpgrade3, $GUI_UNCHECKED)
					EndIf
				EndIf
			EndIf
		EndIf

		VillageReport()
		If _Sleep(1000) Then Return
		If $FreeBuilder < $itxtKeepFreeBuilder+1 Then
			SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
			ClickP($TopLeftClient) ; Click Away
			Return
		EndIf
		If _Sleep(1000) Then Return
		$iGoldStorage = Number($GoldCount)
		$iElixirStorage = Number($ElixirCount)
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf
EndFunc   ;==>UpgradeBuilding

Func GoldUpgrade1()
	Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button
	If IsArray($GoldUpgrade) Then
		Click($GoldUpgrade[0], $GoldUpgrade[1]) ;Click Upgrade Button
		If _Sleep(1000) Then Return
		Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
		If IsArray($UpgradeCheck) Then
			Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
			If _Sleep(1000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
				SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				SetLog(GetLangText("msgBuilding") & " 1 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
				GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>GoldUpgrade1

Func GoldUpgrade2()
	Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button
	If IsArray($GoldUpgrade) Then
		Click($GoldUpgrade[0], $GoldUpgrade[1]) ;Click Upgrade Button
		If _Sleep(1000) Then Return
		Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
		If IsArray($UpgradeCheck) Then
			Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
			If _Sleep(1000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
				SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				SetLog(GetLangText("msgBuilding") & " 2 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
				GUICtrlSetState($chkUpgrade2, $GUI_UNCHECKED)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>GoldUpgrade2

Func GoldUpgrade3()
	Local $GoldUpgrade = _PixelSearch(300, 560, 629, 583, Hex(0xF4EE54, 6), 10) ;Finds Gold Upgrade Button
	If IsArray($GoldUpgrade) Then
		Click($GoldUpgrade[0], $GoldUpgrade[1]) ;Click Upgrade Button
		If _Sleep(1000) Then Return
		Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
		If IsArray($UpgradeCheck) Then
			Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
			If _Sleep(1000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
				SetLog(GetLangText("msgNotEnoughGold"), $COLOR_RED)
				ClickP($TopLeftClient, 2)
			Else
				SetLog(GetLangText("msgBuilding") & " 3 " & GetLangText("msgUpgradeSuccess"), $COLOR_GREEN)
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
				GUICtrlSetState($chkUpgrade3, $GUI_UNCHECKED)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>GoldUpgrade3
