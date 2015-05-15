; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
;Searches for a village that until meets conditions
Func IsChecked($control)
	Return BitAND(GUICtrlRead($control), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>IsChecked

Func _ScreenShot()
	Local $Date = @MDAY & "." & @MON & "." & @YEAR
	Local $Time = @HOUR & "." & @MIN & "." & @SEC
	_CaptureRegion()
	SetLog($dirDebug & "ScreenShot-" & $Date & " at " & $Time & ".png")
	_GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "ScreenShot-" & $Date & " at " & $Time & ".png")
EndFunc   ;==>_ScreenShot

Func _BumpMouse()
	If IsChecked($chkStayAlive) Then
		If $shift Then
			$shift = False
			MouseMove(MouseGetPos(0) + 1, MouseGetPos(1))
		Else
			$shift = True
			MouseMove(MouseGetPos(0) - 1, MouseGetPos(1))
		EndIf
	EndIf
EndFunc   ;==>_BumpMouse

Func _WaitForImage($findImage, $resultPosition, ByRef $x, ByRef $y, $Tolerance, $maxDelay = 10)
	For $i = 1 To $maxDelay * 20
		$result = _ImageSearch($findImage, $resultPosition, $x, $y, $Tolerance)
		If $result = 1 Then Return 1
		If _Sleep(50) Then Return
	Next
	Return 0
EndFunc   ;==>_WaitForImage

Func _WaitForImageArea($findImage, $resultPosition, $x1, $y1, $right, $bottom, ByRef $x, ByRef $y, $Tolerance, $maxDelay = 10)
	For $i = 1 To $maxDelay * 20
		$result = _ImageSearchArea($findImage, $resultPosition, $x1, $y1, $right, $bottom, $x, $y, $Tolerance)
		If $result = 1 Then Return 1
		If _Sleep(50) Then Return
	Next
	Return 0
EndFunc   ;==>_WaitForImageArea

Func _WaitForColor($x, $y, $nColor2, $sVari = 5, $maxDelay = 1)
	For $i = 1 To $maxDelay * 20
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor($x, $y), $nColor2, $sVari) Then
			Return True
		EndIf
		If _Sleep(50) Then Return
	Next
	Return False
EndFunc   ;==>_WaitForColor

Func _WaitForPixel($iLeft, $iTop, $iRight, $iBottom, $iColor, $iColorVariation, $maxDelay = 10)
	For $i = 1 To $maxDelay * 20
		$result = _PixelSearch($iLeft, $iTop, $iRight, $iBottom, $iColor, $iColorVariation)
		If IsArray($result) Then Return $result
		If _Sleep(50) Then Return
	Next
	Return False
EndFunc   ;==>_WaitForPixel

Func GetLangText($Key)
	$ReturnStr = ""
	If IsDeclared("cmbLanguage") Then
		$ReturnStr = IniRead(@ScriptDir & "\BrokenBot.org\languages\" & _GUICtrlComboBox_GetEditText($cmbLanguage) & ".ini", "general", $Key, "")
		If $ReturnStr = "" Then
			;MsgBox(0,"",$Key & " not found in " & _GUICtrlComboBox_GetEditText($cmbLanguage))
			$ReturnStr = IniRead(@ScriptDir & "\BrokenBot.org\languages\English.ini", "general", $Key, "")
			;If $ReturnStr = "" Then MsgBox(0,"",$Key & " not found in English")
		EndIf
	Else
		$ReturnStr = IniRead(@ScriptDir & "\BrokenBot.org\languages\" & $StartupLanguage & ".ini", "general", $Key, "")
		If $ReturnStr = "" Then
			;MsgBox(0,"",$Key & " not found in " & $StartupLanguage)
			$ReturnStr = IniRead(@ScriptDir & "\BrokenBot.org\languages\English.ini", "general", $Key, "")
			;If $ReturnStr = "" Then MsgBox(0,"",$Key & " not found in English")
		EndIf
	EndIf
	Return $ReturnStr
EndFunc

Func PopulateLanguages()
	$searchfile = FileFindFirstFile(@ScriptDir & "\BrokenBot.org\languages\*.ini")
	$txtLang = ""
	While True
		$newfile = FileFindNextFile($searchfile)
		If @error Then ExitLoop
		$txtLang = $txtLang & StringLeft($newfile, StringLen($newfile)-4) & "|"
	WEnd
	FileClose($searchfile)
	$txtLang = StringLeft($txtLang, StringLen($txtLang) - 1)
	_GUICtrlComboBox_ResetContent($cmbLanguage)
	GUICtrlSetData($cmbLanguage, $txtLang)
EndFunc