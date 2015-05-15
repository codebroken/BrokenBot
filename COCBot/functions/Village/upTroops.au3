#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.12.0
	Author:         summoner

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

Func GetUpLaboratoryPos()
	Switch _GUICtrlComboBox_GetCurSel($cmbLaboratory)
		Case 0
			Click($UpBar2X, $UpBar2Y)
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(132, 362), Hex(0x303030, 6), 20) Then
				SetLog(GetLangText("msgLabLevelTroop") & GUICtrlRead($cmbLaboratory) & GetLangText("msgLabLevelMax"), $COLOR_RED)
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
				GUICtrlSetState($chkLab, $GUI_UNCHECKED)
			EndIf
		Case 1
			Click($UpArchX, $UpArchY)
		Case 2
			Click($GiantsX, $GiantsY)
		Case 3
			Click(293, 480) ; Goblin
		Case 4
			Click(387, 461) ; Ballon
		Case 5
			Click($WBreakerX, $WBreakerY)
		Case 6
			Click($WizardX, $WizardY)
		Case 7
			Click($UpHealX, $UpHealY)
		Case 8
			Click($UpDragonX, $UpDragonY)
		Case 9
			Click($UpPekkaX, $UpPekkaY)
		Case 10
			Click($SpellHealX, $SpellHealY)
		Case 11
			Click($SpellLightningX, $SpellLightningY)
		Case 12
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(261, 377) ; rage
		Case 13
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(282, 470) ; jump
		Case 14
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(370, 366) ; freeze
		Case 15
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(370, 474) ; minion
		Case 16
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(488, 477) ; hog
		Case 17
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(591, 364) ; valkrye
		Case 18
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(590, 474); golem
		Case 19
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(578, 474) ; witch
		Case 20
			_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
			Sleep(1000)
			Click(690, 368) ; lava
		Case 21
			GUICtrlSetState($chkLab, $GUI_UNCHECKED)

	EndSwitch
EndFunc   ;==>GetUpLaboratoryPos

Func Laboratory()
	If Not IsChecked($chkLab) Then
		SetLog(GetLangText("msgLabSkipped"), $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf
	If $LabPos[0] = "" Or $LabPos[1] = "" Then
		SetLog(GetLangText("msgLabLocNotSet"), $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf
	Click($LabPos[0], $LabPos[1]);Click Laboratory
	If _Sleep(1000) Then Return
	SetLog(GetLangText("msgLabSearching") & GUICtrlRead($cmbLaboratory) & "...", $COLOR_BLUE)
	Click(527, 597) ; Click Button Research
	If _Sleep(1000) Then Return
	GetUpLaboratoryPos() ; Click Troops
	SetLog(GetLangText("msgLabTroopSearch") & GUICtrlRead($cmbLaboratory) & GetLangText("msgLabTroopFound"), $COLOR_GREEN)
	If _Sleep(1000) Then Return
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(535, 506), Hex(0x868686, 6), 20) Or _ColorCheck(_GetPixelColor(580, 511), Hex(0x848484, 6), 20) Then
		SetLog(GetLangText("msgLabWaiting") & GUICtrlRead($cmbLaboratory) & GetLangText("msgLabAfter"), $COLOR_RED)
		If _Sleep(1000) Then Return
		ClickP($TopLeftClient, 2)
	Else
		If _ColorCheck(_GetPixelColor(558, 489), Hex(0xE70A12, 6), 20) Or _ColorCheck(_GetPixelColor(558, 489), Hex(0xE70A12, 6), 20) Then
			SetLog(GetLangText("msgLabLowElix") & GUICtrlRead($cmbLaboratory) & "...", $COLOR_RED)
			If _Sleep(1000) Then Return
			ClickP($TopLeftClient, 2)
		Else
			If _ColorCheck(_GetPixelColor(558, 489), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(577, 498), Hex(0x2A2A2A, 6), 20) Then
				SetLog(GetLangText("msgLabLowDE") & GUICtrlRead($cmbLaboratory) & "...", $COLOR_RED)
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
			Else
				If _ColorCheck(_GetPixelColor(558, 489), Hex(0xFFFFFF, 6), 20) = True Then
					Click(558, 489) ; Click Upgrade troops
					SetLog(GetLangText("msgLabUpgrade") & GUICtrlRead($cmbLaboratory) & GetLangText("msgLabDone"), $COLOR_GREEN)
					If _Sleep(1000) Then Return
					ClickP($TopLeftClient, 2)
					GUICtrlSetState($chkLab, $GUI_UNCHECKED)
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc   ;==>Laboratory
