; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
;Function needed by all strategies


;Check Out of Sync or Disconnection, if detected, bump speedBump by 0.5 seconds
Func ChkDisconnection($disconnected = False)
	_CaptureRegion()
	Local $dummyX = 0
	Local $dummyY = 0
	If _ImageSearch(@ScriptDir & "\images\Client.bmp", 1, $dummyX, $dummyY, 50) = 1 Then
		If $dummyX > 290 And $dummyX < 310 And $dummyY > 325 And $dummyY < 340 Then
			$disconnected = True
			$speedBump += 500
			If $speedBump > 5000 Then
				$speedBump = 5000
				SetLog("Out of sync! Already searching slowly, not changing anything.", $COLOR_RED)
			Else
				SetLog("Out of sync! Slowing search speed by 0.5 secs.", $COLOR_RED)
			EndIf
		EndIf
	EndIf
	If _ImageSearch(@ScriptDir & "\images\Lost.bmp", 1, $dummyX, $dummyY, 50) = 1 Then
		If $dummyX > 320 and $dummyX < 350 and $dummyY > 330 and $dummyY < 350 Then
			$disconnected = True
			$speedBump += 500
			If $speedBump > 5000 Then
				$speedBump=5000
				SetLog("Lost Connection! Already searching slowly, not changing anything.", $COLOR_RED)
			Else
				SetLog("Lost Connection! Slowing search speed by 0.5 secs.", $COLOR_RED)
			EndIf
		EndIf
	EndIf

	If $disconnected = True Then
		;increase disconnect counts
		GUICtrlSetData($lblresultsearchdisconnected, GUICtrlRead($lblresultsearchdisconnected) + 1)
		If $DebugMode = 1 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "DisConnt-" & @HOUR & @MIN & @SEC & ".png")
		If $PushBulletEnabled = 1 Then

			Local $iCount = _FileCountLines($sLogPath)
			Local $myLines = ""
			Local $i
			For $i = 1 to 5
				$myLines = $myLines &  FileReadLine($sLogPath, ($iCount - 5 + $i)) & "\n"
			Next
			_Push("Disconnected", "Your bot got disconnected while searching for enemy, total disconnections:" & GUICtrlRead($lblresultsearchdisconnected) & "\n" & _
				"Last 5 lines of log:\n" & $myLines)
		EndIf
	EndIf
	Return $disconnected
EndFunc