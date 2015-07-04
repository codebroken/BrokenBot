; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func clearField()
	Local $j, $numObstacle, $numCleared = 0
	If $iClearField = 1 Then
		SetLog(GetLangText("msgClearField"), $COLOR_BLUE)
		If $FreeBuilder < 1 Then
			SetLog(GetLangText("msgNoBuilders"), $COLOR_RED)
			Return
		EndIf
		$hDLL = DllOpen(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll")
		_CaptureRegion()
		$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
		$res = DllCall($hDLL, "str", "BrokenBotMatchObject", "ptr", $sendHBitmap, "int", 25, "int", 3, "int", 5, "int", 4, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
		_WinAPI_DeleteObject($sendHBitmap)
		If IsArray($res) Then
			If $res[0] = -1 Then
				; failed to find any obstacles to clear on the field
				SetLog(GetLangText("msgNoClearField"), $COLOR_RED)
			ElseIf $res[0] = -2 Then
				SetLog(GetLangText("msgLicense"), $COLOR_RED)
			Else
				$expRet = StringSplit($res[0], "|", 2)
				$numObstacle = $expRet[0]
				If $DebugMode = 1 Then SetLog("Total " & $numObstacle & " Obstacles.")
				For $j = 1 To UBound($expRet) - 1 Step 6
					$ObsX = $expRet[$j]
					$ObsY = $expRet[$j + 1]
					If $ObsX = 0 And $ObsY = 0 Then ExitLoop
					If $ObsY < 65 Then
						If $DebugMode = 1 Then SetLog("Obstacle unable to be clicked: " & $ObsX & ", " & $ObsY)
						ExitLoop
					EndIf
					If $ObsX < 70 Then
						If $DebugMode = 1 Then SetLog("Obstacle unable to be clicked: " & $ObsX & ", " & $ObsY)
						ExitLoop
					EndIf
					_Sleep(300)
					Click($ObsX, $ObsY)
					_Sleep(1000)
					_CaptureRegion()
					$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
					$resUI = DllCall($hDLL, "str", "BrokenBotMatchButton", "ptr", $sendHBitmap, "int", 110, "int", 3, "int", 1, "int", 3, "int", (IsChecked($chkSpeedBoost) ? (1) : (0))) ; remove icon
					_WinAPI_DeleteObject($sendHBitmap)
					If IsArray($resUI) Then
						If $resUI[0] = -1 Or $resUI[0] = -2 Then ExitLoop
						$expUIRet = StringSplit($resUI[0], "|", 2)
						If $DebugMode = 1 Then SetLog("Obstacle X:" & $expUIRet[1] & " Y:" & $expUIRet[2])
						_Sleep(300)
						Click($expUIRet[1], $expUIRet[2])
						$numCleared += 1
						$UIWait = 0
						Do
							_Sleep(300)
							_CaptureRegion()
							$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
							$resUI = DllCall($hDLL, "str", "BrokenBotMatchButton", "ptr", $sendHBitmap, "int", 111, "int", 3, "int", 1, "int", 3, "int", (IsChecked($chkSpeedBoost) ? (1) : (0))) ; cancel build icon
							_WinAPI_DeleteObject($sendHBitmap)
							$expUIRet = StringSplit($resUI[0], "|", 2)
							If $expUIRet[0] = -1 Or $expUIRet[0] = -2 Then ExitLoop
							_Sleep(5000)
							$UIWait += 1
						Until $UIWait = 12
					Else
						DllClose($hDLL)
						SetLog(GetLangText("msgDLLError"), $COLOR_RED)
						Return False ; return 0
					EndIf
				Next
			EndIf
		Else
			DllClose($hDLL)
			SetLog(GetLangText("msgDLLError"), $COLOR_RED)
			Return False ; return 0
		EndIf
		If $numCleared > 0 Then
			SetLog(GetLangText("msgClearedField") & $numCleared, $COLOR_BLUE)
		EndIf
		DllClose($hDLL)
	EndIf
	Return
EndFunc   ;==>clearField
