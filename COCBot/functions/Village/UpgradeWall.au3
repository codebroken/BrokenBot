Global $wallbuild
Global $walllowlevel

Func UpgradeWall()
	If Not IsChecked($chkWalls) Then Return

	VillageReport()
	SetLog("Checking Upgrade Walls...")
	$itxtWallMinGold = GUICtrlRead($txtWallMinGold)
	$itxtWallMinElixir = GUICtrlRead($txtWallMinElixir)
	Local $MinWallGold = Number($GoldCount) > Number($itxtWallMinGold)
	Local $MinWallElixir = Number($ElixirCount) > Number($itxtWallMinElixir)

	If IsChecked($UseGold) Then
		$iUseStorage = 1
	ElseIf IsChecked($UseElixir) Then
		$iUseStorage = 2
	ElseIf IsChecked($UseGoldElix) Then
		$iUseStorage = 3
	EndIf

	Switch $iUseStorage
		Case 1
			If $MinWallGold Then
				SetLog("Upgrading walls using Gold", $COLOR_BLUE)
				UpgradeWallGold()
				Return True
			Else
				SetLog("Gold is lower than Minimum setting, skipping ugrade", $COLOR_RED)
			EndIf
		Case 2
			If $MinWallElixir Then
				Setlog("Upgrading walls using Elixir", $COLOR_BLUE)
				UpgradeWallelix()
				Return True
			Else
				Setlog("Elixir is lower than Minimum setting, skipping ugrade", $COLOR_BLUE)
			EndIf
		Case 3
			If $MinWallGold Then
				SetLog("Upgrading walls using Gold", $COLOR_BLUE)
				UpgradeWallGold()
				If $wallbuild = 0 And $walllowlevel = 0 Then
					SetLog("Upgrade with Gold failed, trying upgrade using Elixir", $COLOR_BLUE)
					;UpgradeWallElix()
				EndIf
			Else
				SetLog("Gold is lower than Minimum setting, trying upgrade walls using Elixir", $COLOR_RED)
			EndIf

			;Do upgrade using Elixir
			If $walllowlevel = 0 Then
				If $MinWallElixir Then
					UpgradeWallelix()
				Else
					Setlog("Elixir is lower than Minimum setting, skipping ugrade", $COLOR_BLUE)
				EndIf
			Else
				SetLog("Wall level lower than 8, skipping upgrade with Elixir", $COLOR_BLUE)
			EndIf

	EndSwitch
EndFunc   ;==>UpgradeWall


Func UpgradeWallelix()
	If $FreeBuilder = 0 Then
		SetLog("No builders available", $COLOR_RED)
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
		If _ColorCheck(_GetPixelColor(595, 568), Hex(0xFFFFFF, 6), 20) = False Then
			SetLog("Not enough Elixir or your Wall is lower than level 8 ", $COLOR_ORANGE)
			Click(1, 1) ; Click away
			_Sleep(1000)
		Else
			Click(560, 599) ; Click Upgrade
			_Sleep(2000)
			Click(472, 482) ; Click Okay
			SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
;~ 			$WallUpgrade += 1
;~ 			GUICtrlSetData($lblwallupgradecount, $WallUpgrade)
			GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount) + 1)
			Click(1, 1) ; Click away
			_Sleep(1000)
		EndIf
	EndIf
	Click(1, 1) ; Click Away
EndFunc   ;==>UpgradeWallelix


Func UpgradeWallGold()
	If $FreeBuilder = 0 Then
		SetLog("No builders available", $COLOR_RED)
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
				SetLog("Not enough Gold...", $COLOR_ORANGE)
				Click(1, 1) ; Click Away
				$wallbuild = 0
			Else
				Click(505, 596) ; Click Upgrade
				_Sleep(2000)
				Click(472, 482) ; Click Okay
				SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
				GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount) + 1)
				_Sleep(1000)
				Click(1, 1) ; Click Away
			EndIf
		Else ; check wall level lower than 8
			$walllowlevel = 1
			If Not _ColorCheck(_GetPixelColor(547, 570), Hex(0xFFFFFF, 6), 20) Then
				SetLog("Not enough Gold...", $COLOR_ORANGE)
				Click(1, 1) ; Click Away
				$wallbuild = 0
			Else
				Click(505, 596) ; Click Upgrade
				_Sleep(2000)
				Click(472, 482) ; Click Okay
				SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
				GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount) + 1)
				_Sleep(1000)
				Click(1, 1) ; Click Away
			EndIf
		EndIf
	EndIf
	Click(1, 1) ; Click Away
EndFunc   ;==>UpgradeWallGold
