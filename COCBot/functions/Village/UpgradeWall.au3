Global $wallbuild
Global $walllowlevel

Func UpgradeWall()
	If Not IsChecked($chkWalls) Then Return

	VillageReport()
	SetLog(GetLangText("msgCheckWalls"))
	$itxtWallMinGold = GUICtrlRead($txtWallMinGold)
	$itxtWallMinElixir = GUICtrlRead($txtWallMinElixir)
	Local $MinWallGold = Number($GoldCount) > Number($itxtWallMinGold)
	Local $MinWallElixir = Number($ElixirCount) > Number($itxtWallMinElixir)

	If IsChecked($UseGold) Then
		If $MinWallGold Then
			SetLog(GetLangText("msgWallUpGold"), $COLOR_BLUE)
			UpgradeWallGold()			
		Else
			SetLog(GetLangText("msgGoldBelowMin"), $COLOR_RED)
		EndIf
	EndIf
	If IsChecked($UseElixir) Then
		If $MinWallElixir Then
			Setlog(GetLangText("msgWallUpElix"), $COLOR_BLUE)
			UpgradeWallelix()			
		Else
			Setlog(GetLangText("msgElixBelowMin"), $COLOR_BLUE)
		EndIf
	EndIf

EndFunc   ;==>UpgradeWall


Func UpgradeWallelix()
	If $FreeBuilder = 0 Then
		SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
		Click(1, 1) ; Click Away
		Return
	EndIf

	checkWallE()
	If $checkwalllogic Then
		Click(1, 1) ; Click Away
		_Sleep(600)
		Click($WallX, $WallY)
		_Sleep(600)
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(595, 568), Hex(0xFFFFFF, 6), 20) = False Then
			SetLog(GetLangText("msgWallElixorLvl"), $COLOR_ORANGE)
			Click(1, 1) ; Click away
			_Sleep(1000)
		Else
			Click(560, 599) ; Click Upgrade
			_Sleep(2000)
			Click(472, 482) ; Click Okay
			SetLog(GetLangText("msgWallUpDone"), $COLOR_BLUE) ; Done upgrade
			GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount) + 1)
			Click(1, 1) ; Click away
			_Sleep(1000)
		EndIf
	EndIf
	Click(1, 1) ; Click Away
EndFunc   ;==>UpgradeWallelix


Func UpgradeWallGold()
	If $FreeBuilder = 0 Then
		SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
		Click(1, 1) ; Click Away
		Return
	EndIf

	checkWall()
	If $checkwalllogic Then
		Click(1, 1) ; Click Away
		_Sleep(600)
		Click($WallX, $WallY)
		_Sleep(600)
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(523, 641), Hex(0x000000, 6), 20) = False Then ; checking wall level high than level 8
			$walllowlevel = 0
			If Not _ColorCheck(_GetPixelColor(500, 570), Hex(0xFEFEFE, 6), 20) Then
				SetLog(GetLangText("msgWallNotEnoughGold"), $COLOR_ORANGE)
				Click(1, 1) ; Click Away
				$wallbuild = 0
			Else
				Click(505, 596) ; Click Upgrade
				_Sleep(2000)
				Click(472, 482) ; Click Okay
				SetLog(GetLangText("msgWallUpDone"), $COLOR_BLUE) ; Done upgrade
				GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount) + 1)
				_Sleep(1000)
				Click(1, 1) ; Click Away
			EndIf
		Else ; check wall level lower than 8
			$walllowlevel = 1
			If Not _ColorCheck(_GetPixelColor(547, 570), Hex(0xFFFFFF, 6), 20) Then
				SetLog(GetLangText("msgWallNotEnoughGold"), $COLOR_ORANGE)
				Click(1, 1) ; Click Away
				$wallbuild = 0
			Else
				Click(505, 596) ; Click Upgrade
				_Sleep(2000)
				Click(472, 482) ; Click Okay
				SetLog(GetLangText("msgWallUpDone"), $COLOR_BLUE) ; Done upgrade
				GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount) + 1)
				_Sleep(1000)
				Click(1, 1) ; Click Away
			EndIf
		EndIf
	EndIf
	Click(1, 1) ; Click Away
EndFunc   ;==>UpgradeWallGold
