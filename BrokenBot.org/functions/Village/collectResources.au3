; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func collectResources()
	Local $i, $j = 0
	Local $foundResource = False
	If $ichkCollect = 1 Then
		SetLog(GetLangText("msgCollecting"), $COLOR_BLUE)
		Do
			_CaptureRegion()
			$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
			$res = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotMatchObject", "ptr", $sendHBitmap, "int", 27, "int", 3, "int", 17, "int", 1, "int", (IsChecked($chkSpeedBoost) ? (1) : (0)))
			_WinAPI_DeleteObject($sendHBitmap)
			If IsArray($res) Then
				If $res[0] = -2 Then
					SetLog(GetLangText("msgLicense"), $COLOR_RED)
				ElseIf $res[0] = -1 And Not $foundResource Then
					; failed to find Resources
					SetLog(GetLangText("msgNoResources"), $COLOR_RED)
					$ResX = 0
					$ResY = 0
					ExitLoop
				Else
					$expRet = StringSplit($res[0], "|", 2)
					$numBldg = $expRet[0]
					For $j = 1 To UBound($expRet) - 1 Step 6
						$ResX = $expRet[$j]
						$ResY = $expRet[$j + 1]
						If $ResX = 0 And $ResY = 0 Then ExitLoop
						If $DebugMode = 1 Then SetLog("Total " & $numBldg & " Resources. X:" & $ResX & " Y:" & $ResY)
						Click($ResX, $ResY)
						Click(1, 1)
						Sleep(300)
					Next
					$foundResource = True
				EndIf
			Else
				SetLog(GetLangText("msgDLLError"), $COLOR_RED)
				$ResX = 0
				$ResY = 0
				Return False ; return 0
			EndIf
			$i += 1
		Until $i = 2
	EndIf
	Return
EndFunc   ;==>collectResources
