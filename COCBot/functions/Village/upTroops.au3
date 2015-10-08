#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.12.0
	Author:         summoner

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
; Script Start - Add your code below here

Func GetUpLaboratoryPos()
	If _GUICtrlComboBox_GetCurSel($cmbLaboratory) = 24 Then
		GUICtrlSetState($chkLab, $GUI_UNCHECKED)
	Else
		If _GUICtrlComboBox_GetCurSel($cmbLaboratory) > 11 Then
			$i=0
			Do
				_PostMessage_ClickDrag(725, 464, 3, 492, "left", 500)
				_ModifiedSleep(1000)
				$i += 1
				_CaptureRegion()
			Until _ColorCheck(_GetPixelColor(123, 409), Hex(0xAAAAA4, 6), 20) Or $i=20
		EndIf
		Click(133 + Floor(_GUICtrlComboBox_GetCurSel($cmbLaboratory)/2)*106-Floor(_GUICtrlComboBox_GetCurSel($cmbLaboratory)/12)*636, 330 + Mod(_GUICtrlComboBox_GetCurSel($cmbLaboratory), 2)*115)
	EndIf
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
	Click(507, 597) ; Click Button Research
	If _Sleep(3000) Then Return
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
