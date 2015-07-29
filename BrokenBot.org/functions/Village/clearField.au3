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

		$res = CallHelper("0 0 860 720 BrokenBotMatchObject 25 5 4")

		If $res <> $DLLFailed And $res <> $DLLTimeout Then
			If $res = $DLLNegative Then
				; failed to find any obstacles to clear on the field
				SetLog(GetLangText("msgNoClearField"), $COLOR_RED)
			ElseIf $res = $DLLLicense Then
				SetLog(GetLangText("msgLicense"), $COLOR_RED)
			Else
				$expRet = StringSplit($res, "|", 2)
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

					$resUI = CallHelper("0 0 860 720 BrokenBotMatchButton 110 1 3")

					If $resUI <> $DLLFailed And $resUI <> $DLLTimeout Then
						If $resUI = -1 Or $resUI = -2 Then ExitLoop
						$expUIRet = StringSplit($resUI, "|", 2)
						If $DebugMode = 1 Then SetLog("Obstacle X:" & $expUIRet[1] & " Y:" & $expUIRet[2])
						_Sleep(300)
						Click($expUIRet[1], $expUIRet[2])
						$numCleared += 1
						$UIWait = 0
						Do
							_Sleep(300)

							$resUI = CallHelper("0 0 860 720 BrokenBotMatchButton 111 1 3")

							$expUIRet = StringSplit($resUI, "|", 2)
							If $expUIRet[0] = -1 Or $expUIRet[0] = -2 Then ExitLoop
							_Sleep(5000)
							$UIWait += 1
						Until $UIWait = 12
					Else
						SetLog(GetLangText("msgDLLError"), $COLOR_RED)
						Return False ; return 0
					EndIf
				Next
			EndIf
		Else
			SetLog(GetLangText("msgDLLError"), $COLOR_RED)
			Return False ; return 0
		EndIf
		If $numCleared > 0 Then
			SetLog(GetLangText("msgClearedField") & $numCleared, $COLOR_BLUE)
		EndIf
	EndIf
	Return
EndFunc   ;==>clearField
