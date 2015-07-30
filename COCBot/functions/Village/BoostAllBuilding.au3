;==>BoostBarracks
Func BoostAllBuilding()
	$BoostAll = 0
	If (GUICtrlRead($cmbBoostBarracks) > 0) And ($boostsEnabled = 1) Then

		If $barrackPos[0][0] = "" Then
		If Not LocateBarrack() Then Return
			SaveConfig()
			If _Sleep(2000) Then Return
		EndIf

		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
		If _Sleep(500) Then Return

		If GUICtrlRead($chkBoostRax1) = 1 Then; Barrack 1
			SetLog(GetLangText("msgBoostingBarrack") & "1...", $COLOR_BLUE)
			Click($barrackPos[0][0], $barrackPos[0][1]) ;Click Barrack 1
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostRax2) = 1 Then; Barrack 2
			SetLog(GetLangText("msgBoostingBarrack") & "2...", $COLOR_BLUE)
			Click($barrackPos[1][0], $barrackPos[1][1]) ;Click Barrack 2
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostRax3) = 1 Then; Barrack 3
			SetLog(GetLangText("msgBoostingBarrack") & "3...", $COLOR_BLUE)
			Click($barrackPos[2][0], $barrackPos[2][1]) ;Click Barrack 3
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostRax4) = 1 Then; Barrack 4
			SetLog(GetLangText("msgBoostingBarrack") & "4...", $COLOR_BLUE)
			Click($barrackPos[3][0], $barrackPos[3][1]) ;Click Barrack 4
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostDB1) = 1 Then; Dark Barrack 1
			SetLog(GetLangText("msgBoostingDark") & "1...", $COLOR_BLUE)
			Click($DarkBarrackPos[0][0], $DarkBarrackPos[0][1]) ;Click Dark Barrack 1
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostDB2) = 1 Then; Dark Barrack 2
			SetLog(GetLangText("msgBoostingDark") & "2...", $COLOR_BLUE)
			Click($DarkBarrackPos[1][0], $DarkBarrackPos[1][1]) ;Click Dark Barrack 2
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostKing) = 1 Then; King Altar
			If $KingPos[0] = "" Then
				If Not LocateKingAltar() Then Return
				SaveConfig()
				If _Sleep(2000) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf
			SetLog(GetLangText("msgBoostingKing"), $COLOR_BLUE)
			Click($KingPos[0], $KingPos[1]) ;Click King Altar
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostQueen) = 1 Then; Queen Altar
			If $QueenPos[0] = "" Then
				If Not LocateQueenAltar() Then Return
				SaveConfig()
				If _Sleep(2000) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf
			SetLog(GetLangText("msgBoostingQueen"), $COLOR_BLUE)
			Click($QueenPos[0], $QueenPos[1]) ;Click Queen Altar
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If GUICtrlRead($chkBoostSpell) = 1 Then; Spell Factory
			If $SpellPos[0] = "" Then
				If Not LocateSpellFactory() Then Return
				SaveConfig()
				If _Sleep(2000) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf
			SetLog(GetLangText("msgBoostingSpell"), $COLOR_BLUE)
			Click($SpellPos[0], $SpellPos[1]) ;Click Spell Factory
			If _Sleep(500) Then Return
			BoostSpells()
		EndIf

		If $BoostAll >= 1 Then
			_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, (GUICtrlRead($cmbBoostBarracks) - 1))
			SetLog(GetLangText("msgBoostRem") & GUICtrlRead($cmbBoostBarracks), $COLOR_GREEN)
		EndIf
	EndIf
EndFunc   ;==>BoostAllBuilding

Func BoostBuilding()
	_CaptureRegion()
	Local $Boost = _PixelSearch(355, 608, 362, 610, Hex(0xA1A084, 6), 10) ;Check Boost
	If IsArray($Boost) Then
		Click(355, 608) ;Click Boost
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(420, 375), Hex(0xd2ec78, 6), 20) Then ;Confirm Message
			Click(420, 375)
			If _Sleep(2000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then ;Not enough Gem
				_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, 0)
				SetLog(GetLangText("msgNotEnoughGem"), $COLOR_RED)
			Else
				SetLog(GetLangText("msgBoostComplete"), $COLOR_GREEN)
				$BoostAll += 1
			EndIf
		Else
			SetLog(GetLangText("msgAlreadyBooster"), $COLOR_ORANGE)
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		SetLog(GetLangText("msgAlreadyBooster"), $COLOR_ORANGE)
		If _Sleep(1000) Then Return
	EndIf
EndFunc   ;==>BoostBuilding

Func BoostSpells()
	_CaptureRegion()
	Local $Boost = _PixelSearch(355, 608, 362, 610, Hex(0xA1A084, 6), 10) ;Check Boost
	If IsArray($Boost) Then
		If GUICtrlRead($txtSpellCap) = 5 Then
			Click(430, 608) ;Click Boost for Spell Factory lvl5
		Else
			Click(355, 608) ;Click Boost for Not Spell Factory lvl5
		EndIf
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(420, 375), Hex(0xd2ec78, 6), 20) Then ;Confirm Message
			Click(420, 375)
			If _Sleep(2000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then ;Not enough Gem
				_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, 0)
				SetLog(GetLangText("msgNotEnoughGem"), $COLOR_RED)
			Else
				SetLog(GetLangText("msgBoostComplete"), $COLOR_GREEN)
				$BoostAll += 1
			EndIf
		Else
			SetLog(GetLangText("msgSpellsAlready"), $COLOR_ORANGE)
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		SetLog(GetLangText("msgSpellsAlready"), $COLOR_ORANGE)
		If _Sleep(1000) Then Return
	EndIf
EndFunc   ;==>BoostSpells
