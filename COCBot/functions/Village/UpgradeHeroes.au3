; #FUNCTION# ====================================================================================================================
; Name ..........: Upgrade Heroes
; Description ...: This file includes functions to upgrade heroes
; Author ........: Bunana123@obudu (2015)
; ===============================================================================================================================
Func UpgradeHeroes()
If $ichkUpgradeKing = 0 And $ichkUpgradeQueen = 0 Then Return

			$FreeBuilder = ReadText(320, 23, 41, $textMainScreen)
			Setlog(GetLangText("msgNumFreeBuild") & $FreeBuilder, $COLOR_GREEN)
			GUICtrlSetData($lblfreebuilder, $FreeBuilder)
			If $FreeBuilder < $itxtKeepFreeBuilder+1 Then
			   SetLog(GetLangText("msgFreeBuilder"), $COLOR_RED)
			   Return
			EndIf
;upgradequeen
		  If $ichkUpgradeQueen = 1 Then
			If $QueenPos[0] = "" Then
				LocateQueenAltar()
				SaveConfig()
				If _Sleep(500) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf

			SetLog(GetLangText("msgUpgradeQueen"))
			Click($QueenPos[0], $QueenPos[1]) ;Click Queen Altar
			If _Sleep(500) Then Return
				_CaptureRegion()
				  If _ColorCheck(_GetPixelColor(605, 570), Hex(0xD8EC71, 6), 20) Then ; Finds Heal button
					QueenUpgrade()
					ElseIf _ColorCheck(_GetPixelColor(595, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
						SetLog(GetLangText("msgNotEnoughDEAQ"), $COLOR_ORANGE)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
					Else
						If _ColorCheck(_GetPixelColor(554, 570), Hex(0xC8EE6A, 6), 20) Then ; Green color
						SetLog(GetLangText("msgQueenUpgrading"), $COLOR_ORANGE)
					    If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						Else
						Click(604, 592) ;Click Upgrade Button
						If _Sleep(2000) Then Return
						Click(578, 512) ;Click Confirm Button
						If _Sleep(500) Then Return
							_CaptureRegion()
						If _ColorCheck(_GetPixelColor(743, 152), Hex(0xE51016, 6), 20) Then ;red arrow
							SetLog(GetLangText("msgHeroesMaxLvl"), $COLOR_RED)
							ClickP($TopLeftClient) ; Click Away
							GUICtrlSetState($chkUpgradeQueen, $GUI_UNCHECKED)
							If _Sleep(500) Then Return
						Else
						SetLog(GetLangText("msgQueenUpgraded"), $COLOR_BLUE)
						ClickP($TopLeftClient, 2)
					EndIf
				EndIf
			EndIf

		 $FreeBuilder = ReadText(320, 23, 41, $textMainScreen)
		 Setlog(GetLangText("msgNumFreeBuild") & $FreeBuilder, $COLOR_GREEN)
		 GUICtrlSetData($lblfreebuilder, $FreeBuilder)
		 If _Sleep(1000) Then Return
		 If $FreeBuilder < $itxtKeepFreeBuilder+1 Then
		   SetLog(GetLangText("msgFreeBuilder"), $COLOR_RED)
		   ClickP($TopLeftClient) ; Click Away
		   Return
		 EndIf
		 ClickP($TopLeftClient, 2)
		 EndIf

;upgradeking
		 If $ichkUpgradeKing = 1 Then
			If $KingPos[0] = "" Then
				LocateKingAltar()
				SaveConfig()
				If _Sleep(500) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf
			SetLog(GetLangText("msgUpgradeKing"))
			Click($KingPos[0], $KingPos[1]) ;Click King Altar
			If _Sleep(500) Then Return
				_CaptureRegion()
					If _ColorCheck(_GetPixelColor(605, 570), Hex(0xD8EC71, 6), 20) Then ; Finds Heal button
						KingUpgrade()
					ElseIf _ColorCheck(_GetPixelColor(595, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
						SetLog(GetLangText("msgNotEnoughDEK"), $COLOR_ORANGE)
						If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
					Else
						If _ColorCheck(_GetPixelColor(554, 570), Hex(0xC8EE6A, 6), 20) Then ; Green color
						SetLog(GetLangText("msgKingUpgrading"), $COLOR_ORANGE)
					    If _Sleep(1000) Then Return
						ClickP($TopLeftClient, 2)
						Else
						Click(604, 592) ;Click Upgrade Button
						If _Sleep(2000) Then Return
						Click(578, 512) ;Click Confirm Button
						If _Sleep(500) Then Return
							_CaptureRegion()
						If _ColorCheck(_GetPixelColor(743, 152), Hex(0xE51016, 6), 20) Then ;red arrow
							SetLog(GetLangText("msgHeroesMaxLvl"), $COLOR_RED)
							ClickP($TopLeftClient) ; Click Away
							GUICtrlSetState($chkUpgradeKing, $GUI_UNCHECKED)
							If _Sleep(500) Then Return
						Else
						SetLog(GetLangText("msgKingUpgraded"), $COLOR_BLUE)
						ClickP($TopLeftClient, 2)
					EndIf
				EndIf
			EndIf

		 $FreeBuilder = ReadText(320, 23, 41, $textMainScreen)
		 Setlog(GetLangText("msgNumFreeBuild") & $FreeBuilder, $COLOR_GREEN)
		 GUICtrlSetData($lblfreebuilder, $FreeBuilder)
		 If _Sleep(1000) Then Return
		 If $FreeBuilder < $itxtKeepFreeBuilder+1 Then
		   SetLog(GetLangText("msgFreeBuilder"), $COLOR_RED)
		   ClickP($TopLeftClient) ; Click Away
		   Return
		 EndIf
		 ClickP($TopLeftClient, 2)
		 EndIf
EndFunc

Func KingUpgrade()
_CaptureRegion()
If _ColorCheck(_GetPixelColor(501, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
	SetLog(GetLangText("msgNotEnoughDEK"), $COLOR_ORANGE)
	If _Sleep(1000) Then Return
	ClickP($TopLeftClient, 2)
Else
	Click(504, 592) ;Click Upgrade Button
	If _Sleep(2000) Then Return
	Click(578, 512) ;Click Confirm Button
	If _Sleep(500) Then Return
		_CaptureRegion()
	If _ColorCheck(_GetPixelColor(743, 152), Hex(0xE51016, 6), 20) Then ;red arrow
		SetLog(GetLangText("msgHeroesMaxLvl"), $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		GUICtrlSetState($chkUpgradeKing, $GUI_UNCHECKED)
		If _Sleep(500) Then Return
	Else
		SetLog(GetLangText("msgKingUpgraded"), $COLOR_BLUE)
		If _Sleep(1000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf
EndIf
EndFunc

Func QueenUpgrade()
_CaptureRegion()
If _ColorCheck(_GetPixelColor(501, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
	SetLog(GetLangText("msgNotEnoughDEAQ"), $COLOR_ORANGE)
	If _Sleep(1000) Then Return
	ClickP($TopLeftClient, 2)
Else
	Click(504, 592) ;Click Upgrade Button
	If _Sleep(2000) Then Return
	Click(578, 512) ;Click Confirm Button
	If _Sleep(500) Then Return
		_CaptureRegion()
	If _ColorCheck(_GetPixelColor(743, 152), Hex(0xE51016, 6), 20) Then ;red arrow
		SetLog(GetLangText("msgHeroesMaxLvl"), $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		GUICtrlSetState($chkUpgradeKing, $GUI_UNCHECKED)
		If _Sleep(500) Then Return
	Else
		SetLog(GetLangText("msgQueenUpgraded"), $COLOR_BLUE)
		If _Sleep(1000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf
EndIf
EndFunc